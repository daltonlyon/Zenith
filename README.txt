ZENITH 2.1  -  FPS & latency optimizer for Windows 10 / 11
=====================================================================
(Formerly FrameForge. On first launch Zenith copies FrameForge's backups
from C:\ProgramData\FrameForge, so earlier tweaks can still be reverted.)

Works on any gaming PC. It scans the hardware on launch and adapts its
recommendations: desktop or laptop, Intel or AMD Ryzen CPU, NVIDIA / AMD /
Intel graphics, SSD or hard drive, and how much RAM is installed.


USING IT ON SEVERAL PCs
-----------------------
Copy the whole Zenith folder (USB stick, cloud drive, zip) to each PC and
run "Launch Zenith.bat" there. Every PC keeps its own backup and log in
its own C:\ProgramData\Zenith, so "Revert all" on one PC never touches
another.

What changes per PC:
* Laptops: power-hungry tweaks (Ultimate plan, core parking, 100% minimum
  CPU state, power throttling, hibernation) are not recommended, and every
  power tweak only changes the plugged-in setting - battery behaviour stays.
* AMD Ryzen: the power-plan / core-parking tweaks are not recommended, since
  AMD recommends the Balanced plan.
* The GPU settings guide on the Boost Up page matches the card: NVIDIA
  Control Panel or AMD Adrenalin (hidden on Intel graphics). MSI mode is
  NVIDIA-only.
* Health check flags RAM running at stock speed (XMP/EXPO off), a monitor
  below its max refresh rate, your main monitor plugged into the
  motherboard instead of the graphics card, Resizable BAR off (RTX 30+),
  a pending Windows restart, several overlay/RGB apps running at once, and
  background apps eating CPU.
* Profiles: Backups > Export profile saves the optimizations active on
  this PC; Import profile on another PC queues the ones that apply there.


FEATURES
--------
* Game Session (Home): one click - or automatically when a game from
  your list starts - closes background apps (OneDrive, Teams, Widgets...),
  pauses Windows Update and turns on Do Not Disturb. Ending it (or closing
  the game / Zenith) reopens the apps and restores updates and notifications.
* Tray while gaming: when a game from your list starts, Zenith hides in the
  system tray (no window, animations or GPU use). Double-click the tray
  icon to bring it back; right-click for End game session / Exit. Turn it
  off in Settings > "Hide to the tray while gaming".
* Games (Boost Up): "Find my games" scans Steam, Epic, Riot, EA, Ubisoft
  and Battle.net. Listed games get High CPU priority and Windows' "High
  performance" GPU setting; removing one restores both exactly.
* Startup apps (Boost Up): switch apps on/off at startup - same mechanism
  as Task Manager (Store apps are only in Task Manager).
* FPS test (Test): records average FPS and 1% / 0.1% lows with Intel's free
  PresentMon 2.x (download it with the "Get PresentMon" button). Run it
  before and after optimizing to see the real difference.
* Network test (Test): latency, jitter and packet loss to your router and
  the internet, with a verdict on where lag starts.
* PCPartPicker (Scanner): lists every detected part and opens a
  PCPartPicker search for each (no public API exists, so adding them to a
  list is one click per part). Case, PSU and cooler can't be detected.
* Several low-impact tweaks (Nagle, network throttling, system
  responsiveness, priority separation, svchost grouping, memory
  compression) are still available but no longer "Recommended".


HOW TO RUN
----------
1. Right-click the downloaded .zip > Properties > tick "Unblock" > OK (if shown).
2. Extract the folder somewhere permanent, e.g. C:\Zenith
3. Double-click "Launch Zenith.bat" and click Yes on the admin prompt.

Optional desktop shortcut: right-click "Launch Zenith.bat" > Send to >
Desktop (create shortcut).

Requirements: Windows 10 (1809+) or Windows 11, Windows PowerShell 5.1
(already built into Windows). Nothing to install.


FIRST-TIME CHECKLIST
--------------------
1. Scanner page: confirm your hardware was detected, read the Health check.
2. Home > "Apply Recommended" (a System Restore point is made first).
3. Restart the PC.
4. Boost Up page: set the GPU control panel options and in-game settings
   listed there - on entry-level cards those matter as much as the tweaks.
5. Optional, at your own risk: Optimize > Advanced (security trade-offs).


SAFETY
------
* Before any tweak is applied, the original Windows value is saved to
  C:\ProgramData\Zenith\backup.json. Switching a tweak off restores that
  exact value. "Revert all" undoes every change.
* A System Restore point is created before the first change of each session
  (Backups page lets you create one manually or open System Restore).
* Hover the (i) icon on any card to see the exact registry keys, services,
  power settings or tasks it changes.
* Removed Store apps are the only thing that cannot be undone in-app -
  reinstall them from the Microsoft Store if you ever want them back.
* "Apply Recommended" never applies the Advanced security trade-offs.
* Everything is logged to C:\ProgramData\Zenith\zenith.log
* Tweaks, cleaning and restore points run in the background, one at a time.
  Toggle as many as you like - they queue up (shown in the title bar) and
  the window stays usable. If you close Zenith mid-queue, the running step
  finishes (so its backup is saved) and the not-yet-started ones are skipped.


WHAT TO EXPECT
--------------
No software makes a graphics card faster. Zenith removes Windows
overhead, background activity and input/system latency, so you get smoother
frame times, fewer stutters and better 1% lows. The biggest gains usually
come from fixes the Health check points out (XMP/EXPO, refresh rate, cable
in the wrong port), from the in-game settings on the Boost Up page, and on
older CPUs (Intel 8th gen and earlier) from the Advanced tweaks.


ALL 81 TWEAKS
-------------

  FPS & LATENCY
    1. Enable Windows Game Mode  [recommended]
    2. Disable Game DVR Background Recording  [recommended]
    3. Disable Xbox Game Bar Overlay  [recommended, Feature Breaking]
    4. Ensure HPET Is Not Forced  [recommended, Reboot]
    5. Disable Dynamic Tick  [Power Hungry, Reboot]
    6. Disable Fullscreen Optimizations (Global)
    7. Disable Mouse Acceleration  [recommended, Sign-out]
    8. Fastest Keyboard Repeat Response  [recommended, Sign-out]
    9. Stop Background Apps  [recommended, Feature Breaking]
   10. Stop Edge Startup Boost & Background Mode  [recommended]
   11. No Forced Update Restarts While Signed In  [recommended]

  GPU & DISPLAY
   12. Hardware-Accelerated GPU Scheduling  [recommended, Reboot]
   13. Disable Multiplane Overlay (MPO)  [recommended, Reboot]
   14. Optimizations for Windowed Games  [recommended, Win11]
   15. Enable MSI Mode for NVIDIA GPU  [Reboot, NVIDIA]
   16. Disable Transparency Effects  [recommended]
   17. Visual Effects: Best Performance  [recommended, Sign-out]
   18. Disable NVIDIA Telemetry  [recommended]
   19. Stop Windows Update Replacing Drivers  [recommended]

  POWER & CPU
   20. Zenith Ultimate Performance Plan  [recommended, Power Hungry]
   21. Disable CPU Core Parking  [recommended, Power Hungry]
   22. Minimum Processor State 100%  [recommended, Power Hungry]
   23. Aggressive Turbo Boost  [recommended, Power Hungry]
   24. Disable USB Selective Suspend  [recommended]
   25. Disable PCIe Link State Power Saving  [recommended, Power Hungry]
   26. Never Spin Down Hard Drives  [recommended, HDD]
   27. Disable Hibernation & Fast Startup  [recommended, Reboot]
   28. Disable Windows Power Throttling  [recommended, Power Hungry, Reboot]

  REGISTRY
   29. Prioritize Games in the Multimedia Scheduler  [recommended]
   30. System Responsiveness for Gaming  [recommended]
   31. Foreground Priority Boost (Win32PrioritySeparation)  [recommended]
   32. Global Timer Resolution Requests  [recommended, Reboot]
   33. Keep Kernel & Drivers in RAM  [recommended, Reboot]
   34. Group Service Host Processes  [recommended, Reboot]
   35. Instant Menus  [recommended]
   36. Remove Startup App Delay  [recommended]
   37. Faster Shutdown & Hung-App Detection  [recommended]

  MEMORY & STORAGE
   38. Disable Memory Compression  [recommended, Reboot]
   39. Disable SysMain (Superfetch)  [SSD]
   40. Disable Search Indexing  [Feature Breaking]
   41. Disable NTFS Last-Access Timestamps  [recommended]
   42. Disable 8.3 Short File Names  [recommended]

  NETWORK & PING
   43. Disable Nagle's Algorithm  [recommended]
   44. Disable Network Throttling  [recommended]
   45. Disable Network Adapter Power Saving  [recommended]
   46. Stop Peer-to-Peer Update Uploads  [recommended]
   47. Use Cloudflare DNS (1.1.1.1)

  DEBLOAT
   48. Disable Copilot  [recommended]
   49. Disable Widgets / News & Interests  [recommended]
   50. Remove Bing Web Results from Start Search  [recommended]
   51. Block Auto-Installed Sponsored Apps  [recommended]
   52. Remove Start Menu Suggestions & Tips  [recommended]
   53. Remove Windows Settings Ads  [recommended]
   54. Remove Lock Screen Ads & Fun Facts  [recommended]
   55. Disable Recall Snapshots  [recommended, Win11]
   56. Prevent OneDrive from Running  [Feature Breaking]
   57. Remove News, Weather, Maps & Tips Apps  [recommended, Not Reversible]
   58. Remove Office Hub, To Do, Clipchamp & Teams  [recommended, Not Reversible]
   59. Remove Sponsored Games & Apps  [recommended, Not Reversible]
   60. Remove Cortana, 3D Viewer & Mixed Reality  [recommended, Not Reversible]
   61. Disable Unused Services  [recommended]
   62. Disable Xbox Live Services  [Feature Breaking]
   63. Disable Print Spooler  [Feature Breaking]

  PRIVACY
   64. Minimize Windows Telemetry  [recommended]
   65. Disable Telemetry Services (DiagTrack)  [recommended]
   66. Disable Telemetry Scheduled Tasks  [recommended]
   67. Disable Advertising ID  [recommended]
   68. Disable Tailored Experiences  [recommended]
   69. Disable Activity History  [recommended]
   70. Disable Windows Error Reporting  [recommended]
   71. Disable Typing & Inking Data Collection  [recommended]
   72. Disable Remote Assistance  [recommended]
   73. Disable Location Services  [Feature Breaking]

  QUALITY OF LIFE
   74. Disable Sticky / Filter / Toggle Keys Pop-ups  [recommended]
   75. "End Task" in Taskbar Right-Click  [recommended, Win11]
   76. Classic Right-Click Menu  [Win11]
   77. Show File Extensions  [recommended]
   78. Open File Explorer to This PC
   79. Show Detailed Boot & Shutdown Status

  ADVANCED
   80. Disable Memory Integrity (VBS / HVCI)  [Security Risk, Reboot]
   81. Disable Spectre & Meltdown Mitigations  [Security Risk, Reboot]
