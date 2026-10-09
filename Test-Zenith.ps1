# Smoke test for Zenith.ps1 - read-only, no admin, no window. Run: powershell -ExecutionPolicy Bypass -File .\Test-Zenith.ps1
$ErrorActionPreference = 'Stop'
$path = Join-Path $PSScriptRoot 'Zenith.ps1'
$src  = Get-Content -LiteralPath $path -Raw
$fail = 0
function Check($ok, $what) { if ($ok) { "  ok    $what" } else { "  FAIL  $what"; $script:fail++ } }

# 1. syntax + ASCII (Windows PowerShell 5.1 reads BOM-less files as ANSI)
$errs = $null; [void][Management.Automation.Language.Parser]::ParseInput($src, [ref]$null, [ref]$errs)
Check ($errs.Count -eq 0) "script parses ($($errs.Count) errors)"
Check (-not ([IO.File]::ReadAllBytes($path) | Where-Object { $_ -gt 127 })) 'script is pure ASCII'

# 2. XAML loads and every $ui.Name the code uses exists
Add-Type -AssemblyName PresentationFramework
[xml]$xaml = [regex]::Match($src, "(?s)\[xml\]\`$MainXaml = @'\r?\n(.*?)\r?\n'@").Groups[1].Value
$win = [Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xaml))
$used  = [regex]::Matches($src, '\$ui\.(\w+)') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
$missing = @($used | Where-Object { -not $win.FindName($_) })
Check ($null -ne $win -and $missing.Count -eq 0) "XAML loads, all `$ui names exist $(if ($missing) { "(missing: $($missing -join ', '))" })"

# 3. engine + catalog + scanner, cut out of the script between its section markers
$a = $src.IndexOf('# ---------------------------------------------------------------- registry helpers')
$b = $src.IndexOf('# ================================================================ UI (XAML)')
$adapt = [regex]::Match($src, '(?s)\nfunction Set-AdaptiveRecommendations \{.*?\r?\n\}').Value
if ($a -lt 0 -or $b -lt $a -or -not $adapt) { throw 'Section markers not found in Zenith.ps1' }
$engine = [scriptblock]::Create($src.Substring($a, $b - $a) + $adapt)
function Write-Log { }
$tmp = Join-Path ([IO.Path]::GetTempPath()) "zenith-test-$PID"; New-Item -ItemType Directory -Force $tmp | Out-Null
$DataDir = $tmp; $GamesFile = "$tmp\games.json"; $SessionFile = "$tmp\session.json"; $BenchFile = "$tmp\bench.json"

. $engine
$script:SysInfo = Get-SystemInfo
$s = $script:SysInfo
"  this PC: $($s.CpuName) | $($s.GpuName) ($($s.GpuVendor), $($s.GpuVram)) | $($s.RamType) $($s.RamSpeed) | laptop=$($s.IsLaptop) xmpOff=$($s.XmpOff)"
Check ($s.GpuName -ne 'Unknown GPU') 'a GPU was detected'
Set-AdaptiveRecommendations
$hc = @(Get-HealthChecks)
Check ($hc.Count -ge 5 -and -not ($hc | Where-Object { -not $_.Title -or -not $_.Text })) "$($hc.Count) health checks, all with title and text"
$hc | ForEach-Object { "          $(if ($_.Ok) { '[ok]  ' } else { '[warn]' }) $($_.Title)" }
$live = @{}; foreach ($t in $script:Tweaks) { $live[$t.Id] = Test-Tweak $t }
$bad = @($script:Tweaks | Where-Object { $live[$_.Id] -notin 'On', 'Off', 'NA' })
Check ($bad.Count -eq 0) "all $($script:Tweaks.Count) tweaks report On/Off/NA"
$cached = Test-AllTweaks
$diff = @($script:Tweaks | Where-Object { $cached[$_.Id] -ne $live[$_.Id] } | ForEach-Object Id)
Check ($diff.Count -eq 0) "cached full check matches live checks $(if ($diff) { "(differs: $($diff -join ', '))" })"

# 4. adaptive recommendations for other kinds of PC (fake scan results, fresh catalog each time)
foreach ($case in @(
        @{ Name = 'laptop';       Info = @{ IsLaptop = $true;  CpuName = 'Intel Core i7-12700H' }; NotRec = 'pwr_plan', 'pwr_coreparking', 'pwr_minstate', 'pwr_hibernate' },
        @{ Name = 'Ryzen desktop'; Info = @{ IsLaptop = $false; CpuName = 'AMD Ryzen 7 7800X3D' };  NotRec = 'pwr_plan', 'pwr_coreparking', 'pwr_minstate' },
        @{ Name = 'Intel desktop'; Info = @{ IsLaptop = $false; CpuName = 'Intel Core i5-6500' };   Rec = 'pwr_plan', 'pwr_coreparking', 'pwr_minstate' })) {
    . $engine
    $script:SysInfo = [pscustomobject](@{ SystemIsSSD = $true; SystemIsHDD = $false; Disks = @(); RamBytes = 16GB; HvciOn = $false } + $case.Info)
    Set-AdaptiveRecommendations
    $wrong = @($case.NotRec | Where-Object { (Get-Tweak $_).Rec }) + @($case.Rec | Where-Object { $_ -and -not (Get-Tweak $_).Rec })
    Check ($wrong.Count -eq 0) "$($case.Name): power tweaks recommended correctly $(if ($wrong) { "(wrong: $($wrong -join ', '))" })"
}

# 5. temp cleaner: empties nested folders (read-only files too) but never follows a junction out of the folder
. $engine
$root = Join-Path $tmp 'clean'; $keep = Join-Path $tmp 'keep'
New-Item -ItemType Directory -Force "$root\sub\deeper", $keep | Out-Null
Set-Content "$root\a.txt" ('x' * 100); Set-Content "$root\sub\b.txt" ('y' * 200); Set-Content "$root\sub\deeper\c.txt" ('z' * 300)
Set-ItemProperty "$root\sub\deeper\c.txt" -Name IsReadOnly -Value $true
Set-Content "$keep\sentinel.txt" 'must survive'
cmd /c mklink /J "$root\link" "$keep" | Out-Null
$expect = (Get-ChildItem $root -Recurse -File -Exclude sentinel.txt | Where-Object { $_.FullName -notlike "$root\link\*" } | Measure-Object Length -Sum).Sum
$freed = Clear-Folders @($root)
Check ($freed -eq $expect -and -not (Test-Path "$root\sub") -and -not (Test-Path "$root\a.txt") -and (Test-Path $root)) "cleaner emptied the folder ($freed of $expect bytes)"
Check (Test-Path "$keep\sentinel.txt") 'cleaner did not follow the junction'
[IO.Directory]::Delete("$root\link")

# 6. the real background worker boots from this file and answers jobs (data folder redirected to temp)
$env:ProgramData = Join-Path $tmp 'programdata'
function Wait-Result($w, [int]$sec) { $r = $null; $t = [Diagnostics.Stopwatch]::StartNew(); while (-not $w.Results.TryDequeue([ref]$r) -and $t.Elapsed.TotalSeconds -lt $sec) { Start-Sleep -Milliseconds 100 }; $r }
$worker = Start-Worker $src
$worker.Jobs.Add(@{ Kind = 'scan' }); $r = Wait-Result $worker 120
Check ($r -and -not $r.Error -and $r.States.Count -eq $script:Tweaks.Count -and $r.Data.CpuName) "worker scan returned $(if ($r) { $r.States.Count } else { 'nothing' }) tweak states $(if ($r.Error) { "(error: $($r.Error))" })"
Set-Content "$root\d.txt" ('w' * 50); $size = (Get-Item "$root\d.txt").Length
$worker.Jobs.Add(@{ Kind = 'clean'; Paths = @($root) }); $r = Wait-Result $worker 30
Check ($r -and $r.Data -eq $size -and -not (Test-Path "$root\d.txt")) "worker clean job ran in the background ($($r.Data) of $size bytes)"
$worker.Jobs.CompleteAdding(); $t = [Diagnostics.Stopwatch]::StartNew(); while (-not $worker.Handle.IsCompleted -and $t.Elapsed.TotalSeconds -lt 10) { Start-Sleep -Milliseconds 100 }
Check ($worker.Handle.IsCompleted -and $worker.PS.Streams.Error.Count -eq 0) "worker shut down cleanly $(if ($worker.PS.Streams.Error.Count) { "(errors: $($worker.PS.Streams.Error[0]))" })"
$worker.PS.Dispose()

# 7. new features on throwaway locations (test registry keys under HKCU, temp folders, stubbed system calls)
. $engine
$reg = 'HKCU:\Software\ZenithTest'
$IFEO = "$reg\IFEO"; $GPUPREF = "$reg\Gpu"
Set-StartupApp "$reg\Approved" 'app' $false; $off = (Get-RegValue "$reg\Approved" 'app').Value
Set-StartupApp "$reg\Approved" 'app' $true;  $on  = (Get-RegValue "$reg\Approved" 'app').Value
Check ($off[0] -eq 3 -and $off.Length -eq 12 -and $on[0] -eq 2) 'startup toggle writes the Task Manager flag (03 off / 02 on)'
Check (@(Get-StartupApps).Count -gt 0 -and -not (Get-StartupApps | Where-Object { $_.Enabled -isnot [bool] })) "startup apps listed ($(@(Get-StartupApps).Count))"

$exe = "$tmp\Game\Bin\Game-Win64-Shipping.exe"
Set-RegValue $GPUPREF $exe 'String' 'AppStatus=0;'
$added = Add-GameEntry @{ Name = 'Game'; Exe = 'Game-Win64-Shipping.exe'; Path = $exe }
$gpu = (Get-RegValue $GPUPREF $exe).Value; $prio = (Get-RegValue "$IFEO\Game-Win64-Shipping.exe\PerfOptions" 'CpuPriorityClass').Value
Check ($added -and $prio -eq 3 -and $gpu -eq 'AppStatus=0;GpuPreference=2;') "game added: priority + GPU preference merged ($gpu)"
Check (-not (Add-GameEntry @{ Name = 'Game'; Exe = 'Game-Win64-Shipping.exe'; Path = $exe })) 'same game is not added twice'
Remove-GameEntry 'Game-Win64-Shipping.exe'
Check ((Get-RegValue $GPUPREF $exe).Value -eq 'AppStatus=0;' -and -not (Test-Path "$IFEO\Game-Win64-Shipping.exe") -and -not @(Get-GameList).Count) 'game removed: GPU value and priority restored exactly'
Remove-Item $reg -Recurse -Force

New-Item -ItemType Directory -Force "$tmp\ue\Game\Binaries\Win64", "$tmp\unity\Cool_Data" | Out-Null
Set-Content "$tmp\ue\Launcher.exe" ('x' * 9000); Set-Content "$tmp\ue\Game\Binaries\Win64\Game-Win64-Shipping.exe" 'x'
Set-Content "$tmp\unity\Cool.exe" 'x'; Set-Content "$tmp\unity\UnityCrashHandler64.exe" ('x' * 9000); Set-Content "$tmp\unity\Big.exe" ('x' * 5000)
Check ((Find-GameExe "$tmp\ue") -like '*Game-Win64-Shipping.exe' -and (Find-GameExe "$tmp\unity") -like '*\Cool.exe') 'game exe picker: Unreal shipping exe and Unity exe beat bigger helpers'

$st = Get-FpsStats (@(1..990 | ForEach-Object { 5.0 }) + @(1..10 | ForEach-Object { 25.0 }))
Check ($st.Frames -eq 1000 -and $st.Low1 -eq 40 -and $st.Avg -gt 190) "FPS maths: avg $($st.Avg), 1% low $($st.Low1)"
Set-Content "$tmp\p.json" '{"App":"Zenith","Tweaks":["fps_gamedvr","not_a_tweak",42]}'; Set-Content "$tmp\bad.json" '{"Tweaks":["fps_gamedvr"]}'
$ids = @(Read-ZenithProfile "$tmp\p.json"); $rej = $false; try { Read-ZenithProfile "$tmp\bad.json" | Out-Null } catch { $rej = $true }
Check ($ids.Count -eq 1 -and $ids[0] -eq 'fps_gamedvr' -and $rej) 'profile import keeps only known tweak ids and rejects foreign files'

$script:SysInfo = [pscustomobject]@{ GpuName = 'RTX'; IsLaptop = $false; Displays = @(
    [pscustomobject]@{ Gpu = 'iGPU'; ResX = 2560; ResY = 1440; Refresh = 240; MaxRefresh = 0 },
    [pscustomobject]@{ Gpu = 'RTX'; ResX = 1920; ResY = 1080; Refresh = 144; MaxRefresh = 144 }); Volumes = @(); BusyApps = @(); CpuHogs = @() }
Check (@(Get-HealthChecks | Where-Object { $_.Title -eq 'Monitor is plugged into the motherboard' }).Count -eq 1) 'health check: main monitor on the motherboard is flagged'

$SessionApps = @(); $SessionServices = @(); function Get-FocusManager { $null }   # no real apps, services or DND touched
$on = Start-GameSession; $mid = Test-Path $SessionFile; $off = Stop-GameSession
Check ($on.Started -and $mid -and $off.Started -eq $on.Started -and -not (Test-Path $SessionFile)) 'game session state is saved and cleared'
Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue

if ($fail) { "`n$fail check(s) failed"; exit 1 } else { "`nAll checks passed" }
