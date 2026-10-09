<#
    Zenith  -  FPS & latency optimizer for Windows 10 / 11
    Scans the PC on launch and adapts its recommendations (desktop/laptop, Intel/AMD CPU,
    NVIDIA/AMD/Intel GPU, SSD/HDD, RAM size). Copy the folder to any PC and run it there.

    Every tweak is reversible from inside the app (except removed Store apps, which can be
    reinstalled from the Microsoft Store). Original values are saved to:
        %ProgramData%\Zenith\backup.json
    A System Restore point is created before the first change of every session (configurable).

    Run "Launch Zenith.bat" (it asks for Administrator rights).
#>

$ErrorActionPreference = 'Continue'
$AppName    = 'Zenith'
$AppVersion = '2.1.0'
$IconB64    = 'iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAACLRSURBVHhe7Z15fBTl/cffz8xsdrNJCEJCwn0EBakHeFTqhVhaldpD1NrD/qpVUbk9EA8OERAQRW5Qq5Za21Jv7fFqFTmkioIoCMoNgQDhlIQcm92ZeX5/PDOzsxtEjiQkdD95bXZ25nl2Zp/P9/lezzPPCGoZfc9fnhMQdi9s8m1EHlLmI+x2Usp8kPkS2Vhig5RIJCCR2Ejpbjv7pe3bdsq45aUE53O14873SmyvrKqXfDzpHEik8zlez/mO5HMkH086h/+34Pw2t55ty4NS2PuEtItsQZG0ZbEQ5m6JKDYtufCTHdOLktu0JiGSd9QE+nX7tKOua9dKW16PkJfGGyGZJKfR/kfJT/7ehN/i1pPWcol8S7PsVz/a9eza5LY+UdSYAAw+97PGlqENEHA9QnaV8ht+WDIxKfJ9ZZPrJX6vlPZGCX8VRnTmssK5xckcHA9OWAB+22NLKLvs0BApGCaQjZ0L9X6YaZlmYeniVTvLVhwqixXL8uheoyK2NzNmVzaypNkUZHbyd/6PoQShHTRI+zqgh8oDethM07MIB5qFm6S3P1sTWihZqKSUEYk9xQrIiSsL5x5M/sJjwXELwKgeC4wDFTm3aLYcIwX5cUm2idpl5Wv3vbNy7f535NdVW7sCGcn1UzgqRAJ65sqc9A6xJuEzuhhasEmCppT2QRsmZqdpUxYVzo0kVz4aHJcADDp/9aVo4kUh7Y6eSkOyq2zVuvlbRx0si+06Fwgl10vhhGAGtPTPmzc638gOtuzqdThlwopt27pj1e55f0+u9G04ZgEYdMGamwXyOZCOapIcjGwr+veWh7YeiGy8NLl8CjWPgJ7xcdvsi3ODgewOPv/FBDli1a55E5LLHwnHJABDLvhyjBRyuHvSKrO05D+FD39eVPrJRakeX+cwQ0bjj1pnd+8U0EPNXPMrkX9oWrz3jkUsMpMrHA5HJQD9uqzOTAtrL0khf+aSv6dyzcbX190ektJqlVw+hTrFgVbZ392WmZYXNwtSLpG2fuOXe1/51kjhWwVAkS/elYLuLvlfHXh72cLCsV1Szl29gdkkVPBhblbny71wUrIWGe355d5/HlEItOQdyVA9P07++4WPLVxYOLZbivx6BeNAZNPlhV8vWWxjKdUvZGepaW+0bdvjiKZZT97hh2Pz+7rkv7H+jsWFpR/0OBrBSaHuYdpVbUsqt63KDrfLAakhaWXE0trtq9jwRnJZF98oAIMuWHMzgin+nu+Qn0I9hsTOL6/a/WF2qFUbiUQKeU5Oegdrf8Wmxcll+SYBGHT+6kuF4BWQhmvzPy3+/UWpnt8wYMloG9OOLQqnNWmHtJGCK5tmFqzcX76p2lhCNSdwVI8FxtcVzb5ykzx7KtdsfG3trc1TNr/BwczN7Px5ZlreBU50cDAajbYvLFmUkDqu1qMPVOTc4pJfZZaWvL7u9lCK/AYJY2/Z2tNjZnmRkyNoHDD0+5ILJQjAb3tsCWm2HCOdDN9/Ch/+PBXnN2hkF5et3uYbnLu/bW6PfH+BBAFwRvXy3fSuk+FLoQHDtCMXR8ySrxyHMKRZcpT/uCcAg8/9rLEUDHOzSf/e8tDWVHr31MDeQ2urpDuXQdi3F+R27+ge8wRATeZQ4/m7ylatSw3s1DbEEV41Cxuza1lk9zI1wQTDsuK+gCcAAq53nAXmbx11QpMMUjgSFMnf9JedkV0rQvB15dZMTwtg3wA9DFwB6Nft047uNK6oXVbujOenUKPwE685nzXfS9CxeScqIhXJFWsI8kwzVlmoDLzMads0cimuAOi6dq3rKa7d987KlO2vacR7eFwQtISe37nVmZRUlmJalq9czaIkumuLO8/Qsu2f4gqAtOX1rvO3dv87MrliCicCP/GaQ3ziq11eB8LBLPYe3J1cuUYRjR1UU8qkREh5A4DW9/zlOe7UbdMyTWcOXwo1gsP1evVy92WHG3Nplyv4bNOnTtnag419jmlF96BCwlYtss/tqgWE3Us5f5LC0sWrUlm/moJLviJcQ3eIjwtBQE/jzt6DmLf4ZR/5tSsEldG969xp7UITV2vY5LuTCHaWrTiUXCGF40Ei+X7iNaEjhIYQGkP7PMJfFryEaVlevdpGlVVpe9GAJE+zEXnunPOyWHHK/p8wlKpPtPe6Q7zuqf6+Vw1k+YZlFB3Y7qurUvC1CUvGAvGbYsjXkDLf/Vge3WskV0jhWOCS77P3PuJdT6DXudeQk5XLeyv/nfwFPtSSINhWWCJdLZWvIex2rkqoiO3NTC6fwtEimXxFvNrG23dWm67835W3Men1sclfoPqk7702YGHl+ISxnSalzHdVQsyubJRcIYWjQZx85ew5Kt9vAtDJa9yS8b+ZysNz78O0/bO2HYXsbNcmBOQoT0M4JkDdoo3ERt2rl8KxIa7uNXRwHT1HGFyBSA9mMfvOuTz9zkR2HvDd8e3cCOq+lCDUqhCEQIAQaEKENP/9+akbNY8ViWo/Tr5jAhwzoOtBJvxmKh+t+y8LV73r1I0T7v7VMvFxCGUCQKAl3qKdwtFDeJY0rvYNn/03HOdPZ+hPhtM0K5en34nfteXSX8e9H5QZ8P5rcfJr/8SnDlzy3QSP6/AJNAxHEAxA56aLb+aq865l2NxB2LbpEG0DJNxGX7ft74qAQHNP7l5UCt+GbyJfQyOAEAagNMH3zricIT9+mMfmPcLOr4scql3Sk9/rVgi8OOCOrgule7/5H1f/KLlcraJ37968/sZr8R3S3wQJH5SL4of/cNKxhLLO9tGVVR+k9y8O25aev2ZbIG31btvw7n/epe+dtyu17ziEBXmdeObuP/H35a/z9N/HOff0m9iY5DRryu7du5BYjgDYddoB8xudHTcB3mIDyb+4ltGpUyf++NLc+I6TSb48DvKd1/p1Gxhyz2CHfB2BQU5mMyb9dg6Fe7cy/Z+TnK9TJHcoKCA3J8c9KXi9vy7hNwHOL6vLi8jMzORvr8wjM9PJO51s8p2Dvk0P/nIJ5FtwqKSMu/rdTWVl1LP9GWlZjL95JumBdEa8fC+mHXNu1rQJh8P89Cc/YfWaL5RGcNR/tZPWAQQCBGg45NelAPzxpbl06tRJfTha8p12+lZCiR/71rIyftC36UFK1Jo8DuF+8q2YZNCQwWzdshUNw9EABsOuG0unFmcx/o1R7Dy4w/lSRfaTTz7FvFf+4lP5ddvuLlzycZ1AiVS/rg4wfPhwevfurT4cC/lHQyjHUNbHuG/Tg5989+Unf8rUqSxatBiNAJoIoGFwx5WDubxzL1798GU++Op9XIKltBk8eAibNm9g+/bCk+b4eXDIj0cB3rJotYvevXszfMQj6kNDIN/pF66z55L/3vz3mTlrZkLId023Ptx0ya2s27mG2e8+7fRyC7Do2bMnN//6ZmbOnOaofumcNOnEdQY3kgHNJb+2BSDB6Wso5PvUvrQV+Rs2bOK+++5DF27PD3BumwsZeNVDlFaU8Ngrw7DsmLfWYPsO7Zk+YwYTJo2jrKLU5/XXbnsfCS75SSag9i4owelroOSbUcmhQ+X0HziAqkhUqX5p0KZpAcOvn4CuGcz410SKS3Y6vdwiHA7xzOxn2Lx5M/P+9peTr/oT4GQzXPJrMw71nL46Jl8R6t+vPvg2PfjJ5zA237Lg3nvvZdvWbWikoUmDppnNGNnnSTLTsvnnp6+zcM1/nHhfxfdTJk/h9DM6MurRh52YXzonTjp5ncPVAcJNBdeeSvKcvpNAfvxD/KBvM344iXzbGRuzHbVvxWDatBl88MESRT4Ghh7kgZ9OIP+0VmwqXs8z701GCtXzJRYDBgyk1w++z9v/eItPli91Tlp77XwsiI8FOINBtaWSPKevoZFvg2WBFVXkz39/Ac88M9shX3n8A64azpnNz6aiqpzxbw2nyowo8qVJjyt6cM/gwVTFojw+/jEv41db7XzscNLAAsRvzn5bgpoVPO+rXySXPCXRrWs3Fr6/xBMUKSXS8fRd8m2n569fv5lf/uomIpWmR/5N3W/npu/dAgIm/3MUi9f+G5sYNlHatm/NG6+9RlajDKbNepqJk8b6HL/aM7PHgpbZFyDcPIBLPvXk4uoC48dPOiryS0vLGXzPYCKVFjpp6ATocebV3HjRLUgJ/175FkvWvuvYfIv0UJBZM2aSmZXBvq/3MmPWlHrh9SfDJR9wU8H16wJrE9f3uYHu3/0euOQ79t4j31TkmyYMvX8o27buQEeFe2e26EbfK+5HSti8ewMvLpqGjY0UNrY0efKpp+jYsQBNFzw+fgzl5Yeg3nj9fvjGAlzy/xcEIBQKMWrEY+An3/X07UTyZ0yfyZL/LvXIb964LQN/+CgBPURFtJzJ/xpF1KxEYmET4+5+/biyZ080Hb5YvZJ5r7zstKqb769fcIeD6yQPUF8wsP9g2rRpWy3Fa1kgTbBiYJmwYP5Cnvv97x3y08gKNuG+q8fRONwEW8Jz70+m+OB2bCxsTHpcdimDBgxAM0DogpGPPuSp/vpMPnWVB6gPyMvLY8jgez3y8al96Yv1N67bxEOPPIJOGhppBPQgA34wguaNWyOlZP6av/Ph+vnYmNhYtG3XmiefegrdAF0XvPPOG3y87COf6q+P8GUCXfLr78XWDEaNeIxwOMMj37Z85JsS04RDX5dzz/1DiVaaaKShiwC/veQeurQ4Dylh255NvLRkJjYmUlqkpweYNnUaWVkZaDpEYxHGThjttGf97P1xeINBDvmnsAno1rUbv/rlzYoP6dh7W5FvxiSWCVaVZNiDD1FUuMMhP40fnfMrLj/jaqSEymgF094bQ5VZoey+MJkwYQIdO3ZA05Xqn/PsTLZt3+oQX5/b0xkMEgkmoD5f8Ilh/OOTkLZS/ZZDvO30fMsCs0oya/YcPvrwY4/889peTp/zb1X9QsKLi6exu3QbEjWtq+8dd3Dl93ui66Dpgn379jB91pQGEVElzAdwyT9VfYA+fW7gogu7VyPfdtS+GZG8v2Axzz//IhppGCJI+5wu3HrJvd60r4Vf/ZOPN8/Hlsrpu+TS79F/YH90Dcfxg3ETRlNWXloPQ77DwCHfGwyq//bq+BAKhRj1yGikBFsmkR9Van/jhi2MHDESnSCGCNIkI5+7rxhF0AgDsH3/Fv7y8RzH44/Rpl0rnnhiour5hur9q1Z/zl//9qcG1I6+wSD3olVC6NTCwP6Dad26rerJpju658T6MSgpqeCBYcOIVtoYIkgokE3/Kx6jUfA0pA2RaAVzFo2jyqrAljGC6WlMfupJshplKK/fEAgdRox6sAHY/TgSBoNc8uu73TpW5DXLY9CAe1SWz3KyfZaK9c2YGt8f/vAjFBXuwhBBAlqYWy9+gObZbQFV/qWPZrCndDu2NLGJMe7xsXQ8vQBdV+RLDd5663U+/uTDBtZ+zmCQmwpWF39q+QAjh48mHM70pnN5sb5D/pw5z7L0o2XoIogmgvTpejvfyb/ASw1/sOFfLN+6yBvkuf222+h5xeUO+YAGsViEMeNHNQy7n4AEE6DIb1gSfGR069qNX9x0szeTV9oq3DNjEKuSLFzwAX94cS66CKKLEJcVXMslHXsrGiUU7d/K6yuexyaKJWNcfHF37u53J0aaUE6fIdA0mPXMdF/Y13AQNwHExwJOpTzAuLFPJOb5nVjfjEo2bdzCo4+O9sg/M+9CfnLOrU7Pl1TGynn+wwlEzDIsGaN12xaMn/A4ekCo3h9Q4+h79+9m+oynGxz5Co4ICG9W8KnjA1z3sxv47vnf883kVWo/ViUpLalg2IMPEY1YGCJEi0YF/ObCe9ExlI9gw7zlc9hbVoRNlGC6waQnniCrURjDAGGottM0GPf4o5SVN9w1tYRwnUAvD9DwBSAUTFdhnzvEa4EVhVhMOX/Dhw9nx/ZidIJkh5rxu4uGk6aHVVkJH276Dyu2L8KSVVgyyujHRtPx9Paq1xugaUr1r1z9OX+e96cG2vvj5BPPAzji38AxoN9gWrZs6yNfJXvsmOTZOc/y8UfL0UkjFMjmlgsfJju9qUf+zoNbefOLF7BlFEtGufV3t9Cz52Xojt3XdaFSvhoMH/FAgyVfwfUC6vjGkNpEXrN8BvYfkmD3TUcIFiz8gBf/MBddpKGLID87+y5aZBd45JdFSvnjJ5OImoewiNL94gu5866+6AFFuq6reF8IeOvt11j6yYfJp29wcOOAOrsxpHYhGPnIaMLpmU7Sx0nzRlWm79FRozzyz2/di24tL/c8fkua/HH5RPaWb8eiipat8xk3dixGQIV7upPqFQKqYhEeezzhgRsNEi75XhioyG+oAiDodk43fn7Dr1W8b6pEj2XCodIKhj00jGilhU6Q/Kz2XNvlVi9rJ4FXPpvF5v2rsWSEtJDOExMnkJUdRk8T6E6qV9NA02HW7Gls27Y1+QIaKLzhYKcxGqgPIBCMeewJz+6bzgifFZU88vAjFBXuRBMBQoFG/KLbfaQZyukDmL/+b3y2430sGcGSVYwePYqC09uhB+Mhn2v39+zZzdQZk5NP30DhGw52yW+YJkCosO+C7thmfHjXikrmzH6GpR8tRRMBdJHGtV36kpvZWgkKsHLHf3lv/Z898m+59f/o0fMyjKDA0MEICISmyNcEjBk/ivLysuQLaJBIGA6Ok9/QBECQHgwz4sFHndk9Kt63YrBw4WKef/EF50aONM5r0YtuLa/wam498CWvrpqGJaswZZVy+u7uq9S+0/PRVLwvgM+++Iy//PVPCWdv0HDITzIBDUsABIJ+dw+iRYs2yvM31RSvzes3MXzEcDWhUwTIb9SB3t+5XXk6EvaX7eLPKyZRZZZhySpatm3O44+PxUgDQwc9oJw+TXPmz3th36kExwSon+eOBjYkH0DQrFk+A+8arO7fc1R/WUk59z4wlGhlDE0YpBuZ/Pyc+wka6QBEzAr+uGIspZE9WFSRlq7x5BMTyMwOowcERprP6XMe5fPGW6+y9OOPki+gQSMxCvDIbygaQCDQGPHgaILpmdiWVL0/Khn20DC2FxYhnLn813S5i9ysNl6495fPxrPn0BYsqrBkhDFjRlNwenuMNIFhgGY4Tp+TKKuKRnhsXMMP+w4PJQbxCSENQgCU6up2znnccMMvE8b3Z82ezX+XfOSt2tG15VWc1+L74Ij2O188y4a9n2IRxZIRfnfbrfToeTmGz+675LvO38xZ09i+rTD5Ik4BuDrAnRBCwxgNdGSW0aMmeNO5bQsWLFjAc79/Dk0Yyu5nFvCjzn2VSEv4YNNrLCv6BxZRbFnFxZdc5A3v6obP43fIR8CePXuYOv1UCfsS4ZKvTIBDfv33AdQFX/eT67nw/Is81b9p/SYefuQh1fMJEDIyuOGcB0gz0pESvtq9lHc3/MEjv2XbFowfPx4joNS+O61L85EvgMfGjTxlwr7qUG0phLdWcH3PAyi7nx4M8/ADo5yFG+BQaTmD7x9CpDLmqH6dazr3p1lWWySSHSXreeWLiZgygi2rCKQbTH5qEo0aO3P6AnHynUW/EcDKVZ+fWmFfNSjyHQ1Q3/MAbsgiuPvOQbRs2ca7jWvoA/ezbet2tU4fBl1bXE23Fr2QEkoq9/HyitFEzDJsWYVFjPHunD4jHu65oZ5wYn4hBA8PH5p8EacUEm8Pr+d5ANfu5+c2p9+dg7Aduz9jxnQ++O8SNKmWaG2W1Z5rOt2FdMK9P3/2KKVVuz3yb7/jNq7oeYVS+wEV7gmhcvx+8l9/81WWfnJqhX3V4XoBCbOC66MP4NgqNB4aNopQMIxlwvz5C3jmuTnO6tw6ISOTG896hDQjjG2bvPbFBHaWrlNz+ohxyaXd6d+/X5x8LZ7mFY7aF0IQqYoweuzI5Is4JeFq1XqcB1CqX6Bx7tnduLHPL7At2LhhE8MevB+B4S3XfnWn/uRmqtu+/7X2Gdbu+dAjv3W7lkya+ASGgZfoEU6vd7N9aoYMzJg5le3bT8WwLxEu+STkAeqZCXBVv0Dj0ZHjsS3JodJyBg4ZQGWkyrH7Gl2bX03XFlcBsHzHP/h4++se+cF0g6mTnyYrOyOu9r+B/OLdp9Jo37fhsCagPglAXPX/9Md9uKDbhZgm3Df0HrZuLfTIb5ZZwNWdByAlbNi/jH98NdWZx29iEWXihAl07FSAHlDhnuvsaVri2aSEMad02FcdXiroBx3GSEW+zaLC+DNtTh5c1a+THgyz8N2l5DVrxdTp05g9e6a6kYMAIT2L286fRbNGHdh7aAsvLB9AxCrzyL+z750MGjwAXQfDEOAM8Gi6cxan91dTfM5w8WE+JJZ1tr1dSd9ztGWrl1M73M0pM5/gicljfIVOHJ1znAeDeNPC61EewK/67+w7kOb5rZj//nxmzZ7uLMysHs9yTadB5Ga151BkPy9/PoxK6xAWMSyiXHbpxQwaVJ184fT8hkL+gsXvMnnaeF+hGoRwPSx3kahqrXEyEFf9zXLzueuOgWzcsJH7Hrgn/nweNLo2v4Zz8q+hyqpg3hfDOVi1y1myJUbbtq2YPHmyyu/r6v49l3xFfMMgf2vhZvoNvhXT9D9gsobgkI83LVzK6r+kzqGId18PDh2JtCR3D7qbyoqI92Cm3IwO/PCMwQC8/eV4ig5+4ZAfJRQKMHP6DLKyMpTN9/X84yFfJg+RHIFQDkvq4ctWL6d2uJvlFWXcetcvKSkt8RWsObjke2Eg9WA00A1N3LDv+ut+zuB7BrJ1yxY01OB8QIS47swRBPUw722aw5rdC7CF6vm2jPHUk086mb5Em6/i/GMnPwFHIJTk8kcoW72c2uHbZMgDd7Fu/Ze+grUBJw8QJ/9kJoLi5IPGyOHjeHra0yxcvEBpBKf3//D0QeRlnc7Knf9kSeFLPvKj9OvXn+9//0rl5Pl7Pq4GaBjkT5n5BP/411u+grUBt729VLD75LCTAdfrV6r/Jz/uQ0lJCTNnTPFsPgi+06wX57W4ji1ff8bbaycgMdV6PTJGjx6XM2TQIDRnvR6XfHeEr6GQX6tOXwJcI+A6gScxD+B6/SAIBdO54bqbGHLPQOexq0ojNA215kdnPMi+8i288sUDmETUog0yRrv27Zj69FSPfC/Ro4Qckhuf+kl+rTp9SXDJh4QFIpJ/fV3AVUVKA9z861sYM240lRUVTigoMLQQfbo8TsyO8tcv7qfCOug9gDEUDjJ7xiwyszIOS75/1MtDbZOf1JTVy6kdvs1ad/qqwxGBeB7gZISBinb1rpGXm8+Xa9awZfMmb2aGQPDDgnvJzSzgldUPsD9S6JBvASZTnlJP5PDIF/WAfP+hauXUjuSydeP0JSJ+e/hJGg30kw8aacF0Pv5kqecLgKBL7lWc16IPb381mm0lK5y1eiwkMQb0H0ivXt9PJN+d1PFt5Mv6Q37dOH2J8N8eLi5rO/QQyEyQLC2aWQ5kJFeoecSdPvVSD2DW3Meuo9Mk1I7bz/8zHxf9icWFzwBKSN2ncihBUM/jVfsbwvKs9QPfadYHXBYkslg1rgSh7UsuXBtwe796aQih7L2r9nUtSJ8uE9m4fwmLC+ckEJ8i/4Rh4rS0BFMT0i5ys4EGaV8nl655xIl2//z7AH7QfihRq5K31490iHV7vUO+dIQhRf7xoNhtZ4Eo0mxBkXIAbQJ6qDy5dM0ikfB473e1AnTJuYb2jb/La1/ej2k7CzM75Kterx7PkiL/+KATOKC2BEiKNGnLYndAKKCHaz8Irdb742gcasOVHYYyb81AymK7fT1dPXMvRf6JQ9PTKjwOBMWaEOZu1wSk6VnJ5WsQyb3fddfVS9eC/KzzJN5ZN4z9lRuR0nJs/eHJV8SnyD9WBPRw1Ot4QhRrElHsDgiFA83UCsl1gsTe36vdg6wonseWgx86JMeftWd7WiBOvnpP4VgR1rLVhhoS3q2ZllzoNmiT9PZnA5HkSjWHw6v+M3N+RMQ8xOfFf/ORr67Jlpb3zL1E1Z/C8aBJuGMHRT4g5ULtkx3TiyTW5yDRhBYK6JkrkyudOKqT7qJxqA0Fp/Vg0fbJDunOn3S8fVxTkLL5JwoNfV0w0KiVACRi36e7XlqiAUgpX3PHBHLSO8SSK9YcEoXAEAG6t7yDf28eiS1NT7XbzsOXq6v8FPkngsxgfrFiQADamzjDbVjwpkSFgk3CZ3RxkwW1C8mFLW5n0bbJVFnlap0i5+VX+Snyaw65GZ3zPafbtl/DFYDlRXNWS2lvlEgMLdjEEKFVyZVrBm4+XFJwWk82HXif8uheZ5Eq1/b71X1K7dcYhLY5I5DTSZljysJBFuIKAIAU8lU3GmiRfUHSzPmag0SSHWpF1Cpnd8UaZybS4Zw8G6WVUuTXBPLCXXY65CPhzUWFcyP4BUDosalSyojEJjvYsmtAS1+W8A01BENLIyuQx7bSj6qRHidc+SMp8msGGvq6vMyzLnXtv4Z8Kn7MwbLCucUSe4qrBdqcdvFpNecLxAltGipg+6FP4t5+go1PFoQUagIts7uXu+RLyV+X7Zz7uXssQdVbATkRaR+USELGaR1DevZS//ETRdDIYm/lOq+Xu6RX7/Up8msKhgitaBJqfR4IJNK0dW2E/7hzo5TC7pKVkbyscwVC9kLaZAbzQwcqN1YBap21E4RpVzm9ncMQnSK9FhDp2PTKqoAWbgIghHh2xY4XXvIXqObsZadpU5B2sUQS0EPNWja6YGvNmQKSen+qx9cmmmectTzdaNpRfRIRYdijk8tUE4BFhXMjEnm3RJoSSVaw+XlNQgUNf4H8/zGE03IXN8s8+1JUz0fAPcsK5xYnl0swAS52l61em5f1nZiUdi+QhIM5bcujez4w7Sr1UL0U6jUMEVpxRs41FwiEJoRAIuYs3/lCtd7PNwkAwO6yNUuaZXZpB7KrlJKsUMuWJZXbVkns/OSyKdQjCG1z56bX5htaIMOZ/Plexo5Wvy5k0WFH0KqZAD+aFu+9Q0q5BGw0hNGuac+z0vTMJcnlUqgfMERoRZemP20c0ENNHPLXRg3zxkWM/kYf7vBDdD50yb0xX2ixDySyo0Q9jmtP2bpFpVXbLwGM5PIpnByE03IXF5x25cUamqFuhRPFUpo9P901d21yWT++VQAAuuT2zpea9gaS7m7q5lDVzuV7y9aeDjgzDFI4SYg0zzhrud/hA7HWts3rvo18juQD+LG3YkNZRk7zl41YWjsp5DlImzQ9o0VmIHdfeezAl1KarZLrpFD7MERoRcemV1Y1DrXrSpz896KGedVnRXOLkssfDkelAfzolHPVcCkY42bupLSpjB1cva9snWljdk0un0LNQ0Nf1zK7e7mb4cMhXyLmZOxoNfBINj8ZxywAAB1zf3CDgOektBt7goCkLLLn468rtzYGu1NynRRqAELbnBfustM/sOMciAi4Z9nOF+YklD8KHJcAALTN7tE4YOj3SeT9UsgQvkWnzVhlYUl015Zo7GATG/uc5LopHD009HWZwfzi3IzO+b7xfNzcvhDi98KwRx8uyXM0OG4BcNE2t0e+ZslRUti3g3oKs/pTgzymFd1TGd27rsqqtC0ZC2BbYQsrR0AOEEr+vv9RmECxTuCApqdVBPRwNKxl0yTcsYM7h09R5SNf8ldb10Z8VvT8xqTvOiacsAC4KMjt3tGy9GES+2cSmQPxxae8IV5vLYL4D/FmqHr/1Q/1toW75ak7X/n4sufJdb06Xn1fHW876U7Zb6x7bOf2yvtW4zrmc6sCieeDMglvasin/EO6JwL3rDWIHkabJlVX2NL6kZDyBilkqxT5x3huVQABSMQ+0N7Ubfu1cJCF7kyemoJ75lpDfqNuF+i67CUleRLyBSJfINpJyNeECH1jIwp3y9846p0jEODV8er76njb30LAcZ7bK3+M5EswBaIISZEQFCNEsUDsRsqFn+56qVYzr/8PtO0UCrepgnIAAAAASUVORK5CYII='

# ---------------------------------------------------------------- elevation / STA
$currentId = [Security.Principal.WindowsIdentity]::GetCurrent()
$isAdmin   = (New-Object Security.Principal.WindowsPrincipal($currentId)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin -or [Threading.Thread]::CurrentThread.ApartmentState -ne 'STA') {
    $argList = "-NoProfile -ExecutionPolicy Bypass -STA -WindowStyle Hidden -File `"$PSCommandPath`""
    try { Start-Process -FilePath 'powershell.exe' -ArgumentList $argList -Verb RunAs } catch {}
    exit
}

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Xaml, System.Windows.Forms, System.Drawing

# ---------------------------------------------------------------- paths / settings
$DataDir      = Join-Path $env:ProgramData 'Zenith'
$BackupFile   = Join-Path $DataDir 'backup.json'
$SettingsFile = Join-Path $DataDir 'settings.json'
$LogFile      = Join-Path $DataDir 'zenith.log'
$GamesFile    = Join-Path $DataDir 'games.json'
$SessionFile  = Join-Path $DataDir 'session.json'   # exists only while a Game Session is on
$BenchFile    = Join-Path $DataDir 'bench.json'
# Carry over data from the app's old FrameForge name, so tweaks applied back then can still be reverted.
$OldDataDir   = Join-Path $env:ProgramData 'FrameForge'
if (-not (Test-Path -LiteralPath $DataDir) -and (Test-Path -LiteralPath $OldDataDir)) { Copy-Item -LiteralPath $OldDataDir -Destination $DataDir -Recurse -ErrorAction SilentlyContinue }
New-Item -ItemType Directory -Force -Path $DataDir | Out-Null

function Write-Log([string]$msg) {
    try { Add-Content -LiteralPath $LogFile -Value ("[{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $msg) -Encoding UTF8 } catch {}
}

$script:Settings = [ordered]@{ AutoRestorePoint = $true; ShowAdvanced = $true; ConfirmRisky = $true; AutoSession = $false; PresentMonPath = ''; TrayWhileGaming = $true }
if (Test-Path -LiteralPath $SettingsFile) {
    try {
        $s = Get-Content -LiteralPath $SettingsFile -Raw | ConvertFrom-Json
        foreach ($p in $s.PSObject.Properties) { $script:Settings[$p.Name] = $p.Value }
    } catch {}
}
function Save-Settings { try { $script:Settings | ConvertTo-Json | Set-Content -LiteralPath $SettingsFile -Encoding UTF8 } catch {} }

$script:Backup = @{}
if (Test-Path -LiteralPath $BackupFile) {
    try {
        $j = Get-Content -LiteralPath $BackupFile -Raw | ConvertFrom-Json
        foreach ($p in $j.PSObject.Properties) { $script:Backup[$p.Name] = $p.Value }
    } catch { Write-Log "Backup file unreadable: $($_.Exception.Message)" }
}
function Save-Backup {
    try { $script:Backup | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $BackupFile -Encoding UTF8 }
    catch { Write-Log "Could not save backup: $($_.Exception.Message)" }
}

# ---------------------------------------------------------------- registry helpers
function RegV {
    param($Path, $Name, $Type, $Value, $Default)
    [pscustomobject]@{ Path = $Path; Name = $Name; Type = $Type; Value = $Value; Default = $Default }
}
function SvcV {
    param($Name, $Start, $Default)
    [pscustomobject]@{ Name = $Name; Start = $Start; Default = $Default }
}
function PwrV {
    # power setting: subgroup GUID, setting GUID, target value, Windows default
    param($Sub, $Setting, $Value, $Default)
    [pscustomobject]@{ Sub = $Sub; Setting = $Setting; Value = $Value; Default = $Default }
}

function Get-RegValue([string]$Path, [string]$Name) {
    $res = [pscustomobject]@{ Exists = $false; Type = $null; Value = $null }
    try {
        $k = Get-Item -LiteralPath $Path -ErrorAction Stop
        if ($k.GetValueNames() -contains $Name) {
            $res.Exists = $true
            $res.Type   = $k.GetValueKind($Name).ToString()
            $res.Value  = $k.GetValue($Name, $null, 'DoNotExpandEnvironmentNames')
        }
    } catch {}
    return $res
}

function Set-RegValue([string]$Path, [string]$Name, [string]$Type, $Value) {
    if (-not (Test-Path -LiteralPath $Path)) { New-Item -Path $Path -Force -ErrorAction Stop | Out-Null }
    if ($Type -eq 'Binary') { $Value = [byte[]]@($Value) }
    if ($Type -eq 'MultiString') { $Value = [string[]]@($Value) }
    New-ItemProperty -LiteralPath $Path -Name $Name -PropertyType $Type -Value $Value -Force -ErrorAction Stop | Out-Null
}

function Remove-RegValue([string]$Path, [string]$Name) {
    if (Test-Path -LiteralPath $Path) { Remove-ItemProperty -LiteralPath $Path -Name $Name -Force -ErrorAction SilentlyContinue }
}

function Test-SameValue($cur, $want) {
    if ($cur -is [byte[]] -or $want -is [array]) { return ((@($cur) -join ',') -eq (@($want) -join ',')) }
    return ("$cur" -eq "$want")
}

# ---------------------------------------------------------------- service helpers
function Get-SvcStart([string]$Name) {
    $key = "HKLM:\SYSTEM\CurrentControlSet\Services\$Name"
    if (-not (Test-Path -LiteralPath $key)) { return $null }
    if (-not (Get-Service -Name $Name -ErrorAction SilentlyContinue)) { return $null }
    $start   = (Get-RegValue $key 'Start').Value
    $delayed = (Get-RegValue $key 'DelayedAutostart').Value
    switch ($start) {
        2 { if ($delayed -eq 1) { 'delayed-auto' } else { 'auto' } }
        3 { 'demand' }
        4 { 'disabled' }
        default { "$start" }
    }
}
function Set-SvcStart([string]$Name, [string]$Start) {
    if (-not $Start -or $Start -notin 'auto', 'delayed-auto', 'demand', 'disabled') { return }
    & sc.exe config "$Name" start= $Start | Out-Null
    if ($Start -eq 'disabled') { Stop-Service -Name $Name -Force -ErrorAction SilentlyContinue }
}

# ---------------------------------------------------------------- power helpers
function Get-PowerValue([string]$Sub, [string]$Setting) {
    $out = (& powercfg.exe /qh SCHEME_CURRENT $Sub $Setting 2>$null) | Out-String
    $m = [regex]::Matches($out, '0x[0-9a-fA-F]{8}')
    if ($m.Count -ge 2) { return [Convert]::ToInt64($m[$m.Count - 2].Value, 16) }
    return $null
}
function Set-PowerValue([string]$Sub, [string]$Setting, $Value, [string]$Scheme = 'SCHEME_CURRENT') {
    if (-not $Scheme) { $Scheme = 'SCHEME_CURRENT' }
    # Plugged-in (AC) only: laptops keep their battery behaviour, and Get-PowerValue/backup only track AC.
    & powercfg.exe /setacvalueindex $Scheme $Sub $Setting $Value 2>$null | Out-Null
    & powercfg.exe /setactive SCHEME_CURRENT 2>$null | Out-Null
}
function Get-ActiveSchemeGuid {
    $o = (& powercfg.exe /getactivescheme) | Out-String
    $m = [regex]::Match($o, '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
    if ($m.Success) { $m.Value.ToLower() } else { $null }
}

# ---------------------------------------------------------------- scheduled task helpers
$script:TaskCache = $null
function Get-TaskObjects([string]$Full) {
    $i = $Full.LastIndexOf('\')
    $path = $Full.Substring(0, $i + 1); $name = $Full.Substring($i + 1)
    # During a full state check every task is loaded once up front (one ~0.5 s query instead of ~0.2 s per task).
    if ($null -ne $script:TaskCache) { return @($script:TaskCache | Where-Object { $_.TaskPath -eq $path -and $_.TaskName -like $name }) }
    @(Get-ScheduledTask -TaskPath $path -TaskName $name -ErrorAction SilentlyContinue)
}
function Test-AllTweaks {
    $states = @{}
    $script:TaskCache = @(Get-ScheduledTask -ErrorAction SilentlyContinue)
    try { foreach ($x in $script:Tweaks) { $states[$x.Id] = Test-Tweak $x } } finally { $script:TaskCache = $null }
    $states
}

# ---------------------------------------------------------------- appx helpers
$script:AppxNames = @()
function Update-AppxCache { try { $script:AppxNames = @(Get-AppxPackage -ErrorAction SilentlyContinue | ForEach-Object { $_.Name }) } catch { $script:AppxNames = @() } }

# ---------------------------------------------------------------- tweak engine
$script:Tweaks = New-Object System.Collections.Generic.List[object]
$script:TweakMap = @{}
$script:State  = @{}
function Add-Tweak([hashtable]$h) {
    foreach ($k in 'Reg','RegFn','Svc','Pow','Tasks','Appx','Test','Apply','Revert','Tags','Only','Note') { if (-not $h.ContainsKey($k)) { $h[$k] = $null } }
    if (-not $h.ContainsKey('Rec'))    { $h.Rec = $false }
    if (-not $h.ContainsKey('Risk'))   { $h.Risk = 'Safe' }
    if (-not $h.ContainsKey('Impact')) { $h.Impact = 'Medium' }
    if (-not $h.Tags) { $h.Tags = @() }
    if (-not $h.ContainsKey('Kind') -or -not $h.Kind) {
        $h.Kind = if ($h.Appx) { 'APPS' } elseif ($h.Pow) { 'POWER' } elseif ($h.Svc -and ($h.Reg -or $h.RegFn)) { 'SERVICE + REG' }
                  elseif ($h.Svc) { 'SERVICE' } elseif ($h.Tasks) { 'TASKS' } elseif ($h.Reg -or $h.RegFn) { 'REGISTRY' } else { 'SYSTEM' }
    }
    $o = [pscustomobject]$h
    $script:Tweaks.Add($o); $script:TweakMap[$o.Id] = $o
}
function Get-Tweak([string]$Id) { $script:TweakMap[$Id] }

function Resolve-Reg($t) {
    if ($t.RegFn) { return @(& $t.RegFn | Where-Object { $_ }) }
    if ($t.Reg)   { return @($t.Reg) }
    return @()
}

function Test-OnlyOk($t) {
    if (-not $t.Only) { return $true }
    switch ($t.Only) {
        'Win11'  { return ($script:SysInfo.Build -ge 22000) }
        'Win10'  { return ($script:SysInfo.Build -lt 22000) }
        'NVIDIA' { return [bool]$script:SysInfo.GpuInstanceId }
    }
    return $true
}

# Returns 'On', 'Off' or 'NA'
function Test-Tweak($t) {
    try {
        if (-not (Test-OnlyOk $t)) { return 'NA' }
        if ($t.Test) {
            $r = & $t.Test
            if ($r -is [string]) { return $r }
            if ($r) { return 'On' } else { return 'Off' }
        }
        $checked = 0
        foreach ($r in (Resolve-Reg $t)) {
            $checked++
            $c = Get-RegValue $r.Path $r.Name
            if (-not $c.Exists -or -not (Test-SameValue $c.Value $r.Value)) { return 'Off' }
        }
        foreach ($s in @($t.Svc)) {
            if (-not $s) { continue }
            $cur = Get-SvcStart $s.Name
            if ($null -eq $cur) { continue }
            $checked++
            if ($cur -ne $s.Start) { return 'Off' }
        }
        foreach ($p in @($t.Pow)) {
            if (-not $p) { continue }
            $cur = Get-PowerValue $p.Sub $p.Setting
            if ($null -eq $cur) { continue }
            $checked++
            if ($cur -ne $p.Value) { return 'Off' }
        }
        foreach ($tk in @($t.Tasks)) {
            if (-not $tk) { continue }
            foreach ($o in (Get-TaskObjects $tk)) { $checked++; if ($o.State -ne 'Disabled') { return 'Off' } }
        }
        if ($t.Appx) {
            $checked++
            foreach ($a in $t.Appx) { if ($script:AppxNames | Where-Object { $_ -like $a }) { return 'Off' } }
        }
        if ($checked -eq 0) { return 'NA' }
        return 'On'
    } catch { Write-Log "Test failed for $($t.Id): $($_.Exception.Message)"; return 'Off' }
}

function Invoke-ApplyTweak($t) {
    Write-Log "APPLY  $($t.Id)  ($($t.Name))"
    $hadBackup = $script:Backup.ContainsKey($t.Id)
    $bk = [ordered]@{ Reg = @(); Svc = @(); Pow = @(); Tasks = @(); Custom = $null; Time = (Get-Date).ToString('s') }

    foreach ($r in (Resolve-Reg $t)) {
        $c = Get-RegValue $r.Path $r.Name
        $v = $c.Value; if ($v -is [byte[]]) { $v = [int[]]$v }
        $bk.Reg += [pscustomobject]@{ Path = $r.Path; Name = $r.Name; Exists = $c.Exists; Type = $c.Type; Value = $v }
        try { Set-RegValue $r.Path $r.Name $r.Type $r.Value } catch { Write-Log "  reg fail $($r.Path)\$($r.Name): $($_.Exception.Message)" }
    }
    foreach ($s in @($t.Svc)) {
        if (-not $s) { continue }
        $cur = Get-SvcStart $s.Name
        if ($null -eq $cur) { continue }
        $bk.Svc += [pscustomobject]@{ Name = $s.Name; Start = $cur }
        Set-SvcStart $s.Name $s.Start
    }
    foreach ($p in @($t.Pow)) {
        if (-not $p) { continue }
        $bk.Pow += [pscustomobject]@{ Sub = $p.Sub; Setting = $p.Setting; Value = (Get-PowerValue $p.Sub $p.Setting); Scheme = (Get-ActiveSchemeGuid) }
        Set-PowerValue $p.Sub $p.Setting $p.Value
    }
    foreach ($tk in @($t.Tasks)) {
        if (-not $tk) { continue }
        foreach ($o in (Get-TaskObjects $tk)) {
            $bk.Tasks += [pscustomobject]@{ Path = $o.TaskPath; Name = $o.TaskName; State = "$($o.State)" }
            try { Disable-ScheduledTask -TaskPath $o.TaskPath -TaskName $o.TaskName -ErrorAction Stop | Out-Null } catch { Write-Log "  task fail $($o.TaskName): $($_.Exception.Message)" }
        }
    }
    if ($t.Appx) {
        foreach ($a in @($t.Appx)) {
            Get-AppxPackage -AllUsers -Name $a -ErrorAction SilentlyContinue | ForEach-Object {
                try { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop } catch { try { Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue } catch {} }
            }
            Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -like $a } | ForEach-Object {
                try { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue | Out-Null } catch {}
            }
        }
        Update-AppxCache
    }
    if ($t.Apply) {
        try { $bk.Custom = & $t.Apply } catch { Write-Log "  custom apply fail: $($_.Exception.Message)" }
    }
    if (-not $hadBackup) { $script:Backup[$t.Id] = [pscustomobject]$bk; Save-Backup }
}

function Invoke-RevertTweak($t) {
    Write-Log "REVERT $($t.Id)  ($($t.Name))"
    $bk = $null; if ($script:Backup.ContainsKey($t.Id)) { $bk = $script:Backup[$t.Id] }

    if ($bk -and @($bk.Reg).Count -gt 0) {
        foreach ($e in @($bk.Reg)) {
            if (-not $e) { continue }
            try {
                if ($e.Exists) { Set-RegValue $e.Path $e.Name $e.Type $e.Value } else { Remove-RegValue $e.Path $e.Name }
            } catch { Write-Log "  reg restore fail $($e.Path)\$($e.Name): $($_.Exception.Message)" }
        }
    } else {
        foreach ($r in (Resolve-Reg $t)) {
            try { if ($null -eq $r.Default) { Remove-RegValue $r.Path $r.Name } else { Set-RegValue $r.Path $r.Name $r.Type $r.Default } } catch {}
        }
    }

    if ($bk -and @($bk.Svc).Count -gt 0) {
        foreach ($e in @($bk.Svc)) { if ($e) { Set-SvcStart $e.Name $e.Start; if ($e.Start -match 'auto') { Start-Service -Name $e.Name -ErrorAction SilentlyContinue } } }
    } else {
        foreach ($s in @($t.Svc)) { if ($s -and $s.Default -and $null -ne (Get-SvcStart $s.Name)) { Set-SvcStart $s.Name $s.Default } }
    }

    if ($bk -and @($bk.Pow).Count -gt 0) {
        foreach ($e in @($bk.Pow)) { if ($e -and $null -ne $e.Value) { Set-PowerValue $e.Sub $e.Setting $e.Value $e.Scheme } }
    } else {
        foreach ($p in @($t.Pow)) { if ($p -and $null -ne $p.Default) { Set-PowerValue $p.Sub $p.Setting $p.Default } }
    }

    if ($t.Tasks) {
        if ($bk -and @($bk.Tasks).Count -gt 0) {
            foreach ($e in @($bk.Tasks)) { if ($e -and $e.State -ne 'Disabled') { Enable-ScheduledTask -TaskPath $e.Path -TaskName $e.Name -ErrorAction SilentlyContinue | Out-Null } }
        } else {
            foreach ($tk in @($t.Tasks)) { foreach ($o in (Get-TaskObjects $tk)) { Enable-ScheduledTask -TaskPath $o.TaskPath -TaskName $o.TaskName -ErrorAction SilentlyContinue | Out-Null } }
        }
    }

    if ($t.Revert) {
        $custom = $null; if ($bk) { $custom = $bk.Custom }
        try { & $t.Revert $custom } catch { Write-Log "  custom revert fail: $($_.Exception.Message)" }
    }
    if ($script:Backup.ContainsKey($t.Id)) { $script:Backup.Remove($t.Id); Save-Backup }
}

function Get-TweakChangeText($t) {
    $lines = @()
    foreach ($r in (Resolve-Reg $t)) {
        $v = if ($r.Value -is [array]) { ($r.Value | ForEach-Object { '{0:X2}' -f $_ }) -join ' ' } else { "$($r.Value)" }
        $lines += "REG  $($r.Path.Replace('HKLM:','HKLM').Replace('HKCU:','HKCU'))\$($r.Name) = $v"
    }
    foreach ($s in @($t.Svc))   { if ($s) { $lines += "SERVICE  $($s.Name) -> $($s.Start)" } }
    foreach ($p in @($t.Pow))   { if ($p) { $lines += "POWER  $($p.Setting) -> $($p.Value)  (active plan)" } }
    foreach ($k in @($t.Tasks)) { if ($k) { $lines += "TASK  disable $k" } }
    foreach ($a in @($t.Appx))  { if ($a) { $lines += "APP  remove $a" } }
    if ($t.Note) { $lines += $t.Note }
    if ($lines.Count -eq 0) { $lines += 'System command (see description).' }
    return ($lines -join "`n")
}

# ================================================================ TWEAK CATALOG
$SUB_PROC = '54533251-82be-4824-96c1-47b60b740d00'
$SUB_PCIE = '501a4d13-42af-4429-9fd1-a8218c268e20'
$SUB_USB  = '2a737441-1930-4402-8d77-b2bebba308a3'
$SUB_DISK = '0012ee47-9041-4b5d-9b77-535fba8b1442'
$ZEN_PLAN  = 'f7a1c0de-3f05-4e2b-9a6b-1c2d3e4f5a6b'
$CDM      = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
$ADV      = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$MMCSS    = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile'
$MEMMGMT  = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'

# ---------------------------------------------------------------- POWER & CPU
Add-Tweak @{ Id='pwr_plan'; Cat='Power & CPU'; Name='Zenith Ultimate Performance Plan'; Impact='High'; Rec=$true; Tags=@('Power Hungry')
    Desc='Creates and activates a dedicated Ultimate Performance power plan so the CPU never waits to ramp up its clocks. Removes the latency of the Balanced plan''s power-saving states. Applied first so the power tweaks below land on this plan.'
    Kind='POWER'
    Note='POWER  duplicate Ultimate Performance (e9a42b02...) as "Zenith Ultimate Performance" and activate it'
    Test={ (Get-ActiveSchemeGuid) -eq $ZEN_PLAN }
    Apply={
        $prev = Get-ActiveSchemeGuid
        $list = (& powercfg.exe /list) | Out-String
        if ($list -notmatch $ZEN_PLAN) {
            & powercfg.exe /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 $ZEN_PLAN 2>$null | Out-Null
            $list = (& powercfg.exe /list) | Out-String
            if ($list -notmatch $ZEN_PLAN) { & powercfg.exe /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c $ZEN_PLAN 2>$null | Out-Null }
            & powercfg.exe /changename $ZEN_PLAN 'Zenith Ultimate Performance' 'Maximum performance plan created by Zenith' 2>$null | Out-Null
        }
        & powercfg.exe /setactive $ZEN_PLAN 2>$null | Out-Null
        @{ Prev = $prev }
    }
    Revert={ param($c)
        $prev = '381b4222-f694-41f0-9685-ff5bb260df2e'
        if ($c -and $c.Prev -and $c.Prev -ne $ZEN_PLAN) { $prev = $c.Prev }
        & powercfg.exe /setactive $prev 2>$null | Out-Null
        & powercfg.exe /delete $ZEN_PLAN 2>$null | Out-Null
    } }

Add-Tweak @{ Id='pwr_coreparking'; Cat='Power & CPU'; Name='Disable CPU Core Parking'; Impact='Medium'; Rec=$true; Tags=@('Power Hungry')
    Desc='Keeps every CPU core awake. A parked core that has to wake up during a frame can cause micro-stutter - most noticeable on CPUs with 4-6 cores.'
    Pow=@( (PwrV $SUB_PROC '0cc5b647-c1df-4637-891a-dec35c318583' 100 10) ) }

Add-Tweak @{ Id='pwr_minstate'; Cat='Power & CPU'; Name='Minimum Processor State 100%'; Impact='Medium'; Rec=$true; Tags=@('Power Hungry')
    Desc='Prevents Windows from down-clocking the CPU between frames, which smooths frame times in CPU-heavy games. Raises idle power and temperature.'
    Pow=@( (PwrV $SUB_PROC '893dee8e-2bef-41e0-89c6-b55d0929964c' 100 5) ) }

Add-Tweak @{ Id='pwr_boost'; Cat='Power & CPU'; Name='Aggressive Turbo Boost'; Impact='Low'; Rec=$true; Tags=@('Power Hungry')
    Desc='Sets the processor boost mode to Aggressive so the CPU jumps to its turbo clock immediately instead of easing into it.'
    Pow=@( (PwrV $SUB_PROC 'be337238-0d82-4146-a960-4f3749d470c7' 2 1) ) }

Add-Tweak @{ Id='pwr_usb'; Cat='Power & CPU'; Name='Disable USB Selective Suspend'; Impact='Low'; Rec=$true
    Desc='Stops Windows from putting USB ports to sleep. Prevents mouse, keyboard and headset dropouts or the first-input lag after they idle.'
    Pow=@( (PwrV $SUB_USB '48e6b7a6-50f5-4782-a5d4-53bb8f07e226' 0 1) ) }

Add-Tweak @{ Id='pwr_aspm'; Cat='Power & CPU'; Name='Disable PCIe Link State Power Saving'; Impact='Medium'; Rec=$true; Tags=@('Power Hungry')
    Desc='Keeps the PCIe link to the graphics card at full power. Power-saving link states add wake-up latency every time the GPU is idle for a moment.'
    Pow=@( (PwrV $SUB_PCIE 'ee12f906-d277-404b-b6da-e5fa1a576df5' 0 1) ) }

Add-Tweak @{ Id='pwr_diskidle'; Cat='Power & CPU'; Name='Never Spin Down Hard Drives'; Impact='Medium'; Rec=$true; Tags=@('HDD')
    Desc='When a sleeping hard drive spins back up you get a 2-5 second freeze while a game loads assets. This keeps hard drives spinning.'
    Pow=@( (PwrV $SUB_DISK '6738e2c4-e8a5-4a42-b16a-e040e769756e' 0 1200) ) }

Add-Tweak @{ Id='pwr_hibernate'; Cat='Power & CPU'; Name='Disable Hibernation & Fast Startup'; Impact='Medium'; Rec=$true; Tags=@('Reboot')
    Desc='Deletes hiberfil.sys (about 40% of your RAM size) and turns off Fast Startup, which keeps drivers in a half-saved state between boots and is a common cause of stutter and driver glitches.'
    Kind='SYSTEM'; Note='CMD  powercfg /hibernate off'
    Test={ (Get-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Power' 'HibernateEnabled').Value -eq 0 }
    Apply={ & powercfg.exe /hibernate off 2>$null | Out-Null; $null }
    Revert={ param($c) & powercfg.exe /hibernate on 2>$null | Out-Null } }

Add-Tweak @{ Id='fps_powerthrottle'; Cat='Power & CPU'; Name='Disable Windows Power Throttling'; Impact='Medium'; Rec=$true; Tags=@('Power Hungry','Reboot')
    Desc='Power Throttling slows background processes to save energy - but Windows sometimes classifies game helpers, voice chat or overlays as background. This turns it off system-wide.'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling' 'PowerThrottlingOff' 'DWord' 1 $null) ) }

# ---------------------------------------------------------------- FPS & LATENCY
Add-Tweak @{ Id='fps_gamemode'; Cat='FPS & Latency'; Name='Enable Windows Game Mode'; Impact='High'; Rec=$true
    Desc='Game Mode stops Windows Update from installing drivers and showing restart prompts while you play and gives the game priority over background work.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\GameBar' 'AutoGameModeEnabled' 'DWord' 1 $null), (RegV 'HKCU:\Software\Microsoft\GameBar' 'AllowAutoGameMode' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='fps_gamedvr'; Cat='FPS & Latency'; Name='Disable Game DVR Background Recording'; Impact='High'; Rec=$true
    Desc='Background recording constantly encodes your gameplay, which costs FPS - and on GPUs without a video encoder that work falls on the CPU. Use your GPU app, Medal or OBS for clips instead.'
    Reg=@( (RegV 'HKCU:\System\GameConfigStore' 'GameDVR_Enabled' 'DWord' 0 1),
           (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR' 'AppCaptureEnabled' 'DWord' 0 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' 'AllowGameDVR' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='fps_gamebar'; Cat='FPS & Latency'; Name='Disable Xbox Game Bar Overlay'; Impact='Medium'; Rec=$true; Tags=@('Feature Breaking')
    Desc='Stops the Win+G overlay from hooking into every game. Saves RAM and removes an overlay layer. You lose the Game Bar widgets (use MSI Afterburner or Steam''s overlay instead).'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\GameBar' 'UseNexusForGameBarEnabled' 'DWord' 0 $null), (RegV 'HKCU:\Software\Microsoft\GameBar' 'ShowStartupPanel' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='fps_hpet'; Cat='FPS & Latency'; Name='Ensure HPET Is Not Forced'; Impact='Medium'; Rec=$true; Tags=@('Reboot')
    Desc='Some "optimizers" force the slow HPET timer as the only clock source, which adds overhead to every timer call. This removes that override so Windows uses the faster TSC timer built into modern CPUs.'
    Kind='BOOT'; Note='CMD  bcdedit /deletevalue useplatformclock'
    Test={ $o = (& bcdedit.exe /enum '{current}') | Out-String; -not ($o -match 'useplatformclock') }
    Apply={ $o = (& bcdedit.exe /enum '{current}') | Out-String; $was = $o -match 'useplatformclock'; & bcdedit.exe /deletevalue useplatformclock 2>$null | Out-Null; @{ Was = $was } }
    Revert={ param($c) if ($c -and $c.Was) { & bcdedit.exe /set useplatformclock true 2>$null | Out-Null } } }

Add-Tweak @{ Id='fps_dyntick'; Cat='FPS & Latency'; Name='Disable Dynamic Tick'; Impact='Low'; Rec=$false; Risk='Moderate'; Tags=@('Power Hungry','Reboot')
    Desc='Keeps the system timer ticking at a constant rate instead of pausing it to save power. Can make input and frame pacing a little more consistent. Desktop only - raises idle power slightly.'
    Kind='BOOT'; Note='CMD  bcdedit /set disabledynamictick yes'
    Test={ $o = (& bcdedit.exe /enum '{current}') | Out-String; $o -match 'disabledynamictick' }
    Apply={ & bcdedit.exe /set disabledynamictick yes 2>$null | Out-Null; $null }
    Revert={ param($c) & bcdedit.exe /deletevalue disabledynamictick 2>$null | Out-Null } }

Add-Tweak @{ Id='fps_fso'; Cat='FPS & Latency'; Name='Disable Fullscreen Optimizations (Global)'; Impact='Low'; Rec=$false; Risk='Moderate'
    Desc='Forces classic exclusive fullscreen in older DirectX 9/11 games, which can lower input latency. On Windows 11 the default (flip model) is often just as good - test with your games.'
    Reg=@( (RegV 'HKCU:\System\GameConfigStore' 'GameDVR_FSEBehaviorMode' 'DWord' 2 2),
           (RegV 'HKCU:\System\GameConfigStore' 'GameDVR_HonorUserFSEBehaviorMode' 'DWord' 1 0),
           (RegV 'HKCU:\System\GameConfigStore' 'GameDVR_FSEBehavior' 'DWord' 2 $null),
           (RegV 'HKCU:\System\GameConfigStore' 'GameDVR_DXGIHonorFSEWindowsCompatible' 'DWord' 1 0) ) }

Add-Tweak @{ Id='fps_mouse'; Cat='FPS & Latency'; Name='Disable Mouse Acceleration'; Impact='Medium'; Rec=$true; Tags=@('Sign-out')
    Desc='Turns off "Enhance pointer precision" so mouse movement is 1:1. Your aim becomes consistent because the same hand movement always turns the same distance.'
    Reg=@( (RegV 'HKCU:\Control Panel\Mouse' 'MouseSpeed' 'String' '0' '1'),
           (RegV 'HKCU:\Control Panel\Mouse' 'MouseThreshold1' 'String' '0' '6'),
           (RegV 'HKCU:\Control Panel\Mouse' 'MouseThreshold2' 'String' '0' '10') ) }

Add-Tweak @{ Id='fps_keyboard'; Cat='FPS & Latency'; Name='Fastest Keyboard Repeat Response'; Impact='Low'; Rec=$true; Tags=@('Sign-out')
    Desc='Sets the shortest key-repeat delay and the fastest repeat rate so held keys respond immediately.'
    Reg=@( (RegV 'HKCU:\Control Panel\Keyboard' 'KeyboardDelay' 'String' '0' '1'), (RegV 'HKCU:\Control Panel\Keyboard' 'KeyboardSpeed' 'String' '31' '31') ) }

Add-Tweak @{ Id='fps_bgapps'; Cat='FPS & Latency'; Name='Stop Background Apps'; Impact='Medium'; Rec=$true; Tags=@('Feature Breaking')
    Desc='Prevents Store apps (Weather, Mail, Phone Link, etc.) from running in the background and stealing CPU time from your game. Some of those apps will stop sending live notifications.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications' 'GlobalUserDisabled' 'DWord' 1 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' 'LetAppsRunInBackground' 'DWord' 2 $null) ) }

Add-Tweak @{ Id='fps_edge'; Cat='FPS & Latency'; Name='Stop Edge Startup Boost & Background Mode'; Impact='Medium'; Rec=$true
    Desc='Microsoft Edge preloads itself at boot and keeps running after you close it. This stops both, freeing RAM and CPU. (Edge will show "managed by your organization" - that is normal for this policy.)'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Edge' 'StartupBoostEnabled' 'DWord' 0 $null), (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Edge' 'BackgroundModeEnabled' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='fps_noreboot'; Cat='FPS & Latency'; Name='No Forced Update Restarts While Signed In'; Impact='Low'; Rec=$true
    Desc='Stops Windows Update from restarting the PC automatically while you are logged in - no more surprise restarts in the middle of a match.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' 'NoAutoRebootWithLoggedOnUsers' 'DWord' 1 $null) ) }

# ---------------------------------------------------------------- GPU & DISPLAY
Add-Tweak @{ Id='gpu_hags'; Cat='GPU & Display'; Name='Hardware-Accelerated GPU Scheduling'; Impact='Medium'; Rec=$true; Tags=@('Reboot')
    Desc='Lets the graphics card manage its own video memory scheduling instead of the CPU. Frees CPU time and can lower latency. Needs a recent GPU and driver - Windows ignores it on cards that do not support it.'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers' 'HwSchMode' 'DWord' 2 1) ) }

Add-Tweak @{ Id='gpu_mpo'; Cat='GPU & Display'; Name='Disable Multiplane Overlay (MPO)'; Impact='Medium'; Rec=$true; Tags=@('Reboot')
    Desc='MPO is a known cause of flickering, black screens and stutter on NVIDIA cards in borderless/windowed games. NVIDIA itself has published this fix. Safe to undo.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Microsoft\Windows\Dwm' 'OverlayTestMode' 'DWord' 5 $null) ) }

Add-Tweak @{ Id='gpu_winopt'; Cat='GPU & Display'; Name='Optimizations for Windowed Games'; Impact='Medium'; Rec=$true; Only='Win11'; Tags=@('Win11')
    Desc='Upgrades older DirectX 10/11 games running in borderless or windowed mode to the modern flip presentation model - lower latency, close to exclusive fullscreen.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\DirectX\UserGpuPreferences' 'DirectXUserGlobalSettings' 'String' 'SwapEffectUpgradeEnable=1;' $null) ) }

Add-Tweak @{ Id='gpu_msi'; Cat='GPU & Display'; Name='Enable MSI Mode for NVIDIA GPU'; Impact='Low'; Rec=$false; Risk='Moderate'; Only='NVIDIA'; Tags=@('Reboot')
    Desc='Switches the graphics card from legacy line-based interrupts to Message Signaled Interrupts, which lowers interrupt latency and avoids IRQ sharing. GeForce cards from the GTX 10-series on support it (newer RTX cards often use it already). Re-apply after a clean driver install.'
    RegFn={ if ($script:SysInfo.GpuInstanceId) { RegV "HKLM:\SYSTEM\CurrentControlSet\Enum\$($script:SysInfo.GpuInstanceId)\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" 'MSISupported' 'DWord' 1 0 } } }

Add-Tweak @{ Id='gpu_transparency'; Cat='GPU & Display'; Name='Disable Transparency Effects'; Impact='Medium'; Rec=$true
    Desc='Removes the blur/acrylic effects from the taskbar, Start and windows. Less work for the Desktop Window Manager - most noticeable on entry-level GPUs and in borderless games.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' 'EnableTransparency' 'DWord' 0 1) ) }

Add-Tweak @{ Id='gpu_visualfx'; Cat='GPU & Display'; Name='Visual Effects: Best Performance'; Impact='Medium'; Rec=$true; Tags=@('Sign-out')
    Desc='Turns off window animations, fades, shadows and Aero Peek while keeping smooth fonts and thumbnails. Windows feels snappier and the GPU does less desktop work.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' 'VisualFXSetting' 'DWord' 3 $null),
           (RegV 'HKCU:\Control Panel\Desktop' 'UserPreferencesMask' 'Binary' @(0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00) @(0x9E,0x1E,0x07,0x80,0x12,0x00,0x00,0x00)),
           (RegV 'HKCU:\Control Panel\Desktop\WindowMetrics' 'MinAnimate' 'String' '0' '1'),
           (RegV $ADV 'TaskbarAnimations' 'DWord' 0 1),
           (RegV $ADV 'ListviewAlphaSelect' 'DWord' 0 1),
           (RegV $ADV 'ListviewShadow' 'DWord' 0 1),
           (RegV 'HKCU:\Software\Microsoft\Windows\DWM' 'EnableAeroPeek' 'DWord' 0 1) ) }

Add-Tweak @{ Id='gpu_nvtelemetry'; Cat='GPU & Display'; Name='Disable NVIDIA Telemetry'; Impact='Low'; Rec=$true
    Desc='Stops the NVIDIA telemetry container and its scheduled reporting tasks. Your driver, control panel and game profiles keep working normally.'
    Svc=@( (SvcV 'NvTelemetryContainer' 'disabled' 'auto') )
    Tasks=@('\NvTmRep*', '\NvTmMon*') }

Add-Tweak @{ Id='gpu_wudrivers'; Cat='GPU & Display'; Name='Stop Windows Update Replacing Drivers'; Impact='Low'; Rec=$true
    Desc='Prevents Windows Update from silently swapping your NVIDIA driver for an older generic one (a common cause of sudden FPS drops). Update the GPU driver from nvidia.com instead.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' 'ExcludeWUDriversInQualityUpdate' 'DWord' 1 $null) ) }

# ---------------------------------------------------------------- REGISTRY (scheduler / kernel)
Add-Tweak @{ Id='reg_mmcss_games'; Cat='Registry'; Name='Prioritize Games in the Multimedia Scheduler'; Impact='High'; Rec=$true
    Desc='Raises the MMCSS "Games" task profile to High scheduling category, CPU priority 6 and GPU priority 8, so game threads registered with MMCSS win against background work.'
    Reg=@( (RegV "$MMCSS\Tasks\Games" 'GPU Priority' 'DWord' 8 8),
           (RegV "$MMCSS\Tasks\Games" 'Priority' 'DWord' 6 2),
           (RegV "$MMCSS\Tasks\Games" 'Scheduling Category' 'String' 'High' 'Medium'),
           (RegV "$MMCSS\Tasks\Games" 'SFIO Priority' 'String' 'High' 'Normal') ) }

Add-Tweak @{ Id='reg_sysresp'; Cat='Registry'; Name='System Responsiveness for Gaming'; Impact='Low'; Rec=$false
    Desc='Lowers the CPU share Windows reserves for background tasks during multimedia/gaming from 20% to the minimum of 10%, giving more CPU time to the game. Little to no measurable effect on modern Windows - kept for completeness, not recommended.'
    Reg=@( (RegV $MMCSS 'SystemResponsiveness' 'DWord' 10 20) ) }

Add-Tweak @{ Id='reg_priosep'; Cat='Registry'; Name='Foreground Priority Boost (Win32PrioritySeparation)'; Impact='Low'; Rec=$false
    Desc='Sets short, variable CPU time slices with maximum boost for the focused window (value 0x26). The game you are playing gets the CPU first. Little to no measurable effect on modern Windows - kept for completeness, not recommended.'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl' 'Win32PrioritySeparation' 'DWord' 38 2) ) }

Add-Tweak @{ Id='reg_timerres'; Cat='Registry'; Name='Global Timer Resolution Requests'; Impact='Medium'; Rec=$true; Tags=@('Reboot')
    Desc='Windows 11 ignores high-resolution timer requests from minimized or background processes. This restores the classic global behaviour so games and frame limiters get precise 0.5-1 ms timers.'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel' 'GlobalTimerResolutionRequests' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='reg_pagingexec'; Cat='Registry'; Name='Keep Kernel & Drivers in RAM'; Impact='Low'; Rec=$true; Tags=@('Reboot')
    Desc='With 16 GB or more of RAM there is no reason to page kernel code and drivers to disk. Setting DisablePagingExecutive keeps them in memory - especially helpful if Windows is on a hard drive.'
    Reg=@( (RegV $MEMMGMT 'DisablePagingExecutive' 'DWord' 1 0) ) }

Add-Tweak @{ Id='reg_svchost'; Cat='Registry'; Name='Group Service Host Processes'; Impact='Low'; Rec=$false; Tags=@('Reboot')
    Desc='Sets SvcHostSplitThresholdInKB to your installed RAM so Windows groups services into fewer svchost.exe processes - roughly 70 fewer processes. No measurable FPS gain, and a crashing service can take the others in its group down with it - not recommended.'
    RegFn={ $kb = [int]([math]::Min(2147483647, [math]::Max(3670016, $script:SysInfo.RamBytes / 1KB))); RegV 'HKLM:\SYSTEM\CurrentControlSet\Control' 'SvcHostSplitThresholdInKB' 'DWord' $kb 3670016 } }

Add-Tweak @{ Id='reg_menudelay'; Cat='Registry'; Name='Instant Menus'; Impact='Low'; Rec=$true
    Desc='Removes the 400 ms delay before context sub-menus open (MenuShowDelay = 0). The desktop feels instantly responsive.'
    Reg=@( (RegV 'HKCU:\Control Panel\Desktop' 'MenuShowDelay' 'String' '0' '400') ) }

Add-Tweak @{ Id='reg_startupdelay'; Cat='Registry'; Name='Remove Startup App Delay'; Impact='Low'; Rec=$true
    Desc='Windows deliberately waits before launching startup apps. This removes that artificial delay so the desktop is usable sooner after boot.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize' 'StartupDelayInMSec' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='reg_shutdown'; Cat='Registry'; Name='Faster Shutdown & Hung-App Detection'; Impact='Low'; Rec=$true
    Desc='Shortens how long Windows waits for frozen apps and services when shutting down or restarting (HungAppTimeout, WaitToKillAppTimeout, WaitToKillServiceTimeout). Apps still get a chance to save.'
    Reg=@( (RegV 'HKCU:\Control Panel\Desktop' 'HungAppTimeout' 'String' '2000' $null),
           (RegV 'HKCU:\Control Panel\Desktop' 'WaitToKillAppTimeout' 'String' '4000' $null),
           (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control' 'WaitToKillServiceTimeout' 'String' '2000' '5000') ) }

# ---------------------------------------------------------------- MEMORY & STORAGE
Add-Tweak @{ Id='mem_compression'; Cat='Memory & Storage'; Name='Disable Memory Compression'; Impact='Low'; Rec=$false; Tags=@('Reboot')
    Desc='Memory compression trades CPU time for RAM. The CPU cost is tiny, and once RAM fills up compressing is much faster than paging to disk - turning it off can make that worse. Not recommended.'
    Kind='SYSTEM'; Note='CMD  Disable-MMAgent -MemoryCompression'
    Test={ try { $m = Get-MMAgent -ErrorAction Stop; -not $m.MemoryCompression } catch { 'NA' } }
    Apply={ Disable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue; $null }
    Revert={ param($c) Enable-MMAgent -MemoryCompression -ErrorAction SilentlyContinue } }

Add-Tweak @{ Id='mem_sysmain'; Cat='Memory & Storage'; Name='Disable SysMain (Superfetch)'; Impact='Medium'; Rec=$false; Tags=@('SSD')
    Desc='SysMain preloads apps into RAM. On an SSD it mostly causes background disk and CPU activity. If Windows is on a hard drive, keep it ON - Zenith recommends this only when your system drive is an SSD.'
    Svc=@( (SvcV 'SysMain' 'disabled' 'auto') ) }

Add-Tweak @{ Id='mem_search'; Cat='Memory & Storage'; Name='Disable Search Indexing'; Impact='Medium'; Rec=$false; Tags=@('Feature Breaking')
    Desc='The indexer crawls your files in the background, causing disk thrashing on hard drives. Start-menu app search still works, but searching file contents becomes slower.'
    Svc=@( (SvcV 'WSearch' 'disabled' 'delayed-auto') ) }

Add-Tweak @{ Id='sto_lastaccess'; Cat='Memory & Storage'; Name='Disable NTFS Last-Access Timestamps'; Impact='Low'; Rec=$true
    Desc='Stops NTFS from writing a timestamp every time a file is read. Games read thousands of files - this removes those extra disk writes.'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' 'NtfsDisableLastAccessUpdate' 'DWord' -2147483647 -2147483646) )
    Test={ $v = (Get-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' 'NtfsDisableLastAccessUpdate').Value; ($null -ne $v) -and (([int64]$v -band 1) -eq 1) } }

Add-Tweak @{ Id='sto_8dot3'; Cat='Memory & Storage'; Name='Disable 8.3 Short File Names'; Impact='Low'; Rec=$true
    Desc='Stops NTFS creating legacy DOS-style "PROGRA~1" names for every new file, which speeds up file creation in folders with many files (game installs, shader caches).'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' 'NtfsDisable8dot3NameCreation' 'DWord' 1 2) ) }

# ---------------------------------------------------------------- NETWORK & PING
Add-Tweak @{ Id='net_nagle'; Cat='Network & Ping'; Name="Disable Nagle's Algorithm"; Impact='Low'; Rec=$false
    Desc='Sends small TCP packets immediately instead of bundling them. Can help a few TCP-based games (some MMOs); most games use UDP, where it does nothing. Not recommended.'
    RegFn={
        Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces' -ErrorAction SilentlyContinue | ForEach-Object {
            $p = Get-ItemProperty -LiteralPath $_.PSPath -ErrorAction SilentlyContinue
            $ip = "$($p.DhcpIPAddress) $(@($p.IPAddress) -join ' ')"
            if ($ip -match '\d+\.\d+\.\d+\.\d+' -and $ip -notmatch '^\s*0\.0\.0\.0\s*$') {
                $path = $_.PSPath -replace '^Microsoft\.PowerShell\.Core\\Registry::HKEY_LOCAL_MACHINE', 'HKLM:'
                RegV $path 'TcpAckFrequency' 'DWord' 1 $null
                RegV $path 'TCPNoDelay' 'DWord' 1 $null
            }
        } } }

Add-Tweak @{ Id='net_throttle'; Cat='Network & Ping'; Name='Disable Network Throttling'; Impact='Low'; Rec=$false
    Desc='Windows throttles non-multimedia network traffic while media plays. Setting NetworkThrottlingIndex to off removes that cap. Little to no measurable effect on modern Windows - kept for completeness, not recommended.'
    Reg=@( (RegV $MMCSS 'NetworkThrottlingIndex' 'DWord' -1 10) ) }

Add-Tweak @{ Id='net_nicpower'; Cat='Network & Ping'; Name='Disable Network Adapter Power Saving'; Impact='Low'; Rec=$true
    Desc='Stops Windows from turning off your network adapter to save power, which can cause lag spikes and brief disconnects.'
    Kind='SYSTEM'; Note='NET  "Allow the computer to turn off this device" = off on physical adapters'
    Test={
        $ok = $true; $n = 0
        Get-NetAdapter -Physical -ErrorAction SilentlyContinue | ForEach-Object {
            $pm = Get-NetAdapterPowerManagement -Name $_.Name -ErrorAction SilentlyContinue
            if ($pm -and "$($pm.AllowComputerToTurnOffDevice)" -ne 'Unsupported') { $n++; if ("$($pm.AllowComputerToTurnOffDevice)" -ne 'Disabled') { $ok = $false } }
        }
        if ($n -eq 0) { 'NA' } else { $ok } }
    Apply={
        Get-NetAdapter -Physical -ErrorAction SilentlyContinue | ForEach-Object {
            $pm = Get-NetAdapterPowerManagement -Name $_.Name -ErrorAction SilentlyContinue
            if ($pm -and "$($pm.AllowComputerToTurnOffDevice)" -ne 'Unsupported') { $pm.AllowComputerToTurnOffDevice = 'Disabled'; $pm | Set-NetAdapterPowerManagement -ErrorAction SilentlyContinue }
        }; $null }
    Revert={ param($c)
        Get-NetAdapter -Physical -ErrorAction SilentlyContinue | ForEach-Object {
            $pm = Get-NetAdapterPowerManagement -Name $_.Name -ErrorAction SilentlyContinue
            if ($pm -and "$($pm.AllowComputerToTurnOffDevice)" -ne 'Unsupported') { $pm.AllowComputerToTurnOffDevice = 'Enabled'; $pm | Set-NetAdapterPowerManagement -ErrorAction SilentlyContinue }
        } } }

Add-Tweak @{ Id='net_dosvc'; Cat='Network & Ping'; Name='Stop Peer-to-Peer Update Uploads'; Impact='Medium'; Rec=$true
    Desc='Delivery Optimization uploads Windows updates to other PCs over your internet connection in the background, which can spike your ping. Updates still download normally.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization' 'DODownloadMode' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='net_dns'; Cat='Network & Ping'; Name='Use Cloudflare DNS (1.1.1.1)'; Impact='Low'; Rec=$false
    Desc='Switches active adapters to Cloudflare''s fast DNS resolvers. Speeds up server lookups and launcher logins; does not change in-game ping. Reverting restores your previous DNS settings.'
    Kind='NETWORK'; Note='NET  IPv4 DNS = 1.1.1.1, 1.0.0.1 on connected adapters'
    Test={ $d = Get-DnsClientServerAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue | Where-Object { $_.ServerAddresses -contains '1.1.1.1' }; [bool]$d }
    Apply={
        $saved = @()
        Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Where-Object Status -eq 'Up' | ForEach-Object {
            $guid = $_.InterfaceGuid
            $static = (Get-RegValue "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$guid" 'NameServer').Value
            $saved += [pscustomobject]@{ Index = $_.ifIndex; Static = "$static" }
            Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses '1.1.1.1', '1.0.0.1' -ErrorAction SilentlyContinue
        }
        Clear-DnsClientCache -ErrorAction SilentlyContinue
        @{ Adapters = $saved } }
    Revert={ param($c)
        if ($c -and $c.Adapters) {
            foreach ($a in @($c.Adapters)) {
                if ([string]::IsNullOrWhiteSpace($a.Static)) { Set-DnsClientServerAddress -InterfaceIndex $a.Index -ResetServerAddresses -ErrorAction SilentlyContinue }
                else { Set-DnsClientServerAddress -InterfaceIndex $a.Index -ServerAddresses ($a.Static -split '[, ]+' | Where-Object { $_ }) -ErrorAction SilentlyContinue }
            }
        } else {
            Get-NetAdapter -Physical -ErrorAction SilentlyContinue | ForEach-Object { Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ResetServerAddresses -ErrorAction SilentlyContinue }
        }
        Clear-DnsClientCache -ErrorAction SilentlyContinue } }

# ---------------------------------------------------------------- DEBLOAT
Add-Tweak @{ Id='dbl_copilot'; Cat='Debloat'; Name='Disable Copilot'; Impact='Low'; Rec=$true
    Desc='Turns off Windows Copilot and hides its taskbar button so it never loads in the background.'
    Reg=@( (RegV 'HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot' 'TurnOffWindowsCopilot' 'DWord' 1 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot' 'TurnOffWindowsCopilot' 'DWord' 1 $null),
           (RegV $ADV 'ShowCopilotButton' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='dbl_widgets'; Cat='Debloat'; Name='Disable Widgets / News & Interests'; Impact='Medium'; Rec=$true
    Desc='Removes the Widgets board (Windows 11) and News & Interests (Windows 10). They run a hidden Edge WebView in the background that uses 100-300 MB of RAM and CPU.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Dsh' 'AllowNewsAndInterests' 'DWord' 0 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' 'EnableFeeds' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='dbl_bing'; Cat='Debloat'; Name='Remove Bing Web Results from Start Search'; Impact='Low'; Rec=$true
    Desc='Start-menu search stays local - faster results and no web queries sent to Bing every time you type.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' 'BingSearchEnabled' 'DWord' 0 $null),
           (RegV 'HKCU:\Software\Policies\Microsoft\Windows\Explorer' 'DisableSearchBoxSuggestions' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='dbl_autoinstall'; Cat='Debloat'; Name='Block Auto-Installed Sponsored Apps'; Impact='Medium'; Rec=$true
    Desc='Stops Windows from silently installing promoted apps and games (Candy Crush, TikTok, etc.) after updates.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' 'DisableWindowsConsumerFeatures' 'DWord' 1 $null),
           (RegV $CDM 'SilentInstalledAppsEnabled' 'DWord' 0 1),
           (RegV $CDM 'PreInstalledAppsEnabled' 'DWord' 0 1),
           (RegV $CDM 'OemPreInstalledAppsEnabled' 'DWord' 0 1) ) }

Add-Tweak @{ Id='dbl_startads'; Cat='Debloat'; Name='Remove Start Menu Suggestions & Tips'; Impact='Low'; Rec=$true
    Desc='Removes promoted apps in Start, "tips & tricks" pop-ups and the post-update welcome experience.'
    Reg=@( (RegV $CDM 'SystemPaneSuggestionsEnabled' 'DWord' 0 1),
           (RegV $CDM 'SubscribedContent-338388Enabled' 'DWord' 0 1),
           (RegV $CDM 'SubscribedContent-338389Enabled' 'DWord' 0 1),
           (RegV $CDM 'SubscribedContent-310093Enabled' 'DWord' 0 1),
           (RegV $CDM 'SoftLandingEnabled' 'DWord' 0 1),
           (RegV $ADV 'Start_IrisRecommendations' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='dbl_settingsads'; Cat='Debloat'; Name='Remove Windows Settings Ads'; Impact='Low'; Rec=$true
    Desc='Removes promotional suggestions and ads from the Windows Settings app.'
    Reg=@( (RegV $CDM 'SubscribedContent-338393Enabled' 'DWord' 0 1),
           (RegV $CDM 'SubscribedContent-353694Enabled' 'DWord' 0 1),
           (RegV $CDM 'SubscribedContent-353696Enabled' 'DWord' 0 1) ) }

Add-Tweak @{ Id='dbl_lockads'; Cat='Debloat'; Name='Remove Lock Screen Ads & Fun Facts'; Impact='Low'; Rec=$true
    Desc='Removes "fun facts", tips and promotions printed on top of the lock-screen picture.'
    Reg=@( (RegV $CDM 'RotatingLockScreenOverlayEnabled' 'DWord' 0 1), (RegV $CDM 'SubscribedContent-338387Enabled' 'DWord' 0 1) ) }

Add-Tweak @{ Id='dbl_recall'; Cat='Debloat'; Name='Disable Recall Snapshots'; Impact='Low'; Rec=$true; Only='Win11'; Tags=@('Win11')
    Desc='Blocks the Windows Recall feature from taking screenshots of your activity (where present).'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI' 'DisableAIDataAnalysis' 'DWord' 1 $null),
           (RegV 'HKCU:\Software\Policies\Microsoft\Windows\WindowsAI' 'DisableAIDataAnalysis' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='dbl_onedrive'; Cat='Debloat'; Name='Prevent OneDrive from Running'; Impact='Medium'; Rec=$false; Tags=@('Feature Breaking')
    Desc='Stops OneDrive from starting and syncing in the background (it can saturate your disk and upload bandwidth). Only use this if you don''t rely on OneDrive.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' 'DisableFileSyncNGSC' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='dbl_apps_news'; Cat='Debloat'; Name='Remove News, Weather, Maps & Tips Apps'; Impact='Low'; Rec=$true; Tags=@('Not Reversible')
    Desc='Uninstalls Microsoft News, Weather, Maps, Get Started/Tips, Get Help and Feedback Hub. Any of them can be reinstalled from the Microsoft Store.'
    Appx=@('Microsoft.BingNews','Microsoft.BingWeather','Microsoft.WindowsMaps','Microsoft.Getstarted','Microsoft.GetHelp','Microsoft.WindowsFeedbackHub') }

Add-Tweak @{ Id='dbl_apps_office'; Cat='Debloat'; Name='Remove Office Hub, To Do, Clipchamp & Teams'; Impact='Low'; Rec=$true; Tags=@('Not Reversible')
    Desc='Uninstalls the Microsoft 365 hub, To Do, Power Automate, Clipchamp, Teams (personal), Skype, People and the Copilot app. Reinstall from the Store if needed.'
    Appx=@('Microsoft.MicrosoftOfficeHub','Microsoft.Todos','Microsoft.PowerAutomateDesktop','Clipchamp.Clipchamp','MicrosoftTeams','MSTeams','Microsoft.SkypeApp','Microsoft.People','Microsoft.Copilot') }

Add-Tweak @{ Id='dbl_apps_sponsored'; Cat='Debloat'; Name='Remove Sponsored Games & Apps'; Impact='Low'; Rec=$true; Tags=@('Not Reversible')
    Desc='Uninstalls pre-installed promos such as Candy Crush, Solitaire Collection, TikTok, Facebook, Instagram, Disney+ and Prime Video. Your own Steam / Xbox games are not touched.'
    Appx=@('king.com.*','*CandyCrush*','Microsoft.MicrosoftSolitaireCollection','BytedancePte.Ltd.TikTok','Facebook.*','Disney.*','AmazonVideo.PrimeVideo') }

Add-Tweak @{ Id='dbl_apps_legacy'; Cat='Debloat'; Name='Remove Cortana, 3D Viewer & Mixed Reality'; Impact='Low'; Rec=$true; Tags=@('Not Reversible')
    Desc='Uninstalls Cortana, 3D Viewer, Mixed Reality Portal and Microsoft Wallet - leftovers nobody uses on a gaming desktop.'
    Appx=@('Microsoft.549981C3F5F10','Microsoft.Microsoft3DViewer','Microsoft.MixedReality.Portal','Microsoft.Wallet') }

Add-Tweak @{ Id='dbl_services'; Cat='Debloat'; Name='Disable Unused Services'; Impact='Low'; Rec=$true
    Desc='Disables Fax, Retail Demo, Downloaded Maps Manager, Remote Registry, Windows Media Player network sharing and the Insider service - none are needed on a gaming PC.'
    Svc=@( (SvcV 'Fax' 'disabled' 'demand'), (SvcV 'RetailDemo' 'disabled' 'demand'), (SvcV 'MapsBroker' 'disabled' 'delayed-auto'),
           (SvcV 'RemoteRegistry' 'disabled' 'disabled'), (SvcV 'WMPNetworkSvc' 'disabled' 'demand'), (SvcV 'wisvc' 'disabled' 'demand') ) }

Add-Tweak @{ Id='dbl_xbox'; Cat='Debloat'; Name='Disable Xbox Live Services'; Impact='Low'; Rec=$false; Tags=@('Feature Breaking')
    Desc='Turns off Xbox Live auth, cloud saves and networking services. Only apply this if you do NOT use the Xbox app, Game Pass or Microsoft Store games. Controllers keep working.'
    Svc=@( (SvcV 'XblAuthManager' 'disabled' 'demand'), (SvcV 'XblGameSave' 'disabled' 'demand'), (SvcV 'XboxNetApiSvc' 'disabled' 'demand') ) }

Add-Tweak @{ Id='dbl_spooler'; Cat='Debloat'; Name='Disable Print Spooler'; Impact='Low'; Rec=$false; Tags=@('Feature Breaking')
    Desc='If you have no printer, the Print Spooler is wasted RAM and a known attack surface. Printing (including "Print to PDF") stops working until reverted.'
    Svc=@( (SvcV 'Spooler' 'disabled' 'auto') ) }

# ---------------------------------------------------------------- PRIVACY & TELEMETRY
Add-Tweak @{ Id='prv_telemetry'; Cat='Privacy'; Name='Minimize Windows Telemetry'; Impact='Medium'; Rec=$true
    Desc='Sets diagnostic data to the lowest level your edition allows and stops feedback prompts. Less background data collection and uploading.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' 'AllowTelemetry' 'DWord' 0 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' 'DoNotShowFeedbackNotifications' 'DWord' 1 $null),
           (RegV 'HKCU:\Software\Microsoft\Siuf\Rules' 'NumberOfSIUFInPeriod' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='prv_diagtrack'; Cat='Privacy'; Name='Disable Telemetry Services (DiagTrack)'; Impact='Medium'; Rec=$true
    Desc='Disables the Connected User Experiences and Telemetry service and the WAP push service that feeds it. These periodically wake up, scan the system and upload data.'
    Svc=@( (SvcV 'DiagTrack' 'disabled' 'auto'), (SvcV 'dmwappushservice' 'disabled' 'demand') ) }

Add-Tweak @{ Id='prv_tasks'; Cat='Privacy'; Name='Disable Telemetry Scheduled Tasks'; Impact='Medium'; Rec=$true
    Desc='Disables the Compatibility Appraiser, Customer Experience Improvement Program and disk-diagnostic tasks. The Appraiser in particular can spike CPU and disk for minutes - sometimes mid-game.'
    Tasks=@('\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser',
            '\Microsoft\Windows\Application Experience\ProgramDataUpdater',
            '\Microsoft\Windows\Customer Experience Improvement Program\Consolidator',
            '\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip',
            '\Microsoft\Windows\Autochk\Proxy',
            '\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector',
            '\Microsoft\Windows\Feedback\Siuf\DmClient',
            '\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload') }

Add-Tweak @{ Id='prv_adid'; Cat='Privacy'; Name='Disable Advertising ID'; Impact='Low'; Rec=$true
    Desc='Stops apps from using your advertising ID to track you across apps for personalized ads.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo' 'Enabled' 'DWord' 0 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo' 'DisabledByGroupPolicy' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='prv_tailored'; Cat='Privacy'; Name='Disable Tailored Experiences'; Impact='Low'; Rec=$true
    Desc='Stops Microsoft using your diagnostic data to show personalized tips, ads and recommendations.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy' 'TailoredExperiencesWithDiagnosticDataEnabled' 'DWord' 0 $null),
           (RegV 'HKCU:\Software\Policies\Microsoft\Windows\CloudContent' 'DisableTailoredExperiencesWithDiagnosticData' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='prv_activity'; Cat='Privacy'; Name='Disable Activity History'; Impact='Low'; Rec=$true
    Desc='Stops Windows from recording and uploading a timeline of the apps and files you open.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' 'EnableActivityFeed' 'DWord' 0 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' 'PublishUserActivities' 'DWord' 0 $null),
           (RegV 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' 'UploadUserActivities' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='prv_wer'; Cat='Privacy'; Name='Disable Windows Error Reporting'; Impact='Low'; Rec=$true
    Desc='Stops crash-dump collection and upload after an app crashes - which otherwise eats CPU and disk right after a game crash.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' 'Disabled' 'DWord' 1 $null) )
    Svc=@( (SvcV 'WerSvc' 'disabled' 'demand') ) }

Add-Tweak @{ Id='prv_inking'; Cat='Privacy'; Name='Disable Typing & Inking Data Collection'; Impact='Low'; Rec=$true
    Desc='Stops Windows collecting your typing and handwriting patterns and contacts to "improve" the keyboard dictionary.'
    Reg=@( (RegV 'HKCU:\Software\Microsoft\InputPersonalization' 'RestrictImplicitInkCollection' 'DWord' 1 0),
           (RegV 'HKCU:\Software\Microsoft\InputPersonalization' 'RestrictImplicitTextCollection' 'DWord' 1 0),
           (RegV 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore' 'HarvestContacts' 'DWord' 0 1),
           (RegV 'HKCU:\Software\Microsoft\Personalization\Settings' 'AcceptedPrivacyPolicy' 'DWord' 0 1) ) }

Add-Tweak @{ Id='prv_remote'; Cat='Privacy'; Name='Disable Remote Assistance'; Impact='Low'; Rec=$true
    Desc='Closes the Remote Assistance invitation feature - a favourite of tech-support scammers. Remote Desktop and Quick Assist are not affected.'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' 'fAllowToGetHelp' 'DWord' 0 1) ) }

Add-Tweak @{ Id='prv_location'; Cat='Privacy'; Name='Disable Location Services'; Impact='Low'; Rec=$false; Tags=@('Feature Breaking')
    Desc='Turns off location access for all apps. Weather, Maps and "Find my device" will no longer know where you are.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' 'Value' 'String' 'Deny' 'Allow') ) }

# ---------------------------------------------------------------- QUALITY OF LIFE
Add-Tweak @{ Id='qol_stickykeys'; Cat='Quality of Life'; Name='Disable Sticky / Filter / Toggle Keys Pop-ups'; Impact='Low'; Rec=$true
    Desc='Pressing Shift five times in a game will no longer minimize it to ask about Sticky Keys. The accessibility features themselves still work from Settings.'
    Reg=@( (RegV 'HKCU:\Control Panel\Accessibility\StickyKeys' 'Flags' 'String' '506' '510'),
           (RegV 'HKCU:\Control Panel\Accessibility\ToggleKeys' 'Flags' 'String' '58' '62'),
           (RegV 'HKCU:\Control Panel\Accessibility\Keyboard Response' 'Flags' 'String' '122' '126') ) }

Add-Tweak @{ Id='qol_endtask'; Cat='Quality of Life'; Name='"End Task" in Taskbar Right-Click'; Impact='Low'; Rec=$true; Only='Win11'; Tags=@('Win11')
    Desc='Adds End Task to the taskbar right-click menu so you can kill a frozen game without opening Task Manager.'
    Reg=@( (RegV "$ADV\TaskbarDeveloperSettings" 'TaskbarEndTask' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='qol_classicmenu'; Cat='Quality of Life'; Name='Classic Right-Click Menu'; Impact='Low'; Rec=$false; Only='Win11'; Tags=@('Win11')
    Desc='Brings back the full Windows 10 style context menu, which also opens faster than the new one. Explorer restarts to apply.'
    Kind='REGISTRY'; Note='REG  HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 (Default) = ""'
    Test={ Test-Path -LiteralPath 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' }
    Apply={ New-Item -Path 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' -Value '' -Force | Out-Null; Restart-Explorer; $null }
    Revert={ param($c) Remove-Item -LiteralPath 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}' -Recurse -Force -ErrorAction SilentlyContinue; Restart-Explorer } }

Add-Tweak @{ Id='qol_fileext'; Cat='Quality of Life'; Name='Show File Extensions'; Impact='Low'; Rec=$true
    Desc='Shows ".exe", ".zip" etc. in File Explorer - useful for modding games and spotting disguised malware.'
    Reg=@( (RegV $ADV 'HideFileExt' 'DWord' 0 1) ) }

Add-Tweak @{ Id='qol_thispc'; Cat='Quality of Life'; Name='Open File Explorer to This PC'; Impact='Low'; Rec=$false
    Desc='File Explorer opens straight to your drives instead of Home / Quick Access, which is faster when you have several large drives.'
    Reg=@( (RegV $ADV 'LaunchTo' 'DWord' 1 $null) ) }

Add-Tweak @{ Id='qol_verbose'; Cat='Quality of Life'; Name='Show Detailed Boot & Shutdown Status'; Impact='Low'; Rec=$false
    Desc='Displays what Windows is doing during startup and shutdown instead of a spinning circle. Helps spot slow drivers or services.'
    Reg=@( (RegV 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' 'VerboseStatus' 'DWord' 1 $null) ) }

# ---------------------------------------------------------------- ADVANCED (security trade-offs)
Add-Tweak @{ Id='adv_vbs'; Cat='Advanced'; Name='Disable Memory Integrity (VBS / HVCI)'; Impact='High'; Rec=$false; Risk='Risky'; Tags=@('Security Risk','Reboot')
    Desc='CPUs without the MBEC/GMET hardware feature (Intel 6th gen and older, first-gen Ryzen) emulate Memory Integrity in software and can lose 5-15% FPS; newer CPUs lose a few %. Disabling it lowers protection against kernel-level malware.'
    Reg=@( (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' 'Enabled' 'DWord' 0 $null),
           (RegV 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard' 'EnableVirtualizationBasedSecurity' 'DWord' 0 $null) ) }

Add-Tweak @{ Id='adv_spectre'; Cat='Advanced'; Name='Disable Spectre & Meltdown Mitigations'; Impact='High'; Rec=$false; Risk='Risky'; Tags=@('Security Risk','Reboot')
    Desc='Older Intel CPUs (8th gen and earlier) pay the highest cost for these CPU-bug patches (system calls, disk and network I/O); newer CPUs fix them in hardware and gain little. Turning them off exposes the PC to those attacks (e.g. via malicious websites).'
    Reg=@( (RegV $MEMMGMT 'FeatureSettingsOverride' 'DWord' 3 $null), (RegV $MEMMGMT 'FeatureSettingsOverrideMask' 'DWord' 3 $null) ) }

# ================================================================ STARTUP APPS
# Same sources and on/off flag as Task Manager's Startup tab: StartupApproved values whose first byte is
# odd mean "disabled". ponytail: Store-app startup tasks live elsewhere - Task Manager still covers those.
$SA = 'Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved'
$StartupSources = @(
    @{ Scope = 'This user'; List = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run';             Approved = "HKCU:\$SA\Run" }
    @{ Scope = 'All users'; List = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run';             Approved = "HKLM:\$SA\Run" }
    @{ Scope = 'All users'; List = 'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run'; Approved = "HKLM:\$SA\Run32" }
    @{ Scope = 'This user'; Folder = [Environment]::GetFolderPath('Startup');                         Approved = "HKCU:\$SA\StartupFolder" }
    @{ Scope = 'All users'; Folder = [Environment]::GetFolderPath('CommonStartup');                   Approved = "HKLM:\$SA\StartupFolder" }
)
function Get-StartupApps {
    foreach ($src in $StartupSources) {
        $items = @()
        if ($src.List) {
            $k = Get-Item -LiteralPath $src.List -ErrorAction SilentlyContinue
            if ($k) { $items = @($k.GetValueNames() | Where-Object { $_ } | ForEach-Object { [pscustomobject]@{ Name = $_; Command = "$($k.GetValue($_))"; ValueName = $_ } }) }
        } elseif ($src.Folder) {
            $items = @(Get-ChildItem -LiteralPath $src.Folder -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne 'desktop.ini' } |
                       ForEach-Object { [pscustomobject]@{ Name = $_.BaseName; Command = $_.FullName; ValueName = $_.Name } })
        }
        foreach ($it in $items) {
            $b = (Get-RegValue $src.Approved $it.ValueName).Value
            [pscustomobject]@{ Name = $it.Name; Command = $it.Command; Scope = $src.Scope; Approved = $src.Approved; ValueName = $it.ValueName
                               Enabled = -not ($b -is [byte[]] -and $b.Length -gt 0 -and ($b[0] -band 1)) }
        }
    }
}
function Set-StartupApp([string]$Approved, [string]$ValueName, [bool]$Enable) {
    $bytes = New-Object byte[] 12
    if ($Enable) { $bytes[0] = 2 } else { $bytes[0] = 3; [BitConverter]::GetBytes([DateTime]::Now.ToFileTime()).CopyTo($bytes, 4) }   # 03 + time disabled, like Task Manager
    Set-RegValue $Approved $ValueName 'Binary' $bytes
    Write-Log "Startup app '$ValueName' $(if ($Enable) { 'enabled' } else { 'disabled' })"
}

# ================================================================ PC SCANNER
function Format-Bytes([double]$b) {
    if ($b -ge 1TB) { return ('{0:N2} TB' -f ($b / 1TB)) }
    if ($b -ge 1GB) { return ('{0:N0} GB' -f ($b / 1GB)) }
    if ($b -ge 1MB) { return ('{0:N0} MB' -f ($b / 1MB)) }
    return ('{0:N0} KB' -f ($b / 1KB))
}

function Get-SystemInfo {
    $i = [ordered]@{}
    # CPU use of windowless (background) processes, sampled across this whole scan so it costs no extra time.
    $snap = { $h = @{}; foreach ($p in Get-Process -ErrorAction SilentlyContinue) { try { if ($p.MainWindowHandle -eq [IntPtr]::Zero) { $h[$p.Id] = @($p.ProcessName, $p.TotalProcessorTime.TotalMilliseconds) } } catch {} }; $h }
    $cpuA = & $snap; $cpuClock = [System.Diagnostics.Stopwatch]::StartNew()
    # ---- CPU
    $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
    $i.CpuName    = if ($cpu) { ($cpu.Name -replace '\s+', ' ').Trim() } else { 'Unknown CPU' }
    $i.CpuCores   = if ($cpu) { $cpu.NumberOfCores } else { 0 }
    $i.CpuThreads = if ($cpu) { $cpu.NumberOfLogicalProcessors } else { 0 }
    $i.CpuClock   = if ($cpu) { $cpu.MaxClockSpeed } else { 0 }
    $i.CpuL3      = if ($cpu -and $cpu.L3CacheSize) { '{0} MB' -f [math]::Round($cpu.L3CacheSize / 1024, 0) } else { '-' }
    $i.CpuSocket  = if ($cpu) { $cpu.SocketDesignation } else { '-' }

    # ---- GPU
    $gpus = @(Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue | Where-Object { $_.Name -notmatch 'Basic Display|Remote|Virtual|Meta' })
    $vram = @{}
    try {
        Get-ChildItem 'HKLM:\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}' -ErrorAction SilentlyContinue |
            Where-Object { $_.PSChildName -match '^\d{4}$' } | ForEach-Object {
                $p = Get-ItemProperty -LiteralPath $_.PSPath -ErrorAction SilentlyContinue
                $q = $p.'HardwareInformation.qwMemorySize'
                if (-not $q) { $q = $p.'HardwareInformation.MemorySize'; if ($q -is [byte[]]) { $q = [BitConverter]::ToUInt32($q, 0) } }
                if ($p.DriverDesc -and $q) { $vram[$p.DriverDesc] = [double]$q }
            }
    } catch {}
    # The real graphics card has the most dedicated VRAM; integrated GPUs only report a small shared carve-out.
    $gpu  = $gpus | Sort-Object { if ($vram[$_.Name]) { $vram[$_.Name] } else { [double][uint32]$_.AdapterRAM } } -Descending | Select-Object -First 1
    $i.GpuName   = if ($gpu) { $gpu.Name } else { 'Unknown GPU' }
    $i.GpuVendor = if ($i.GpuName -match 'NVIDIA') { 'NVIDIA' } elseif ($i.GpuName -match 'AMD|Radeon') { 'AMD' } elseif ($i.GpuName -match 'Intel') { 'Intel' } else { '' }
    $i.Displays  = @($gpus | Where-Object { $_.CurrentRefreshRate } | ForEach-Object { [pscustomobject]@{ Gpu = $_.Name; Refresh = [int]$_.CurrentRefreshRate; MaxRefresh = [int]$_.MaxRefreshRate
                                                                                                         ResX = [int]$_.CurrentHorizontalResolution; ResY = [int]$_.CurrentVerticalResolution } })
    $i.GpuDriver = if ($gpu) { $gpu.DriverVersion } else { '-' }
    $i.GpuDriverDate = $null
    if ($gpu -and $gpu.DriverDate) { $i.GpuDriverDate = $gpu.DriverDate }
    if ($gpu -and $gpu.Name -match 'NVIDIA' -and $gpu.DriverVersion) {
        $d = ($gpu.DriverVersion -replace '\.', '')
        if ($d.Length -ge 5) { $n = $d.Substring($d.Length - 5); $i.GpuDriver = '{0}.{1}  ({2})' -f $n.Substring(0, 3), $n.Substring(3), $gpu.DriverVersion }
    }
    $i.GpuVram = '-'
    if ($vram[$i.GpuName]) { $i.GpuVram = Format-Bytes $vram[$i.GpuName] }
    elseif ($gpu -and $gpu.AdapterRAM) { $i.GpuVram = Format-Bytes ([double][uint32]$gpu.AdapterRAM) }
    $i.ResX = if ($gpu) { $gpu.CurrentHorizontalResolution } else { $null }
    $i.ResY = if ($gpu) { $gpu.CurrentVerticalResolution } else { $null }
    $i.Refresh = if ($gpu) { $gpu.CurrentRefreshRate } else { $null }
    $i.GpuInstanceId = $null
    try {
        $pnp = Get-PnpDevice -Class Display -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.FriendlyName -match 'NVIDIA' } | Select-Object -First 1
        if ($pnp) { $i.GpuInstanceId = $pnp.InstanceId }
    } catch {}
    # Board maker from the PCI subsystem vendor id (SUBSYS_xxxxVVVV), e.g. 1043 = ASUS - makes part searches exact.
    $i.GpuBrand = ''
    if ($gpu -and "$($gpu.PNPDeviceID)" -match 'SUBSYS_[0-9A-F]{4}([0-9A-F]{4})') {
        $i.GpuBrand = @{ '1043' = 'ASUS'; '1458' = 'Gigabyte'; '1462' = 'MSI'; '3842' = 'EVGA'; '19DA' = 'Zotac'; '1569' = 'Palit'; '10B0' = 'Gainward'
                         '196E' = 'PNY'; '1B4C' = 'Galax'; '7377' = 'Colorful'; '1DA2' = 'Sapphire'; '148C' = 'PowerColor'; '1682' = 'XFX'; '1849' = 'ASRock' }[$Matches[1]]
        if (-not $i.GpuBrand) { $i.GpuBrand = '' }
    }
    # Resizable BAR: with it on, the CPU-visible BAR1 window spans the whole VRAM instead of 256 MB (RTX 30-series and newer only).
    $i.RebarOn = $null
    $smi = "$env:WINDIR\System32\nvidia-smi.exe"
    if ($i.GpuName -match 'RTX\s*[3-9]0[5-9]0' -and (Test-Path -LiteralPath $smi)) {
        $m = [regex]::Match(((& $smi -q -d MEMORY 2>$null) | Out-String), 'BAR1 Memory Usage\s+Total\s*:\s*(\d+)\s*MiB')
        if ($m.Success) { $i.RebarOn = ([int]$m.Groups[1].Value -gt 256) }
    }

    # ---- RAM
    $mods = @(Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue)
    $cs   = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
    $i.RamBytes  = if ($cs) { [double]$cs.TotalPhysicalMemory } else { 0 }
    $installed   = ($mods | Measure-Object -Property Capacity -Sum).Sum
    $i.RamTotal  = if ($installed) { Format-Bytes ([double]$installed) } else { Format-Bytes $i.RamBytes }
    $i.RamSticks = $mods.Count
    $speed = ($mods | Select-Object -First 1)
    $i.RamMts    = if ($speed) { if ($speed.ConfiguredClockSpeed) { [int]$speed.ConfiguredClockSpeed } else { [int]$speed.Speed } } else { 0 }
    $i.RamSpeed  = if ($i.RamMts) { "$($i.RamMts) MT/s" } else { '-' }
    $i.RamType   = if ($speed) { @{ 24 = 'DDR3'; 26 = 'DDR4'; 30 = 'LPDDR4'; 34 = 'DDR5'; 35 = 'LPDDR5' }[[int]$speed.SMBIOSMemoryType] }
    if (-not $i.RamType) { $i.RamType = 'RAM' }
    $i.RamMaker  = if ($speed -and $speed.Manufacturer) { "$($speed.Manufacturer)".Trim() } else { '-' }
    $i.RamPart   = if ($speed -and $speed.PartNumber) { "$($speed.PartNumber)".Trim() } else { '' }
    $i.IsLaptop  = ($cs -and $cs.PCSystemType -eq 2)
    # JEDEC fallback speeds: a kit rated faster runs here until XMP/EXPO is enabled in the BIOS (laptop RAM is fixed).
    $i.XmpOff    = -not $i.IsLaptop -and (($i.RamType -eq 'DDR5' -and $i.RamMts -le 4800) -or ($i.RamType -eq 'DDR4' -and $i.RamMts -le 2400))
    $slots = (Get-CimInstance Win32_PhysicalMemoryArray -ErrorAction SilentlyContinue | Measure-Object -Property MemoryDevices -Sum).Sum
    $i.RamSlots  = if ($slots) { $slots } else { '-' }
    $i.RamChannel = if ($mods.Count -ge 2) { 'Dual channel' } elseif ($mods.Count -eq 1) { 'Single channel' } else { '-' }

    # ---- Storage
    $i.Disks = @()
    $total = 0
    try {
        foreach ($d in @(Get-PhysicalDisk -ErrorAction Stop)) {
            $type = "$($d.MediaType)"
            if ("$($d.BusType)" -eq 'NVMe') { $type = 'NVMe SSD' }
            elseif ($type -eq 'Unspecified' -and $d.SpindleSpeed -eq 0) { $type = 'SSD' }
            elseif ($type -eq 'Unspecified') { $type = 'Disk' }
            $total += [double]$d.Size
            $i.Disks += [pscustomobject]@{ Number = "$($d.DeviceId)"; Name = "$($d.FriendlyName)".Trim(); Type = $type; Size = Format-Bytes ([double]$d.Size); Bus = "$($d.BusType)" }
        }
    } catch {
        foreach ($d in @(Get-CimInstance Win32_DiskDrive -ErrorAction SilentlyContinue)) {
            $total += [double]$d.Size
            $i.Disks += [pscustomobject]@{ Number = "$($d.Index)"; Name = $d.Model; Type = 'Disk'; Size = Format-Bytes ([double]$d.Size); Bus = $d.InterfaceType }
        }
    }
    $i.StorageTotal = Format-Bytes $total
    $i.SystemDiskType = 'Unknown'
    try {
        $sysLetter = $env:SystemDrive.TrimEnd(':')
        $num = (Get-Partition -DriveLetter $sysLetter -ErrorAction Stop | Select-Object -First 1).DiskNumber
        $sd = $i.Disks | Where-Object { $_.Number -eq "$num" } | Select-Object -First 1
        if ($sd) { $i.SystemDiskType = $sd.Type; $i.SystemDiskName = $sd.Name }
    } catch {}
    $i.SystemIsSSD = ($i.SystemDiskType -match 'SSD')
    $i.SystemIsHDD = ($i.SystemDiskType -eq 'HDD')
    $i.Volumes = @(Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction SilentlyContinue | ForEach-Object {
        [pscustomobject]@{ Letter = $_.DeviceID; Label = $_.VolumeName; Size = [double]$_.Size; Free = [double]$_.FreeSpace }
    })

    # ---- Board / BIOS
    $bb = Get-CimInstance Win32_BaseBoard -ErrorAction SilentlyContinue
    $bios = Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue
    $i.Board = if ($bb) { ("$($bb.Manufacturer) $($bb.Product)").Trim() } else { '-' }
    $i.Bios  = if ($bios) { "$($bios.SMBIOSBIOSVersion)" } else { '-' }

    # ---- OS
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
    $cv = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
    $i.Build   = [int]((Get-RegValue $cv 'CurrentBuildNumber').Value)
    $i.UBR     = (Get-RegValue $cv 'UBR').Value
    $i.OsName  = if ($os) { $os.Caption -replace 'Microsoft ', '' } else { 'Windows' }
    if ($i.Build -ge 22000 -and $i.OsName -match 'Windows 10') { $i.OsName = $i.OsName -replace 'Windows 10', 'Windows 11' }
    $i.OsVer   = (Get-RegValue $cv 'DisplayVersion').Value
    if (-not $i.OsVer) { $i.OsVer = (Get-RegValue $cv 'ReleaseId').Value }
    $i.Uptime  = if ($os) { $ts = (Get-Date) - $os.LastBootUpTime; '{0}d {1}h {2}m' -f $ts.Days, $ts.Hours, $ts.Minutes } else { '-' }
    $i.Computer = $env:COMPUTERNAME

    # ---- State checks
    $i.PowerPlan = '-'
    try { $o = (& powercfg.exe /getactivescheme) | Out-String; if ($o -match '\((.+)\)') { $i.PowerPlan = $Matches[1] } } catch {}
    $i.HvciOn = $false
    try {
        $dg = Get-CimInstance -Namespace root\Microsoft\Windows\DeviceGuard -ClassName Win32_DeviceGuard -ErrorAction Stop
        $i.HvciOn = (@($dg.SecurityServicesRunning) -contains 2)
    } catch {}
    $i.StartupApps  = @(Get-StartupApps)
    $i.StartupCount = @($i.StartupApps | Where-Object { $_.Enabled }).Count
    $i.RebootPending = (Test-Path -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired') -or
                       (Test-Path -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending')
    $i.SessionOn = Test-Path -LiteralPath $SessionFile
    # Overlay / RGB / monitoring apps: each hooks into games or polls hardware; several together is a classic stutter source.
    $i.BusyApps = @(Get-Process -Name 'Discord', 'Overwolf', 'Medal', 'NVIDIA Overlay', 'RTSS', 'MSIAfterburner', 'NZXT CAM', 'iCUE', 'LightingService',
                    'ArmouryCrate*', 'SignalRgb', 'OpenRGB', 'SteelSeriesGG', 'lghub', 'Razer Synapse*' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty ProcessName -Unique)
    $cpuB = & $snap
    $budget = [math]::Max(1, $cpuClock.Elapsed.TotalMilliseconds * [Environment]::ProcessorCount)
    $i.CpuHogs = @($cpuB.Keys | Where-Object { $cpuA.ContainsKey($_) -and $_ -ne $PID } |
        ForEach-Object { [pscustomobject]@{ Name = $cpuB[$_][0]; Ms = $cpuB[$_][1] - $cpuA[$_][1] } } |
        Where-Object { $_.Name -notin 'Idle', 'System', 'WmiPrvSE', 'svchost', 'powershell', 'nvidia-smi' } | Group-Object Name |
        ForEach-Object { [pscustomobject]@{ Name = $_.Name; Pct = [math]::Round(100 * ($_.Group | Measure-Object Ms -Sum).Sum / $budget, 1) } } |
        Where-Object { $_.Pct -ge 3 } | Sort-Object Pct -Descending | Select-Object -First 3)
    $i.ProcCount = @(Get-Process -ErrorAction SilentlyContinue).Count
    return [pscustomobject]$i
}

function Get-HealthChecks {
    $s = $script:SysInfo
    $c = @()
    $c += if ($s.HvciOn) { @{ Ok = $false; Title = 'Memory Integrity (HVCI) is ON'; Text = 'Safer, but costs a few % FPS - up to 5-15% on Intel 6th gen / first-gen Ryzen and older. Your call: see Optimizations > Advanced.' } }
          else { @{ Ok = $true; Title = 'Memory Integrity is off'; Text = 'No virtualization-based security overhead.' } }
    $c += if ($s.SystemIsHDD) { @{ Ok = $false; Title = 'Windows is installed on a hard drive'; Text = 'An SSD is the single biggest upgrade for boot, load times and stutter on this PC. Even a budget 500 GB SATA SSD makes a huge difference.' } }
          elseif ($s.SystemIsSSD) { @{ Ok = $true; Title = "Windows is on an $($s.SystemDiskType)"; Text = 'Fast system drive - good for load times and stutter-free streaming.' } }
          else { @{ Ok = $true; Title = 'System drive type unknown'; Text = 'Could not determine whether Windows is on an SSD or HDD.' } }
    $c += if ($s.RamSticks -eq 1 -and -not $s.IsLaptop) { @{ Ok = $false; Title = 'RAM is running in single channel'; Text = 'One stick halves memory bandwidth. Two matched sticks (dual channel) give noticeably better minimum FPS.' } }
          elseif ($s.XmpOff) { @{ Ok = $false; Title = "RAM running at stock speed ($($s.RamSpeed))"; Text = "That is the $($s.RamType) fallback speed. If your kit is rated faster (check the sticker or part number $($s.RamPart)), enable XMP/EXPO in the BIOS memory settings - one of the biggest free FPS gains, especially on Ryzen. Some older Intel H/B-chipset boards lock this." } }
          else { @{ Ok = $true; Title = "$($s.RamTotal) $($s.RamType) - $($s.RamChannel)"; Text = "Running at $($s.RamSpeed)." } }
    $pp = "$($s.PowerPlan)"
    $c += if ($pp -match 'Ultimate|High|Zenith') { @{ Ok = $true; Title = "Power plan: $pp"; Text = 'CPU is allowed to run at full speed.' } }
          elseif ($s.IsLaptop) { @{ Ok = $true; Title = "Power plan: $pp"; Text = 'Right choice for a laptop - it still boosts fully when plugged in.' } }
          elseif ($s.CpuName -match 'Ryzen') { @{ Ok = $true; Title = "Power plan: $pp"; Text = 'Balanced is what AMD recommends for Ryzen - it lets the CPU pick its fastest cores.' } }
          else { @{ Ok = $false; Title = "Power plan: $pp"; Text = 'Balanced/power-saver plans down-clock the CPU between frames. Apply the Zenith Ultimate Performance plan.' } }
    if ($s.GpuDriverDate) {
        $age = ((Get-Date) - [datetime]$s.GpuDriverDate).Days
        $site = @{ NVIDIA = 'nvidia.com'; AMD = 'amd.com'; Intel = 'intel.com' }[$s.GpuVendor]
        if (-not $site) { $site = 'your graphics card maker''s website' }
        $c += if ($age -gt 365) { @{ Ok = $false; Title = "GPU driver is $([math]::Round($age/30)) months old"; Text = "Download the latest driver from $site." } }
              else { @{ Ok = $true; Title = 'GPU driver is recent'; Text = "Driver $($s.GpuDriver)" } }
    }
    $c += if ($s.StartupCount -gt 8) { @{ Ok = $false; Title = "$($s.StartupCount) apps launch at startup"; Text = 'Every startup app competes with your game for CPU time and RAM. Switch off the ones you do not need under Boost Up > Startup apps.' } }
          else { @{ Ok = $true; Title = "$($s.StartupCount) startup apps"; Text = 'Startup is lean.' } }
    if ($s.RebarOn -eq $false) {
        $c += @{ Ok = $false; Title = 'Resizable BAR is off'; Text = 'Your RTX card supports it: in the BIOS enable "Above 4G Decoding" and "Re-Size BAR Support" (CSM must be off). Worth up to ~10% in some games.' }
    } elseif ($s.RebarOn) { $c += @{ Ok = $true; Title = 'Resizable BAR is on'; Text = 'The CPU can access all of the graphics memory at once.' } }
    if ($s.RebootPending) {
        $c += @{ Ok = $false; Title = 'Windows is waiting to restart'; Text = 'An update needs a restart to finish. Restart before playing so it does not install in the middle of a session.' }
    }
    if (@($s.BusyApps).Count -ge 2) {
        $c += @{ Ok = $false; Title = "$(@($s.BusyApps).Count) overlay / RGB apps running"; Text = "$($s.BusyApps -join ', '). Each hooks into games or polls your hardware; several at once is a common cause of stutter. Close the ones you do not need, or turn their in-game overlays off." }
    }
    if (@($s.CpuHogs).Count) {
        $c += @{ Ok = $false; Title = 'Background apps using CPU right now'; Text = (($s.CpuHogs | ForEach-Object { "$($_.Name) $($_.Pct)%" }) -join ', ') + ' of total CPU while Zenith scanned. If this stays high while gaming, close or pause them (indexing, cloud sync, antivirus scans).' }
    }
    $sysVol = $s.Volumes | Where-Object { $_.Letter -eq $env:SystemDrive } | Select-Object -First 1
    if ($sysVol -and $sysVol.Size -gt 0) {
        $pct = [math]::Round(100 * $sysVol.Free / $sysVol.Size)
        $c += if ($pct -lt 15) { @{ Ok = $false; Title = "System drive only $pct% free"; Text = 'Windows and shader caches need free space. Run Boost Up > Clean temp files, or move games to another drive.' } }
              else { @{ Ok = $true; Title = "System drive $pct% free"; Text = "$(Format-Bytes $sysVol.Free) free on $($env:SystemDrive)" } }
    }
    # On desktops a monitor on the motherboard ports means games render on the integrated GPU (laptops route this by design).
    # ...including the case where only a lesser second screen is on the card and the main one is on the motherboard.
    $score = { param($d) [double]$d.ResX * $d.ResY * $d.Refresh }
    $onCard = @($s.Displays | Where-Object { $_.Gpu -eq $s.GpuName })
    $best = @($s.Displays | Where-Object { $_.Gpu -ne $s.GpuName } | Sort-Object { & $score $_ } -Descending) | Select-Object -First 1
    if (-not $s.IsLaptop -and $best -and (-not $onCard.Count -or (& $score $best) -gt ($onCard | ForEach-Object { & $score $_ } | Measure-Object -Maximum).Maximum)) {
        $c += @{ Ok = $false; Title = 'Monitor is plugged into the motherboard'
                 Text = "Your $($best.ResX) x $($best.ResY) @ $($best.Refresh) Hz monitor runs on $($best.Gpu), not the $($s.GpuName) - games on it are rendered by integrated graphics or copied across, costing FPS and latency. Move its cable to the graphics card's ports." }
    }
    foreach ($d in $s.Displays) {
        if ($d.MaxRefresh -gt $d.Refresh + 1) { $c += @{ Ok = $false; Title = "Display running at $($d.Refresh) Hz"; Text = "Windows reports this monitor supports up to $($d.MaxRefresh) Hz. Settings > System > Display > Advanced display > Choose a refresh rate." } }
    }
    if ($s.Refresh) {
        $c += @{ Ok = $true; Title = "Display: $($s.ResX) x $($s.ResY) @ $($s.Refresh) Hz"; Text = "Main display on the $($s.GpuName)." }
    }
    return $c
}

# ================================================================ BACKGROUND WORKER
# Everything that touches the system runs on one background runspace, one job at a time, so the
# window never freezes and manual toggles simply queue up. The worker runs this same engine code.
function Restart-Explorer {
    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
    Start-Sleep -Milliseconds 1800
    if (-not (Get-Process -Name explorer -ErrorAction SilentlyContinue)) { Start-Process "$env:WINDIR\explorer.exe" }
}

function New-RestorePoint {
    try {
        Enable-ComputerRestore -Drive "$env:SystemDrive\" -ErrorAction SilentlyContinue
        $k = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'
        New-ItemProperty -Path $k -Name 'SystemRestorePointCreationFrequency' -PropertyType DWord -Value 0 -Force | Out-Null
        Checkpoint-Computer -Description 'Zenith - before optimizations' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction Stop
        Remove-ItemProperty -Path $k -Name 'SystemRestorePointCreationFrequency' -ErrorAction SilentlyContinue
        Write-Log 'Restore point: OK'; return $true
    } catch { Write-Log "Restore point: ERR: $($_.Exception.Message)"; return $false }
}

# Empties each folder (the folders themselves stay); files in use are skipped. Returns bytes freed.
function Clear-Folders([string[]]$Paths) {
    $freed = [int64]0
    $stack = New-Object System.Collections.Stack
    $dirs  = New-Object System.Collections.Generic.List[IO.DirectoryInfo]
    foreach ($p in $Paths) { if ([IO.Directory]::Exists($p)) { $stack.Push([IO.DirectoryInfo]$p) } }
    while ($stack.Count) {
        try { $entries = $stack.Pop().GetFileSystemInfos() } catch { continue }
        foreach ($e in $entries) {
            # Never follow a junction or symlink out of the folder being cleaned.
            if ($e.Attributes.HasFlag([IO.FileAttributes]::ReparsePoint)) { continue }
            if ($e -is [IO.DirectoryInfo]) { $stack.Push($e); $dirs.Add($e); continue }
            $len = $e.Length
            try { $e.Delete(); $freed += $len } catch { try { $e.Attributes = 'Normal'; $e.Delete(); $freed += $len } catch {} }
        }
    }
    for ($i = $dirs.Count - 1; $i -ge 0; $i--) { try { $dirs[$i].Delete() } catch {} }   # children were listed after their parents
    $freed
}

# ---------------------------------------------------------------- games: priority + dedicated GPU
$IFEO    = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options'
$GPUPREF = 'HKCU:\Software\Microsoft\DirectX\UserGpuPreferences'

function Get-GameList {
    if (-not (Test-Path -LiteralPath $GamesFile)) { return @() }
    try {
        @((Get-Content -LiteralPath $GamesFile -Raw | ConvertFrom-Json) | ForEach-Object { $_ } | Where-Object { $_ } | ForEach-Object {
            if ($_ -is [string]) { [pscustomobject]@{ Name = $_ -replace '\.exe$'; Exe = $_; Path = $null; GpuSet = $false; GpuPrev = $null } } else { $_ }   # v1 stored bare exe names
        })
    } catch { @() }
}
function Save-GameList($list) { ConvertTo-Json -InputObject @($list) -Depth 4 | Set-Content -LiteralPath $GamesFile -Encoding UTF8 }

# High CPU priority (by exe name) and, when the full path is known, Windows' "High performance" GPU for that exe.
function Add-GameEntry($g) {
    $list = @(Get-GameList)
    if ($list | Where-Object { $_.Exe -eq $g.Exe }) { return $false }
    $e = [pscustomobject]@{ Name = $g.Name; Exe = $g.Exe; Path = $g.Path; GpuSet = $false; GpuPrev = $null }
    Set-RegValue "$IFEO\$($e.Exe)\PerfOptions" 'CpuPriorityClass' 'DWord' 3
    if ($e.Path) {
        $prev = Get-RegValue $GPUPREF $e.Path
        if ($prev.Exists) { $e.GpuPrev = "$($prev.Value)" }
        # Keep any other per-app DirectX settings already stored in the value; only GpuPreference changes.
        $kv = [ordered]@{}; foreach ($pair in ("$($e.GpuPrev)" -split ';')) { if ($pair -match '^(\w+)=(.*)$') { $kv[$Matches[1]] = $Matches[2] } }
        $kv['GpuPreference'] = '2'
        Set-RegValue $GPUPREF $e.Path 'String' ((@($kv.Keys | ForEach-Object { "$_=$($kv[$_])" }) -join ';') + ';')
        $e.GpuSet = $true
    }
    Save-GameList (@($list) + $e)
    Write-Log "Game added: $($e.Exe) $(if ($e.Path) { "($($e.Path))" })"
    $true
}
function Remove-GameEntry([string]$Exe) {
    $list = @(Get-GameList); $g = $list | Where-Object { $_.Exe -eq $Exe } | Select-Object -First 1
    $k = "$IFEO\$Exe"
    Remove-Item -LiteralPath "$k\PerfOptions" -Recurse -Force -ErrorAction SilentlyContinue
    try { $item = Get-Item -LiteralPath $k -ErrorAction Stop; if ($item.SubKeyCount -eq 0 -and $item.ValueCount -eq 0) { Remove-Item -LiteralPath $k -Force -ErrorAction SilentlyContinue } } catch {}
    if ($g -and $g.GpuSet -and $g.Path) { if ($null -eq $g.GpuPrev) { Remove-RegValue $GPUPREF $g.Path } else { Set-RegValue $GPUPREF $g.Path 'String' $g.GpuPrev } }
    Save-GameList @($list | Where-Object { $_.Exe -ne $Exe })
    Write-Log "Game removed: $Exe"
}

# The real game executable in an install folder (Unreal games run *-Shipping.exe, not the small launcher stub).
function Find-GameExe([string]$Dir) {
    if (-not $Dir -or -not [IO.Directory]::Exists($Dir)) { return $null }
    $skip = 'unins|setup|install|redist|crash|report|helper|launcher|bootstrap|updater|anticheat|battleye|beservice|cefprocess|webhelper|prereq|dxsetup|dotnet|benchmark|activation|cleanup|touchup|overlay|handler|vconsole|compiler|busybox|errorreporter|createdump'
    $exes = @(Get-ChildItem -LiteralPath $Dir -Filter *.exe -Recurse -Depth 4 -File -ErrorAction SilentlyContinue | Where-Object { $_.BaseName -notmatch $skip })
    $pick = $exes | Where-Object { $_.Name -like '*-Shipping.exe' } | Sort-Object Length -Descending | Select-Object -First 1
    # Unity games: a small exe next to its "<name>_Data" folder (the engine is in UnityPlayer.dll, so "largest exe" misses it).
    if (-not $pick) { $pick = $exes | Where-Object { [IO.Directory]::Exists((Join-Path $_.DirectoryName "$($_.BaseName)_Data")) } | Select-Object -First 1 }
    if (-not $pick) { $pick = $exes | Sort-Object Length -Descending | Select-Object -First 1 }
    if ($pick) { $pick.FullName }
}

# Installed games from Steam, Epic, Riot and EA / Ubisoft / Blizzard (their uninstall entries).
function Find-InstalledGames {
    $found = New-Object System.Collections.Generic.List[object]
    $add = {
        param($name, $dir, $rel)
        if (-not $name -or ($found | Where-Object { $_.Name -eq $name })) { return }
        $exe = if ($rel) { Join-Path $dir $rel } else { Find-GameExe $dir }
        if ($exe -and (Test-Path -LiteralPath $exe) -and -not ($found | Where-Object { $_.Path -eq $exe })) {
            $found.Add([pscustomobject]@{ Name = $name; Exe = [IO.Path]::GetFileName($exe); Path = $exe })
        }
    }
    # Riot first: its own metadata knows the real exe, so it wins over stale launcher entries with the same name.
    $riot = @{ valorant = @('VALORANT', 'ShooterGame\Binaries\Win64\VALORANT-Win64-Shipping.exe'); league_of_legends = @('League of Legends', 'Game\League of Legends.exe') }
    foreach ($y in @(Get-ChildItem (Join-Path $env:ProgramData 'Riot Games\Metadata') -Recurse -Filter '*.live.product_settings.yaml' -ErrorAction SilentlyContinue)) {
        $known = $riot[($y.Name -split '\.')[0]]
        $m = [regex]::Match((Get-Content -LiteralPath $y.FullName -Raw -Encoding UTF8), 'product_install_full_path:\s*"([^"]+)"')
        if ($known -and $m.Success) { & $add $known[0] ($m.Groups[1].Value -replace '/', '\') $known[1] }
    }
    $steam = (Get-RegValue 'HKCU:\Software\Valve\Steam' 'SteamPath').Value
    if ($steam) {
        $libs = @($steam -replace '/', '\')
        $vdf = Join-Path $libs[0] 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $vdf) { $libs += @([regex]::Matches((Get-Content -LiteralPath $vdf -Raw), '"path"\s+"([^"]+)"') | ForEach-Object { $_.Groups[1].Value -replace '\\\\', '\' }) }
        foreach ($lib in ($libs | Sort-Object -Unique)) {
            foreach ($acf in @(Get-ChildItem -LiteralPath (Join-Path $lib 'steamapps') -Filter 'appmanifest_*.acf' -ErrorAction SilentlyContinue)) {
                $t = Get-Content -LiteralPath $acf.FullName -Raw -Encoding UTF8
                $name = [regex]::Match($t, '"name"\s+"([^"]+)"').Groups[1].Value
                $dir  = [regex]::Match($t, '"installdir"\s+"([^"]+)"').Groups[1].Value
                if ($dir -and $name -notmatch 'Redistributable|Steamworks|SteamVR|Proton|Runtime|Wallpaper Engine|Soundpad|Dedicated Server|SDK') { & $add $name (Join-Path $lib "steamapps\common\$dir") }
            }
        }
    }
    $epic = @(Get-ChildItem (Join-Path $env:ProgramData 'Epic\EpicGamesLauncher\Data\Manifests') -Filter *.item -ErrorAction SilentlyContinue |
              ForEach-Object { try { Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 | ConvertFrom-Json } catch {} })
    foreach ($j in ($epic | Sort-Object { -not $_.LaunchExecutable })) { if ($j.DisplayName -notmatch 'Content$') { & $add $j.DisplayName $j.InstallLocation } }   # add-on entries share the game's folder
    Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue |
        Where-Object { $_.Publisher -match 'Blizzard|Electronic Arts|Ubisoft' -and $_.InstallLocation -and $_.DisplayName -notmatch 'Battle\.net|EA app|Connect|Anti-Cheat|Launcher' } |
        ForEach-Object { & $add $_.DisplayName ("$($_.InstallLocation)" -replace '/', '\') }
    $found
}

# ---------------------------------------------------------------- game session
# Closes background apps, pauses Windows Update and turns on Do Not Disturb; Stop-GameSession puts it all back.
# The state is saved to disk, so a session left on (crash, reboot) can still be ended later.
$SessionApps     = 'OneDrive', 'Teams', 'ms-teams', 'PhoneExperienceHost', 'Widgets', 'WidgetService', 'Copilot', 'GoogleDriveFS', 'Dropbox', 'SkypeApp'
$SessionReopen   = 'OneDrive', 'Teams', 'ms-teams', 'GoogleDriveFS', 'Dropbox'
$SessionServices = 'wuauserv', 'UsoSvc', 'DoSvc', 'BITS'

function Get-FocusManager {
    try {
        $null = [Windows.UI.Shell.FocusSessionManager, Windows.UI.Shell, ContentType = WindowsRuntime]
        if ([Windows.UI.Shell.FocusSessionManager]::IsSupported) { return [Windows.UI.Shell.FocusSessionManager]::GetDefault() }
    } catch {}
    $null
}
function Start-GameSession {
    if (Test-Path -LiteralPath $SessionFile) { return (Get-Content -LiteralPath $SessionFile -Raw | ConvertFrom-Json) }
    $st = [ordered]@{ Started = (Get-Date).ToString('s'); Closed = @(); Reopen = @(); Services = @(); Focus = $false }
    foreach ($p in @(if ($SessionApps) { Get-Process -Name $SessionApps -ErrorAction SilentlyContinue })) {
        if ($p.ProcessName -in $SessionReopen -and $p.Path -and $st.Reopen -notcontains $p.Path) { $st.Reopen += $p.Path }
        if ($st.Closed -notcontains $p.ProcessName) { $st.Closed += $p.ProcessName }
        try { $p.Kill() } catch {}
    }
    foreach ($n in $SessionServices) {
        $svc = Get-Service -Name $n -ErrorAction SilentlyContinue
        if ($svc -and $svc.Status -eq 'Running') { Stop-Service -Name $n -Force -ErrorAction SilentlyContinue; $st.Services += $n }
    }
    $fm = Get-FocusManager
    if ($fm) {
        try { if (-not $fm.IsFocusActive) { $null = $fm.TryStartFocusSession([DateTimeOffset]::Now.AddHours(6)); $st.Focus = $true } }
        catch { Write-Log "Do Not Disturb could not be turned on: $($_.Exception.Message)" }
    }
    [pscustomobject]$st | ConvertTo-Json | Set-Content -LiteralPath $SessionFile -Encoding UTF8
    Write-Log "Game session started: closed $($st.Closed -join ', '); paused $($st.Services -join ', '); DND $($st.Focus)"
    [pscustomobject]$st
}
function Stop-GameSession {
    if (-not (Test-Path -LiteralPath $SessionFile)) { return $null }
    $st = Get-Content -LiteralPath $SessionFile -Raw | ConvertFrom-Json
    foreach ($n in @($st.Services)) { Start-Service -Name $n -ErrorAction SilentlyContinue }
    if ($st.Focus) { $fm = Get-FocusManager; if ($fm) { try { $fm.DeactivateFocus() } catch {} } }
    # Reopened through Explorer so the apps run as the normal user, not elevated like Zenith.
    foreach ($exe in @($st.Reopen)) { if ($exe -and (Test-Path -LiteralPath $exe)) { Start-Process -FilePath "$env:WINDIR\explorer.exe" -ArgumentList "`"$exe`"" } }
    Remove-Item -LiteralPath $SessionFile -Force
    Write-Log 'Game session ended'
    $st
}

# ---------------------------------------------------------------- network test
# Router first (your own network / Wi-Fi), then two big public resolvers (the route through your ISP).
function Test-Network([int]$Count = 20) {
    $gw = (Get-NetRoute -DestinationPrefix '0.0.0.0/0' -ErrorAction SilentlyContinue | Sort-Object RouteMetric | Select-Object -First 1).NextHop
    $targets = @()
    if ($gw -and $gw -ne '0.0.0.0') { $targets += @{ Name = 'Your router'; Host = $gw } }
    $targets += @{ Name = 'Cloudflare'; Host = '1.1.1.1' }, @{ Name = 'Google'; Host = '8.8.8.8' }
    $ping = New-Object System.Net.NetworkInformation.Ping
    foreach ($t in $targets) {
        Set-JobStatus "Pinging $($t.Name)"
        $rtt = New-Object System.Collections.Generic.List[double]; $lost = 0
        for ($k = 0; $k -lt $Count; $k++) {
            try { $r = $ping.Send($t.Host, 1000); if ($r.Status -eq 'Success') { $rtt.Add($r.RoundtripTime) } else { $lost++ } } catch { $lost++ }
            Start-Sleep -Milliseconds 50
        }
        $jit = 0.0; for ($k = 1; $k -lt $rtt.Count; $k++) { $jit += [math]::Abs($rtt[$k] - $rtt[$k - 1]) }
        [pscustomobject]@{ Name = $t.Name; Host = $t.Host; Loss = [math]::Round(100 * $lost / $Count)
            Avg    = if ($rtt.Count) { [math]::Round(($rtt | Measure-Object -Average).Average, 1) } else { $null }
            Jitter = if ($rtt.Count -gt 1) { [math]::Round($jit / ($rtt.Count - 1), 1) } else { $null } }
    }
}

# ---------------------------------------------------------------- FPS test (Intel PresentMon 2.x)
function Get-BenchResults { if (Test-Path -LiteralPath $BenchFile) { try { @((Get-Content -LiteralPath $BenchFile -Raw | ConvertFrom-Json) | ForEach-Object { $_ }) } catch { @() } } else { @() } }

# Average FPS plus 1% / 0.1% lows (the FPS at the 99th / 99.9th percentile frame time) from a list of frame times in ms.
function Get-FpsStats([double[]]$FrameMs) {
    $ft = @($FrameMs | Where-Object { $_ -gt 0 } | Sort-Object)
    if ($ft.Count -lt 30) { throw "Only $($ft.Count) frames were captured - keep the game in focus while recording." }
    $at = { param($q) $ft[[math]::Min($ft.Count - 1, [int][math]::Floor($ft.Count * $q))] }
    [pscustomobject]@{ Frames = $ft.Count; Avg = [math]::Round(1000 / ($ft | Measure-Object -Average).Average, 1)
                       Low1 = [math]::Round(1000 / (& $at 0.99), 1); Low01 = [math]::Round(1000 / (& $at 0.999), 1) }
}

function Invoke-FpsTest([string]$PresentMon, [string]$Exe, [int]$Seconds, [string]$Label, [int]$Delay = 10) {
    if (-not (Test-Path -LiteralPath $PresentMon)) { throw 'PresentMon was not found.' }
    if (-not (Get-Process -Name ([IO.Path]::GetFileNameWithoutExtension($Exe)) -ErrorAction SilentlyContinue)) { throw "$Exe is not running - start the game first." }
    $dir = Join-Path $DataDir 'bench'; New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $csv = Join-Path $dir 'last-run.csv'; Remove-Item -LiteralPath $csv -ErrorAction SilentlyContinue
    for ($k = $Delay; $k -gt 0; $k--) { Set-JobStatus "Switch to your game - recording starts in $k s"; Start-Sleep -Seconds 1 }
    [System.Media.SystemSounds]::Asterisk.Play()
    Set-JobStatus "Recording $Exe for $Seconds s"
    $p = Start-Process -FilePath $PresentMon -WindowStyle Hidden -PassThru -ArgumentList `
         "--process_name `"$Exe`" --output_file `"$csv`" --timed $Seconds --terminate_after_timed --stop_existing_session"
    if (-not $p.WaitForExit(($Seconds + 30) * 1000)) { try { $p.Kill() } catch {}; throw 'PresentMon did not finish in time.' }
    [System.Media.SystemSounds]::Asterisk.Play()
    if (-not (Test-Path -LiteralPath $csv)) { throw 'PresentMon recorded nothing. Use PresentMon 2.x and keep the game running in focus.' }
    $rows = @(Import-Csv -LiteralPath $csv)
    $col = @('MsBetweenPresents', 'FrameTime') | Where-Object { $rows.Count -and $rows[0].PSObject.Properties.Name -contains $_ } | Select-Object -First 1
    if (-not $col) { throw 'PresentMon output had no frame-time column.' }
    $st = Get-FpsStats @($rows | ForEach-Object { [double]$_.$col })
    $res = [pscustomobject]@{ Time = (Get-Date).ToString('yyyy-MM-dd HH:mm'); Game = $Exe; Label = $Label; Seconds = $Seconds
                              Frames = $st.Frames; Avg = $st.Avg; Low1 = $st.Low1; Low01 = $st.Low01 }
    ConvertTo-Json -InputObject @(@(Get-BenchResults) + $res) -Depth 3 | Set-Content -LiteralPath $BenchFile -Encoding UTF8
    Write-Log "FPS test $Exe ($Label): avg $($st.Avg), 1% low $($st.Low1), 0.1% low $($st.Low01), $($st.Frames) frames"
    $res
}

# ---------------------------------------------------------------- profiles
# A profile is just the list of active tweak ids. Only ids that exist in this catalog are accepted.
function Read-ZenithProfile([string]$Path) {
    $j = Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
    if ($j.App -ne 'Zenith' -or -not $j.Tweaks) { throw 'This is not a Zenith profile.' }
    @($j.Tweaks | Where-Object { $_ -is [string] -and $script:TweakMap.ContainsKey($_) })
}

# Progress text for the UI ($Sync only exists inside the worker runspace).
function Set-JobStatus([string]$Text) { if ($Sync) { $Sync.Status = $Text } }

# Runs one queued job and returns what the UI needs to refresh itself.
function Invoke-WorkerJob([hashtable]$Job) {
    $r = @{ Job = $Job; States = @{}; Data = $null; Error = $null }
    try {
        $t = if ($Job.Id) { Get-Tweak $Job.Id } else { $null }
        switch ($Job.Kind) {
            'scan'    {
                Set-JobStatus 'Reading your hardware'; $script:SysInfo = Get-SystemInfo
                Set-JobStatus 'Checking installed apps'; Update-AppxCache; $r.Data = $script:SysInfo
                Set-JobStatus 'Checking which optimizations are active'; $r.States = Test-AllTweaks
            }
            'rescan'  { $script:SysInfo = Get-SystemInfo; $r.Data = $script:SysInfo }
            'states'  { $r.States = Test-AllTweaks }
            'apply'   { Invoke-ApplyTweak $t }
            'revert'  { Invoke-RevertTweak $t }
            'restore' { $r.Data = New-RestorePoint }
            'clean'   { $r.Data = Clear-Folders $Job.Paths }
            'explorer' { Restart-Explorer }
            'startup' { Set-StartupApp $Job.Approved $Job.ValueName $Job.Enable; $r.Data = @(Get-StartupApps) }
            'games'   {
                $cands = if ($Job.Detect) { Set-JobStatus 'Looking for installed games'; @(Find-InstalledGames) } else { @($Job.Add | Where-Object { $_ }) }
                $added = @(foreach ($g in $cands) { if (Add-GameEntry $g) { $g.Name } })
                foreach ($x in @($Job.Remove | Where-Object { $_ })) { Remove-GameEntry $x }
                $r.Data = @{ Added = $added; Found = $cands.Count; List = @(Get-GameList) }
            }
            'session' { $r.Data = if ($Job.On) { Start-GameSession } else { Stop-GameSession } }
            'net'     { $r.Data = @(Test-Network) }
            'fps'     { $r.Data = Invoke-FpsTest $Job.PresentMon $Job.Exe $Job.Seconds $Job.Label }
        }
        if ($t) {
            $r.States[$t.Id] = Test-Tweak $t
            # The power plan decides which plan the other power tweaks are read from.
            if ($t.Id -eq 'pwr_plan') { foreach ($x in $script:Tweaks | Where-Object { $_.Pow }) { $r.States[$x.Id] = Test-Tweak $x } }
        }
    } catch { $r.Error = $_.Exception.Message; Write-Log "Job $($Job.Kind) $($Job.Id) failed: $($r.Error)" }
    $r.BackupIds = @($script:Backup.Keys)
    $r
}

# Boots the worker runspace with this file's engine code and returns the shared job/result queues.
function Start-Worker([string]$Source) {
    # Section markers are assembled here so their literal text appears only once in this file.
    $a = $Source.IndexOf('# ' + ('-' * 64) + ' paths / settings')
    $b = $Source.IndexOf('# ' + ('=' * 64) + ' UI (XAML)')
    if ($a -lt 0 -or $b -lt $a) { throw 'Zenith.ps1 section markers not found - the worker cannot start.' }
    $sync = [hashtable]::Synchronized(@{
        Jobs    = New-Object 'System.Collections.Concurrent.BlockingCollection[object]'
        Results = New-Object 'System.Collections.Concurrent.ConcurrentQueue[object]'
        Current = $null })
    $rs = [runspacefactory]::CreateRunspace(); $rs.Open()
    $rs.SessionStateProxy.SetVariable('Sync', $sync)
    $ps = [powershell]::Create(); $ps.Runspace = $rs
    [void]$ps.AddScript($Source.Substring($a, $b - $a) + @'

foreach ($job in $Sync.Jobs.GetConsumingEnumerable()) {
    $Sync.Current = $job; $Sync.Status = ''
    $Sync.Results.Enqueue((Invoke-WorkerJob $job))
    $Sync.Current = $null
}
'@)
    $sync.PS = $ps; $sync.Handle = $ps.BeginInvoke()
    $sync
}

# ================================================================ UI (XAML)
[xml]$MainXaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Zenith" Width="1320" Height="840" MinWidth="1080" MinHeight="680"
        WindowStartupLocation="CenterScreen" Background="#000000" Foreground="#ECE9F3"
        FontFamily="Segoe UI Variable Display, Segoe UI" FontSize="13"
        TextOptions.TextFormattingMode="Display" UseLayoutRounding="True" SnapsToDevicePixels="True">
  <WindowChrome.WindowChrome>
    <WindowChrome CaptionHeight="44" ResizeBorderThickness="6" GlassFrameThickness="0" CornerRadius="0" UseAeroCaptionButtons="False"/>
  </WindowChrome.WindowChrome>

  <Window.Resources>
    <FontFamily x:Key="Icons">Segoe Fluent Icons, Segoe MDL2 Assets</FontFamily>

    <!-- Zenith palette: black surfaces, purple accent, edge-lit borders -->
    <LinearGradientBrush x:Key="AccentGrad" StartPoint="0,0" EndPoint="1,0">
      <GradientStop Color="#7C3AED" Offset="0"/><GradientStop Color="#C084FC" Offset="1"/>
    </LinearGradientBrush>
    <LinearGradientBrush x:Key="EdgeGrad" StartPoint="0,0" EndPoint="1,1">
      <GradientStop Color="#3A2560" Offset="0"/><GradientStop Color="#16102A" Offset="0.4"/><GradientStop Color="#120D1C" Offset="1"/>
    </LinearGradientBrush>

    <!-- Zenith logo (64x64): a split Z - a "7" and its 180-degree twin - with a blade slicing between them.
         Same artwork as the window icon. -->
    <PathGeometry x:Key="ZA" Figures="M16,18 L41,18 L17,48 L31,23.5 L11.6,23.5 Z"/>
    <PathGeometry x:Key="ZB" Figures="M48,48 L23,48 L47,18 L33,42.5 L52.4,42.5 Z"/>
    <PathGeometry x:Key="ZBlade" Figures="M50.4,10 L33.2,33 L13.6,56 L30.8,33 Z"/>
    <LinearGradientBrush x:Key="ZWhite" StartPoint="0,0" EndPoint="1,1">
      <GradientStop Color="#FFFFFF" Offset="0"/><GradientStop Color="#E9DDFB" Offset="1"/>
    </LinearGradientBrush>
    <LinearGradientBrush x:Key="ZBladeFill" StartPoint="1,0" EndPoint="0,1">
      <GradientStop Color="#F0ABFC" Offset="0"/><GradientStop Color="#A855F7" Offset="0.5"/><GradientStop Color="#7C3AED" Offset="1"/>
    </LinearGradientBrush>

    <!-- text -->
    <Style x:Key="H1" TargetType="TextBlock">
      <Setter Property="FontSize" Value="26"/><Setter Property="FontWeight" Value="SemiBold"/><Setter Property="Foreground" Value="#F5F3FA"/>
    </Style>
    <Style x:Key="H2" TargetType="TextBlock">
      <Setter Property="FontSize" Value="16.5"/><Setter Property="FontWeight" Value="SemiBold"/><Setter Property="Foreground" Value="#F5F3FA"/>
    </Style>
    <Style x:Key="Sub" TargetType="TextBlock">
      <Setter Property="FontSize" Value="13"/><Setter Property="Foreground" Value="#8B84A3"/><Setter Property="TextWrapping" Value="Wrap"/>
    </Style>
    <Style x:Key="Label" TargetType="TextBlock">
      <Setter Property="FontSize" Value="11"/><Setter Property="FontWeight" Value="Bold"/><Setter Property="Foreground" Value="#A855F7"/>
    </Style>

    <Style x:Key="Card" TargetType="Border">
      <Setter Property="Background" Value="#0A0810"/><Setter Property="BorderBrush" Value="{StaticResource EdgeGrad}"/>
      <Setter Property="BorderThickness" Value="1"/><Setter Property="CornerRadius" Value="12"/><Setter Property="Padding" Value="22"/>
    </Style>
    <Style x:Key="Tick" TargetType="Border">
      <Setter Property="Height" Value="2"/><Setter Property="Width" Value="26"/><Setter Property="HorizontalAlignment" Value="Left"/>
      <Setter Property="CornerRadius" Value="1"/><Setter Property="Margin" Value="0,0,0,10"/><Setter Property="Background" Value="{StaticResource AccentGrad}"/>
      <Setter Property="Effect"><Setter.Value><DropShadowEffect Color="#A855F7" BlurRadius="8" ShadowDepth="0" Opacity="0.9"/></Setter.Value></Setter>
    </Style>

    <!-- buttons -->
    <Style x:Key="AccentBtn" TargetType="Button">
      <Setter Property="Foreground" Value="#FFFFFF"/>
      <Setter Property="Background">
        <Setter.Value>
          <LinearGradientBrush StartPoint="0,0" EndPoint="1,1"><GradientStop Color="#9333EA" Offset="0"/><GradientStop Color="#6D28D9" Offset="1"/></LinearGradientBrush>
        </Setter.Value>
      </Setter>
      <Setter Property="BorderBrush" Value="Transparent"/><Setter Property="BorderThickness" Value="0"/>
      <Setter Property="FontWeight" Value="SemiBold"/><Setter Property="FontSize" Value="13"/>
      <Setter Property="Padding" Value="18,9"/><Setter Property="Cursor" Value="Hand"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="B" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}"
                    BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="8" Padding="{TemplateBinding Padding}">
              <Border.Effect><DropShadowEffect x:Name="Glow" Color="#A855F7" BlurRadius="18" ShadowDepth="0" Opacity="0"/></Border.Effect>
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Trigger.EnterActions><BeginStoryboard><Storyboard>
                  <DoubleAnimation Storyboard.TargetName="Glow" Storyboard.TargetProperty="Opacity" To="0.65" Duration="0:0:0.14"/>
                </Storyboard></BeginStoryboard></Trigger.EnterActions>
                <Trigger.ExitActions><BeginStoryboard><Storyboard>
                  <DoubleAnimation Storyboard.TargetName="Glow" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.22"/>
                </Storyboard></BeginStoryboard></Trigger.ExitActions>
              </Trigger>
              <Trigger Property="IsPressed" Value="True"><Setter TargetName="B" Property="Opacity" Value="0.78"/></Trigger>
              <Trigger Property="IsEnabled" Value="False"><Setter TargetName="B" Property="Opacity" Value="0.4"/></Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>
    <Style x:Key="GhostBtn" TargetType="Button" BasedOn="{StaticResource AccentBtn}">
      <Setter Property="Background" Value="#120D1C"/><Setter Property="Foreground" Value="#E2DDEE"/>
      <Setter Property="BorderBrush" Value="#2B2142"/><Setter Property="BorderThickness" Value="1"/>
      <Setter Property="FontWeight" Value="Normal"/>
    </Style>
    <Style x:Key="DangerBtn" TargetType="Button" BasedOn="{StaticResource AccentBtn}">
      <Setter Property="Background" Value="#2A1215"/><Setter Property="Foreground" Value="#FF8A8A"/>
      <Setter Property="BorderBrush" Value="#5A2228"/><Setter Property="BorderThickness" Value="1"/>
      <Setter Property="FontWeight" Value="Normal"/>
    </Style>

    <Style x:Key="TitleBtn" TargetType="Button">
      <Setter Property="Width" Value="46"/><Setter Property="Height" Value="36"/>
      <Setter Property="Foreground" Value="#A49DB8"/><Setter Property="Background" Value="Transparent"/>
      <Setter Property="FontFamily" Value="Segoe MDL2 Assets"/><Setter Property="FontSize" Value="10"/>
      <Setter Property="WindowChrome.IsHitTestVisibleInChrome" Value="True"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border Background="{TemplateBinding Background}">
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
      <Style.Triggers>
        <Trigger Property="IsMouseOver" Value="True"><Setter Property="Background" Value="#1A1226"/><Setter Property="Foreground" Value="White"/></Trigger>
      </Style.Triggers>
    </Style>
    <Style x:Key="CloseBtn" TargetType="Button" BasedOn="{StaticResource TitleBtn}">
      <Style.Triggers>
        <Trigger Property="IsMouseOver" Value="True"><Setter Property="Background" Value="#E81123"/><Setter Property="Foreground" Value="White"/></Trigger>
      </Style.Triggers>
    </Style>

    <Style x:Key="Tile" TargetType="Button">
      <Setter Property="Foreground" Value="#D2CCE0"/><Setter Property="Cursor" Value="Hand"/><Setter Property="Margin" Value="0,0,10,10"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="B" Background="#0D0A14" BorderBrush="#221A33" BorderThickness="1" CornerRadius="10" Padding="12,16">
              <Border.Effect><DropShadowEffect x:Name="Glow" Color="#A855F7" BlurRadius="16" ShadowDepth="0" Opacity="0"/></Border.Effect>
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="B" Property="BorderBrush" Value="#A855F7"/><Setter TargetName="B" Property="Background" Value="#161022"/>
                <Trigger.EnterActions><BeginStoryboard><Storyboard>
                  <DoubleAnimation Storyboard.TargetName="Glow" Storyboard.TargetProperty="Opacity" To="0.5" Duration="0:0:0.14"/>
                </Storyboard></BeginStoryboard></Trigger.EnterActions>
                <Trigger.ExitActions><BeginStoryboard><Storyboard>
                  <DoubleAnimation Storyboard.TargetName="Glow" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.22"/>
                </Storyboard></BeginStoryboard></Trigger.ExitActions>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <!-- sidebar navigation -->
    <Style x:Key="NavBtn" TargetType="RadioButton">
      <Setter Property="Foreground" Value="#7A7393"/><Setter Property="Height" Value="66"/><Setter Property="Cursor" Value="Hand"/>
      <Setter Property="GroupName" Value="Nav"/><Setter Property="FontSize" Value="10.5"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="RadioButton">
            <Grid Background="Transparent">
              <Border x:Name="Bg" Margin="9,3" CornerRadius="10" Background="Transparent"/>
              <Border x:Name="Ind" Width="3" HorizontalAlignment="Left" Margin="0,18" CornerRadius="0,3,3,0" Background="#C084FC" Visibility="Hidden">
                <Border.Effect><DropShadowEffect Color="#A855F7" BlurRadius="12" ShadowDepth="0" Opacity="0.9"/></Border.Effect>
              </Border>
              <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
                <TextBlock Text="{Binding Tag, RelativeSource={RelativeSource TemplatedParent}}" FontFamily="{StaticResource Icons}"
                           FontSize="20" HorizontalAlignment="Center"/>
                <ContentPresenter HorizontalAlignment="Center" Margin="0,6,0,0"/>
              </StackPanel>
            </Grid>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="Bg" Property="Background" Value="#100B19"/><Setter Property="Foreground" Value="#D2CCE0"/>
              </Trigger>
              <Trigger Property="IsChecked" Value="True">
                <Setter TargetName="Bg" Property="Background" Value="#170F26"/>
                <Setter TargetName="Ind" Property="Visibility" Value="Visible"/>
                <Setter Property="Foreground" Value="#A855F7"/>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <!-- category chips -->
    <Style x:Key="Chip" TargetType="RadioButton">
      <Setter Property="Foreground" Value="#B9B2CF"/><Setter Property="Margin" Value="0,0,8,8"/>
      <Setter Property="Cursor" Value="Hand"/><Setter Property="FontSize" Value="13"/><Setter Property="GroupName" Value="Cat"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="RadioButton">
            <Border x:Name="B" CornerRadius="8" Background="#0D0A14" BorderBrush="#221A33" BorderThickness="1" Padding="14,7">
              <ContentPresenter VerticalAlignment="Center"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True"><Setter TargetName="B" Property="BorderBrush" Value="#4A2E78"/></Trigger>
              <Trigger Property="IsChecked" Value="True">
                <Setter TargetName="B" Property="Background" Value="#1A0F2E"/>
                <Setter TargetName="B" Property="BorderBrush" Value="#A855F7"/>
                <Setter Property="Foreground" Value="#C084FC"/>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <!-- switch -->
    <Style x:Key="Switch" TargetType="ToggleButton">
      <Setter Property="Width" Value="44"/><Setter Property="Height" Value="24"/><Setter Property="Cursor" Value="Hand"/>
      <Setter Property="Focusable" Value="False"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="ToggleButton">
            <Grid>
              <Border x:Name="Track" CornerRadius="12" Background="#1C1529" BorderBrush="#352650" BorderThickness="1"/>
              <Ellipse x:Name="Knob" Width="16" Height="16" Fill="#B9B2CF" HorizontalAlignment="Left" Margin="4,0,0,0">
                <Ellipse.RenderTransform><TranslateTransform x:Name="KnobT" X="0"/></Ellipse.RenderTransform>
              </Ellipse>
            </Grid>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True"><Setter TargetName="Track" Property="BorderBrush" Value="#6B4C9A"/></Trigger>
              <Trigger Property="IsChecked" Value="True">
                <Trigger.EnterActions>
                  <BeginStoryboard><Storyboard><DoubleAnimation Storyboard.TargetName="KnobT" Storyboard.TargetProperty="X" To="20" Duration="0:0:0.14"/></Storyboard></BeginStoryboard>
                </Trigger.EnterActions>
                <Trigger.ExitActions>
                  <BeginStoryboard><Storyboard><DoubleAnimation Storyboard.TargetName="KnobT" Storyboard.TargetProperty="X" To="0" Duration="0:0:0.14"/></Storyboard></BeginStoryboard>
                </Trigger.ExitActions>
                <Setter TargetName="Track" Property="Background" Value="#9333EA"/>
                <Setter TargetName="Track" Property="BorderBrush" Value="#C084FC"/>
                <Setter TargetName="Knob" Property="Fill" Value="White"/>
              </Trigger>
              <Trigger Property="IsEnabled" Value="False"><Setter Property="Opacity" Value="0.35"/></Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <!-- inputs -->
    <Style x:Key="Combo" TargetType="ComboBox">
      <Setter Property="Foreground" Value="#EAE7F2"/><Setter Property="FontSize" Value="13"/><Setter Property="MinHeight" Value="36"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="ComboBox">
            <Grid>
              <ToggleButton Focusable="False" ClickMode="Press" IsChecked="{Binding IsDropDownOpen, Mode=TwoWay, RelativeSource={RelativeSource TemplatedParent}}">
                <ToggleButton.Template>
                  <ControlTemplate TargetType="ToggleButton">
                    <Border x:Name="B" Background="#08060D" BorderBrush="#221A33" BorderThickness="1" CornerRadius="8">
                      <TextBlock Text="&#xE70D;" FontFamily="Segoe Fluent Icons, Segoe MDL2 Assets" FontSize="10" Foreground="#8B84A3" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,0,12,0"/>
                    </Border>
                    <ControlTemplate.Triggers>
                      <Trigger Property="IsMouseOver" Value="True"><Setter TargetName="B" Property="BorderBrush" Value="#4A2E78"/></Trigger>
                    </ControlTemplate.Triggers>
                  </ControlTemplate>
                </ToggleButton.Template>
              </ToggleButton>
              <ContentPresenter IsHitTestVisible="False" Margin="12,0,30,0" VerticalAlignment="Center"
                                Content="{TemplateBinding SelectionBoxItem}" ContentTemplate="{TemplateBinding SelectionBoxItemTemplate}"/>
              <Popup IsOpen="{TemplateBinding IsDropDownOpen}" Placement="Bottom" AllowsTransparency="True" Focusable="False" PopupAnimation="Fade">
                <Border Background="#0F0B16" BorderBrush="#4A2E78" BorderThickness="1" CornerRadius="8" Margin="0,4,0,0" MaxHeight="320"
                        MinWidth="{Binding ActualWidth, RelativeSource={RelativeSource TemplatedParent}}">
                  <ScrollViewer><ItemsPresenter/></ScrollViewer>
                </Border>
              </Popup>
            </Grid>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
      <Setter Property="ItemContainerStyle">
        <Setter.Value>
          <Style TargetType="ComboBoxItem">
            <Setter Property="Foreground" Value="#EAE7F2"/><Setter Property="Padding" Value="12,7"/>
            <Setter Property="Template">
              <Setter.Value>
                <ControlTemplate TargetType="ComboBoxItem">
                  <Border x:Name="B" Background="Transparent" Padding="{TemplateBinding Padding}"><ContentPresenter/></Border>
                  <ControlTemplate.Triggers>
                    <Trigger Property="IsHighlighted" Value="True"><Setter TargetName="B" Property="Background" Value="#1A0F2E"/></Trigger>
                    <Trigger Property="IsSelected" Value="True"><Setter Property="Foreground" Value="#C084FC"/></Trigger>
                  </ControlTemplate.Triggers>
                </ControlTemplate>
              </Setter.Value>
            </Setter>
          </Style>
        </Setter.Value>
      </Setter>
    </Style>

    <Style x:Key="Input" TargetType="TextBox">
      <Setter Property="Foreground" Value="#EAE7F2"/><Setter Property="CaretBrush" Value="#A855F7"/>
      <Setter Property="SelectionBrush" Value="#A855F7"/><Setter Property="FontSize" Value="13"/><Setter Property="Padding" Value="10,8"/>
      <Setter Property="VerticalContentAlignment" Value="Center"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="TextBox">
            <Border x:Name="B" Background="#08060D" BorderBrush="#221A33" BorderThickness="1" CornerRadius="8">
              <ScrollViewer x:Name="PART_ContentHost" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsKeyboardFocused" Value="True"><Setter TargetName="B" Property="BorderBrush" Value="#A855F7"/></Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style x:Key="Bar" TargetType="ProgressBar">
      <Setter Property="Height" Value="6"/><Setter Property="Foreground" Value="{StaticResource AccentGrad}"/><Setter Property="Maximum" Value="100"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="ProgressBar">
            <Grid>
              <Border x:Name="PART_Track" CornerRadius="3" Background="#1A1328"/>
              <Border x:Name="PART_Indicator" CornerRadius="3" Background="{TemplateBinding Foreground}" HorizontalAlignment="Left"/>
            </Grid>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style TargetType="ToolTip">
      <Setter Property="Background" Value="#120D1C"/><Setter Property="Foreground" Value="#E2DDEE"/>
      <Setter Property="BorderBrush" Value="#4A2E78"/><Setter Property="Padding" Value="10,8"/><Setter Property="FontSize" Value="12"/>
    </Style>

    <Style TargetType="ScrollBar">
      <Setter Property="Width" Value="8"/><Setter Property="MinWidth" Value="8"/><Setter Property="Background" Value="Transparent"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="ScrollBar">
            <Track x:Name="PART_Track" IsDirectionReversed="True" Orientation="Vertical">
              <Track.Thumb>
                <Thumb>
                  <Thumb.Template>
                    <ControlTemplate TargetType="Thumb"><Border CornerRadius="4" Background="#2B2142" Margin="1,2"/></ControlTemplate>
                  </Thumb.Template>
                </Thumb>
              </Track.Thumb>
            </Track>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
      <Style.Triggers>
        <Trigger Property="Orientation" Value="Horizontal">
          <Setter Property="Width" Value="Auto"/><Setter Property="MinWidth" Value="0"/><Setter Property="Height" Value="8"/>
          <Setter Property="Template">
            <Setter.Value>
              <ControlTemplate TargetType="ScrollBar">
                <Track x:Name="PART_Track" Orientation="Horizontal">
                  <Track.Thumb>
                    <Thumb>
                      <Thumb.Template>
                        <ControlTemplate TargetType="Thumb"><Border CornerRadius="4" Background="#2B2142" Margin="2,1"/></ControlTemplate>
                      </Thumb.Template>
                    </Thumb>
                  </Track.Thumb>
                </Track>
              </ControlTemplate>
            </Setter.Value>
          </Setter>
        </Trigger>
      </Style.Triggers>
    </Style>
  </Window.Resources>

  <Grid x:Name="Root">
    <Grid.ColumnDefinitions>
      <ColumnDefinition Width="84"/>
      <ColumnDefinition Width="*"/>
    </Grid.ColumnDefinitions>

    <!-- ===================== SIDEBAR ===================== -->
    <Border Grid.Column="0" BorderThickness="0,0,1,0">
      <Border.Background>
        <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
          <GradientStop Color="#050308" Offset="0"/><GradientStop Color="#050308" Offset="0.6"/><GradientStop Color="#120726" Offset="1"/>
        </LinearGradientBrush>
      </Border.Background>
      <Border.BorderBrush>
        <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
          <GradientStop Color="#3A2560" Offset="0"/><GradientStop Color="#120D1C" Offset="0.5"/><GradientStop Color="#3A2560" Offset="1"/>
        </LinearGradientBrush>
      </Border.BorderBrush>
      <Grid>
        <Grid.RowDefinitions>
          <RowDefinition Height="76"/>
          <RowDefinition Height="*"/>
          <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Viewbox Width="42" Height="42" VerticalAlignment="Center" HorizontalAlignment="Center">
          <Grid Width="64" Height="64">
            <Border CornerRadius="15" Background="#050308" BorderThickness="1.5">
              <Border.BorderBrush>
                <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                  <GradientStop Color="#7C3AED" Offset="0"/><GradientStop Color="#1A1030" Offset="0.6"/><GradientStop Color="#3B1D6E" Offset="1"/>
                </LinearGradientBrush>
              </Border.BorderBrush>
            </Border>
            <Path Data="{StaticResource ZA}" Fill="{StaticResource ZWhite}"/>
            <Path Data="{StaticResource ZB}" Fill="{StaticResource ZWhite}"/>
            <Path Data="{StaticResource ZBlade}" Fill="{StaticResource ZBladeFill}">
              <Path.Effect><DropShadowEffect Color="#A855F7" BlurRadius="6" ShadowDepth="0" Opacity="1"/></Path.Effect>
              <Path.Triggers>
                <EventTrigger RoutedEvent="FrameworkElement.Loaded">
                  <BeginStoryboard>
                    <Storyboard RepeatBehavior="Forever" AutoReverse="True">
                      <DoubleAnimation Storyboard.TargetProperty="Opacity" From="0.55" To="1" Duration="0:0:1.4"/>
                    </Storyboard>
                  </BeginStoryboard>
                </EventTrigger>
              </Path.Triggers>
            </Path>
          </Grid>
        </Viewbox>
        <StackPanel Grid.Row="1" Margin="0,6,0,0">
          <RadioButton x:Name="NavDashboard" Style="{StaticResource NavBtn}" Tag="&#xE80F;" Content="Home" IsChecked="True"/>
          <RadioButton x:Name="NavScanner"   Style="{StaticResource NavBtn}" Tag="&#xE9D9;" Content="Scanner"/>
          <RadioButton x:Name="NavTweaks"    Style="{StaticResource NavBtn}" Tag="&#xEC4A;" Content="Optimize"/>
          <RadioButton x:Name="NavBoost"     Style="{StaticResource NavBtn}" Tag="&#xE945;" Content="Boost Up"/>
          <RadioButton x:Name="NavTest"      Style="{StaticResource NavBtn}" Tag="&#xE916;" Content="Test"/>
          <Border Height="1" Background="#1C1530" Margin="22,8"/>
          <RadioButton x:Name="NavBackup"    Style="{StaticResource NavBtn}" Tag="&#xE777;" Content="Backups"/>
          <RadioButton x:Name="NavSettings"  Style="{StaticResource NavBtn}" Tag="&#xE713;" Content="Settings"/>
        </StackPanel>
        <TextBlock x:Name="VersionText" Grid.Row="2" Text="v1.0" Foreground="#463E5E" FontSize="10.5" HorizontalAlignment="Center" Margin="0,0,0,16"/>
      </Grid>
    </Border>

    <!-- ===================== MAIN ===================== -->
    <Grid Grid.Column="1">
      <Grid.RowDefinitions>
        <RowDefinition Height="44"/>
        <RowDefinition Height="*"/>
      </Grid.RowDefinitions>

      <!-- title bar -->
      <Grid Grid.Row="0">
        <StackPanel Orientation="Horizontal" VerticalAlignment="Center" Margin="28,0,0,0">
          <TextBlock Text="Z&#x2009;E&#x2009;N&#x2009;I&#x2009;T&#x2009;H" FontWeight="Bold" FontSize="13">
            <TextBlock.Foreground>
              <LinearGradientBrush StartPoint="0,0" EndPoint="1,0"><GradientStop Color="#F5F3FA" Offset="0"/><GradientStop Color="#C084FC" Offset="1"/></LinearGradientBrush>
            </TextBlock.Foreground>
          </TextBlock>
          <Ellipse Width="4" Height="4" Fill="#A855F7" VerticalAlignment="Center" Margin="12,1,0,0"/>
          <TextBlock x:Name="TitleProfile" Text="" FontSize="12" Foreground="#665F80" Margin="10,1,0,0"/>
        </StackPanel>
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
          <!-- background job queue -->
          <Border x:Name="QueueBar" Visibility="Collapsed" Background="#120D1C" BorderBrush="#4A2E78" BorderThickness="1" CornerRadius="8" Margin="0,6,12,6" Padding="10,0,12,0">
            <Grid>
              <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                <Grid Width="14" Height="14" Margin="0,0,10,0">
                  <Ellipse Stroke="#2B2142" StrokeThickness="2"/>
                  <Path Stroke="#C084FC" StrokeThickness="2" StrokeStartLineCap="Round" StrokeEndLineCap="Round" Data="M7,1 A6,6 0 0 1 13,7">
                    <Path.RenderTransform><RotateTransform CenterX="7" CenterY="7"/></Path.RenderTransform>
                    <Path.Triggers>
                      <EventTrigger RoutedEvent="FrameworkElement.Loaded">
                        <BeginStoryboard>
                          <Storyboard RepeatBehavior="Forever">
                            <DoubleAnimation Storyboard.TargetProperty="RenderTransform.(RotateTransform.Angle)" From="0" To="360" Duration="0:0:0.8"/>
                          </Storyboard>
                        </BeginStoryboard>
                      </EventTrigger>
                    </Path.Triggers>
                  </Path>
                </Grid>
                <TextBlock x:Name="QueueText" Foreground="#E9D5FF" FontSize="12" VerticalAlignment="Center" TextTrimming="CharacterEllipsis" MaxWidth="420"/>
              </StackPanel>
              <ProgressBar x:Name="QueueProgress" Style="{StaticResource Bar}" Height="2" VerticalAlignment="Bottom" Margin="-10,0,-12,0"/>
            </Grid>
          </Border>
          <Border x:Name="RebootBanner" Visibility="Collapsed" Background="#170F2A" BorderBrush="#5B2FA0" BorderThickness="1" CornerRadius="8" Margin="0,6,12,6" Padding="12,0,4,0">
            <StackPanel Orientation="Horizontal">
              <TextBlock Text="&#xE72C;" FontFamily="{StaticResource Icons}" Foreground="#C084FC" VerticalAlignment="Center" Margin="0,0,8,0"/>
              <TextBlock Text="Restart required to finish applying tweaks" Foreground="#E9D5FF" VerticalAlignment="Center" FontSize="12"/>
              <Button x:Name="BtnRestart" Content="Restart now" Style="{StaticResource AccentBtn}" Padding="10,3" FontSize="12" Margin="10,3,0,3" WindowChrome.IsHitTestVisibleInChrome="True"/>
            </StackPanel>
          </Border>
          <Button x:Name="BtnMin"   Style="{StaticResource TitleBtn}" Content="&#xE921;"/>
          <Button x:Name="BtnMax"   Style="{StaticResource TitleBtn}" Content="&#xE922;"/>
          <Button x:Name="BtnClose" Style="{StaticResource CloseBtn}" Content="&#xE8BB;"/>
        </StackPanel>
      </Grid>

      <Grid Grid.Row="1">

        <!-- ===================== DASHBOARD ===================== -->
        <ScrollViewer x:Name="PageDashboard" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
          <StackPanel Margin="28,6,28,28">
            <Grid>
              <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="400"/>
              </Grid.ColumnDefinitions>
              <Border Style="{StaticResource Card}" Padding="26,24">
                <Border.Background>
                  <!-- faint HUD grid -->
                  <DrawingBrush TileMode="Tile" Viewport="0,0,26,26" ViewportUnits="Absolute" Stretch="None">
                    <DrawingBrush.Drawing>
                      <GeometryDrawing Brush="#0A0810" Geometry="M0,0 L26,0 L26,26 L0,26 Z">
                        <GeometryDrawing.Pen><Pen Brush="#120C20" Thickness="1"/></GeometryDrawing.Pen>
                      </GeometryDrawing>
                    </DrawingBrush.Drawing>
                  </DrawingBrush>
                </Border.Background>
                <Grid>
                  <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="190"/>
                    <ColumnDefinition Width="*"/>
                  </Grid.ColumnDefinitions>
                  <!-- light sweep across the card every few seconds -->
                  <Canvas Grid.ColumnSpan="2" ClipToBounds="True" IsHitTestVisible="False">
                    <Rectangle Width="160" Height="420" Canvas.Top="-110">
                      <Rectangle.Fill>
                        <LinearGradientBrush StartPoint="0,0" EndPoint="1,0">
                          <GradientStop Color="#00C084FC" Offset="0"/><GradientStop Color="#16C084FC" Offset="0.5"/><GradientStop Color="#00C084FC" Offset="1"/>
                        </LinearGradientBrush>
                      </Rectangle.Fill>
                      <Rectangle.RenderTransform><TranslateTransform X="-260"/></Rectangle.RenderTransform>
                      <Rectangle.Triggers>
                        <EventTrigger RoutedEvent="FrameworkElement.Loaded">
                          <BeginStoryboard>
                            <Storyboard RepeatBehavior="Forever" Duration="0:0:6">
                              <DoubleAnimation Storyboard.TargetProperty="RenderTransform.(TranslateTransform.X)" From="-260" To="1200" Duration="0:0:2.2">
                                <DoubleAnimation.EasingFunction><SineEase EasingMode="EaseInOut"/></DoubleAnimation.EasingFunction>
                              </DoubleAnimation>
                            </Storyboard>
                          </BeginStoryboard>
                        </EventTrigger>
                      </Rectangle.Triggers>
                    </Rectangle>
                  </Canvas>
                  <Grid Width="170" Height="170" HorizontalAlignment="Left">
                    <Ellipse Margin="-34" IsHitTestVisible="False">
                      <Ellipse.Fill>
                        <RadialGradientBrush><GradientStop Color="#2EA855F7" Offset="0.5"/><GradientStop Color="#00A855F7" Offset="1"/></RadialGradientBrush>
                      </Ellipse.Fill>
                    </Ellipse>
                    <!-- HUD rings: fine ticks clockwise, long segments counter-clockwise -->
                    <Ellipse Margin="-10" Stroke="#6B4C9A" StrokeThickness="2" StrokeDashArray="0.6 4" RenderTransformOrigin="0.5,0.5">
                      <Ellipse.RenderTransform><RotateTransform/></Ellipse.RenderTransform>
                      <Ellipse.Triggers>
                        <EventTrigger RoutedEvent="FrameworkElement.Loaded">
                          <BeginStoryboard>
                            <Storyboard RepeatBehavior="Forever">
                              <DoubleAnimation Storyboard.TargetProperty="RenderTransform.(RotateTransform.Angle)" From="0" To="360" Duration="0:0:24"/>
                            </Storyboard>
                          </BeginStoryboard>
                        </EventTrigger>
                      </Ellipse.Triggers>
                    </Ellipse>
                    <Ellipse Margin="-18" Stroke="#3A2560" StrokeThickness="1.5" StrokeDashArray="34 22" RenderTransformOrigin="0.5,0.5">
                      <Ellipse.RenderTransform><RotateTransform/></Ellipse.RenderTransform>
                      <Ellipse.Triggers>
                        <EventTrigger RoutedEvent="FrameworkElement.Loaded">
                          <BeginStoryboard>
                            <Storyboard RepeatBehavior="Forever">
                              <DoubleAnimation Storyboard.TargetProperty="RenderTransform.(RotateTransform.Angle)" From="360" To="0" Duration="0:0:36"/>
                            </Storyboard>
                          </BeginStoryboard>
                        </EventTrigger>
                      </Ellipse.Triggers>
                    </Ellipse>
                    <Ellipse Stroke="#1C1530" StrokeThickness="14" Margin="0"/>
                    <Canvas Width="170" Height="170">
                      <Path x:Name="ScoreArc" StrokeThickness="14" StrokeStartLineCap="Round" StrokeEndLineCap="Round">
                        <Path.Stroke>
                          <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                            <GradientStop Color="#F0ABFC" Offset="0"/>
                            <GradientStop Color="#A855F7" Offset="0.5"/>
                            <GradientStop Color="#6D28D9" Offset="1"/>
                          </LinearGradientBrush>
                        </Path.Stroke>
                        <Path.Effect><DropShadowEffect Color="#A855F7" BlurRadius="22" ShadowDepth="0" Opacity="0.85"/></Path.Effect>
                      </Path>
                    </Canvas>
                    <Ellipse Margin="22" Stroke="#1C1530" StrokeThickness="1"/>
                    <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
                      <TextBlock x:Name="ScoreText" Text="0%" FontSize="38" FontWeight="Bold" HorizontalAlignment="Center" Foreground="#F5F3FA"/>
                      <TextBlock Text="O&#x2009;P&#x2009;T&#x2009;I&#x2009;M&#x2009;I&#x2009;Z&#x2009;E&#x2009;D" FontSize="10" FontWeight="SemiBold" Foreground="#C084FC" HorizontalAlignment="Center"/>
                    </StackPanel>
                  </Grid>
                  <StackPanel Grid.Column="1" VerticalAlignment="Center" Margin="18,0,0,0">
                    <TextBlock Text="O&#x2009;P&#x2009;T&#x2009;I&#x2009;M&#x2009;I&#x2009;Z&#x2009;A&#x2009;T&#x2009;I&#x2009;O&#x2009;N&#x2003;S&#x2009;T&#x2009;A&#x2009;T&#x2009;U&#x2009;S" Style="{StaticResource Label}" Margin="0,0,0,8"/>
                    <TextBlock x:Name="HeroTitle" Text="Scanning your PC..." Style="{StaticResource H1}" TextWrapping="Wrap"/>
                    <TextBlock x:Name="HeroSub" Text="" Style="{StaticResource Sub}" Margin="0,6,0,0"/>
                    <Border Background="#120D1C" BorderBrush="#A855F7" BorderThickness="2,0,0,0" CornerRadius="2,6,6,2" Padding="12,7" Margin="0,14,0,0" HorizontalAlignment="Left">
                      <TextBlock FontSize="13" Foreground="#D2CCE0">
                        <Run x:Name="HeroCount" Text="0" Foreground="#A855F7" FontWeight="Bold"/><Run Text=" recommended optimizations can be enabled to make your PC run smoother"/>
                      </TextBlock>
                    </Border>
                    <StackPanel Orientation="Horizontal" Margin="0,18,0,0">
                      <Button x:Name="BtnApplyRec" Style="{StaticResource AccentBtn}" Content="Apply Recommended"/>
                      <Button x:Name="BtnGoTweaks" Style="{StaticResource GhostBtn}" Content="View all optimizations" Margin="10,0,0,0"/>
                    </StackPanel>
                  </StackPanel>
                </Grid>
              </Border>

              <Border Grid.Column="1" Style="{StaticResource Card}" Margin="16,0,0,0">
                <StackPanel>
                  <Grid>
                    <StackPanel Orientation="Horizontal">
                      <TextBlock Text="S&#x2009;Y&#x2009;S&#x2009;T&#x2009;E&#x2009;M" Style="{StaticResource Label}" VerticalAlignment="Center"/>
                      <Ellipse Width="6" Height="6" Fill="#22C55E" Margin="10,0,5,0" VerticalAlignment="Center">
                        <Ellipse.Triggers>
                          <EventTrigger RoutedEvent="FrameworkElement.Loaded">
                            <BeginStoryboard>
                              <Storyboard RepeatBehavior="Forever" AutoReverse="True">
                                <DoubleAnimation Storyboard.TargetProperty="Opacity" From="1" To="0.2" Duration="0:0:0.7"/>
                              </Storyboard>
                            </BeginStoryboard>
                          </EventTrigger>
                        </Ellipse.Triggers>
                      </Ellipse>
                      <TextBlock Text="LIVE" FontSize="10" FontWeight="Bold" Foreground="#22C55E" VerticalAlignment="Center"/>
                    </StackPanel>
                    <TextBlock x:Name="DashMatch" Text="" FontSize="11" Foreground="#22C55E" HorizontalAlignment="Right" VerticalAlignment="Center"/>
                  </Grid>
                  <TextBlock x:Name="DashCpu" Text="-" FontSize="14" FontWeight="SemiBold" Margin="0,12,0,0" TextTrimming="CharacterEllipsis"/>
                  <TextBlock x:Name="DashGpu" Text="-" FontSize="14" FontWeight="SemiBold" Margin="0,4,0,0" TextTrimming="CharacterEllipsis"/>
                  <TextBlock x:Name="DashRam" Text="-" FontSize="12.5" Foreground="#8B84A3" Margin="0,4,0,0" TextTrimming="CharacterEllipsis"/>
                  <Grid Margin="0,18,0,4">
                    <TextBlock Text="CPU load" Foreground="#B9B2CF" FontSize="12"/>
                    <TextBlock x:Name="CpuPct" Text="-" Foreground="#ECE9F3" FontSize="12" HorizontalAlignment="Right"/>
                  </Grid>
                  <ProgressBar x:Name="CpuBar" Style="{StaticResource Bar}" Value="0"/>
                  <Grid Margin="0,12,0,4">
                    <TextBlock Text="Memory in use" Foreground="#B9B2CF" FontSize="12"/>
                    <TextBlock x:Name="RamPct" Text="-" Foreground="#ECE9F3" FontSize="12" HorizontalAlignment="Right"/>
                  </Grid>
                  <ProgressBar x:Name="RamBar" Style="{StaticResource Bar}" Value="0">
                    <ProgressBar.Foreground>
                      <LinearGradientBrush StartPoint="0,0" EndPoint="1,0"><GradientStop Color="#0891B2" Offset="0"/><GradientStop Color="#67E8F9" Offset="1"/></LinearGradientBrush>
                    </ProgressBar.Foreground>
                  </ProgressBar>
                  <Grid Margin="0,12,0,4">
                    <TextBlock Text="GPU load" Foreground="#B9B2CF" FontSize="12"/>
                    <TextBlock x:Name="GpuPct" Text="-" Foreground="#ECE9F3" FontSize="12" HorizontalAlignment="Right"/>
                  </Grid>
                  <ProgressBar x:Name="GpuBar" Style="{StaticResource Bar}" Value="0">
                    <ProgressBar.Foreground>
                      <LinearGradientBrush StartPoint="0,0" EndPoint="1,0"><GradientStop Color="#C026D3" Offset="0"/><GradientStop Color="#F0ABFC" Offset="1"/></LinearGradientBrush>
                    </ProgressBar.Foreground>
                  </ProgressBar>
                </StackPanel>
              </Border>
            </Grid>

            <UniformGrid Columns="4" Margin="0,16,-12,0">
              <Border Style="{StaticResource Card}" Padding="20,16" Margin="0,0,12,0">
                <StackPanel><Border Style="{StaticResource Tick}"/><TextBlock Text="ACTIVE TWEAKS" Style="{StaticResource Label}" Foreground="#8B84A3"/>
                  <TextBlock x:Name="StatActive" Text="0" FontSize="28" FontWeight="Bold" Margin="0,6,0,0"/></StackPanel>
              </Border>
              <Border Style="{StaticResource Card}" Padding="20,16" Margin="0,0,12,0">
                <StackPanel><Border Style="{StaticResource Tick}"/><TextBlock Text="RECOMMENDED LEFT" Style="{StaticResource Label}" Foreground="#8B84A3"/>
                  <TextBlock x:Name="StatLeft" Text="0" FontSize="28" FontWeight="Bold" Foreground="#C084FC" Margin="0,6,0,0"/></StackPanel>
              </Border>
              <Border Style="{StaticResource Card}" Padding="20,16" Margin="0,0,12,0">
                <StackPanel><Border Style="{StaticResource Tick}"/><TextBlock Text="RUNNING PROCESSES" Style="{StaticResource Label}" Foreground="#8B84A3"/>
                  <TextBlock x:Name="StatProcs" Text="-" FontSize="28" FontWeight="Bold" Margin="0,6,0,0"/></StackPanel>
              </Border>
              <Border Style="{StaticResource Card}" Padding="20,16" Margin="0,0,12,0">
                <StackPanel><Border Style="{StaticResource Tick}"/><TextBlock Text="TOTAL TWEAKS" Style="{StaticResource Label}" Foreground="#8B84A3"/>
                  <TextBlock x:Name="StatTotal" Text="0" FontSize="28" FontWeight="Bold" Margin="0,6,0,0"/></StackPanel>
              </Border>
            </UniformGrid>

            <Grid Margin="0,16,0,0">
              <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="400"/>
              </Grid.ColumnDefinitions>
              <Border Style="{StaticResource Card}">
                <StackPanel>
                  <StackPanel Orientation="Horizontal">
                    <TextBlock Text="&#xE734;" FontFamily="{StaticResource Icons}" Foreground="#A855F7" FontSize="18" VerticalAlignment="Center" Margin="0,0,10,0"/>
                    <StackPanel>
                      <TextBlock Text="Recommendations" Style="{StaticResource H2}"/>
                      <TextBlock Text="Highest-impact tweaks you haven't enabled yet" Style="{StaticResource Sub}" FontSize="12"/>
                    </StackPanel>
                  </StackPanel>
                  <StackPanel x:Name="RecList" Margin="0,16,0,0"/>
                  <Button x:Name="BtnApplyAllRec" Style="{StaticResource AccentBtn}" Content="Apply all" HorizontalAlignment="Left" Margin="0,8,0,0"/>
                </StackPanel>
              </Border>
              <StackPanel Grid.Column="1" Margin="16,0,0,0">
                <!-- Game Session -->
                <Border Style="{StaticResource Card}" Margin="0,0,0,16">
                  <StackPanel>
                    <Grid>
                      <StackPanel Orientation="Horizontal">
                        <TextBlock Text="&#xE7FC;" FontFamily="{StaticResource Icons}" Foreground="#C084FC" FontSize="18" VerticalAlignment="Center" Margin="0,0,10,0"/>
                        <TextBlock Text="Game Session" Style="{StaticResource H2}" VerticalAlignment="Center"/>
                      </StackPanel>
                      <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <TextBlock Text="Auto" Foreground="#8B84A3" FontSize="12" VerticalAlignment="Center" Margin="0,0,8,0"
                                   ToolTip="Start a session automatically when a game from your Games list launches, and end it when the game closes"/>
                        <ToggleButton x:Name="SetAutoSession" Style="{StaticResource Switch}"/>
                      </StackPanel>
                    </Grid>
                    <TextBlock x:Name="SessionText" Style="{StaticResource Sub}" FontSize="12" Margin="0,8,0,14"
                               Text="Closes background apps, pauses Windows Update and turns on Do Not Disturb while you play - and puts it all back afterwards."/>
                    <Button x:Name="BtnSession" Style="{StaticResource AccentBtn}" Content="Start session" HorizontalAlignment="Left"/>
                  </StackPanel>
                </Border>
                <Border Style="{StaticResource Card}">
                  <StackPanel>
                    <TextBlock Text="Shortcuts" Style="{StaticResource H2}" Margin="0,0,0,14"/>
                    <UniformGrid Columns="2" Margin="0,0,-10,-10">
                      <Button x:Name="ShortScan" Style="{StaticResource Tile}">
                        <StackPanel><TextBlock Text="&#xE9D9;" FontFamily="{StaticResource Icons}" FontSize="24" HorizontalAlignment="Center"/>
                          <TextBlock Text="PC Scanner" Margin="0,8,0,0" HorizontalAlignment="Center"/></StackPanel>
                      </Button>
                      <Button x:Name="ShortBoost" Style="{StaticResource Tile}">
                        <StackPanel><TextBlock Text="&#xE945;" FontFamily="{StaticResource Icons}" FontSize="24" HorizontalAlignment="Center"/>
                          <TextBlock Text="Boost Up" Margin="0,8,0,0" HorizontalAlignment="Center"/></StackPanel>
                      </Button>
                      <Button x:Name="ShortBackup" Style="{StaticResource Tile}">
                        <StackPanel><TextBlock Text="&#xE777;" FontFamily="{StaticResource Icons}" FontSize="24" HorizontalAlignment="Center"/>
                          <TextBlock Text="Backups" Margin="0,8,0,0" HorizontalAlignment="Center"/></StackPanel>
                      </Button>
                      <Button x:Name="ShortGpu" Style="{StaticResource Tile}">
                        <StackPanel><TextBlock Text="&#xE7F4;" FontFamily="{StaticResource Icons}" FontSize="24" HorizontalAlignment="Center"/>
                          <TextBlock x:Name="ShortGpuText" Text="GPU Panel" Margin="0,8,0,0" HorizontalAlignment="Center"/></StackPanel>
                      </Button>
                    </UniformGrid>
                  </StackPanel>
                </Border>
                <Border Style="{StaticResource Card}" Margin="0,16,0,0" BorderBrush="#3B1F5C">
                  <StackPanel>
                    <StackPanel Orientation="Horizontal">
                      <TextBlock Text="&#xE946;" FontFamily="{StaticResource Icons}" Foreground="#C084FC" FontSize="16" VerticalAlignment="Center" Margin="0,0,8,0"/>
                      <TextBlock Text="Bottleneck insight" Style="{StaticResource H2}"/>
                    </StackPanel>
                    <TextBlock x:Name="InsightText" Style="{StaticResource Sub}" Margin="0,10,0,0" LineHeight="19"/>
                  </StackPanel>
                </Border>
              </StackPanel>
            </Grid>
          </StackPanel>
        </ScrollViewer>

        <!-- ===================== SCANNER ===================== -->
        <ScrollViewer x:Name="PageScanner" Visibility="Collapsed" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
          <StackPanel Margin="28,6,28,28">
            <Grid Margin="0,0,0,18">
              <StackPanel>
                <TextBlock Text="PC Scanner" Style="{StaticResource H1}"/>
                <TextBlock x:Name="ScanSub" Text="Hardware and system state detected on this PC" Style="{StaticResource Sub}" Margin="0,4,0,0"/>
              </StackPanel>
              <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                <Border x:Name="ProfileBadge" CornerRadius="8" Padding="12,7" Margin="0,0,10,0" Background="#0F2418" BorderBrush="#1E5A35" BorderThickness="1">
                  <TextBlock x:Name="ProfileText" Text="" Foreground="#4ADE80" FontSize="12"/>
                </Border>
                <Button x:Name="BtnRescan" Style="{StaticResource GhostBtn}" Content="Rescan"/>
              </StackPanel>
            </Grid>
            <UniformGrid x:Name="ScanGrid" Columns="3" Margin="0,0,-14,0"/>
            <TextBlock Text="Health check" Style="{StaticResource H2}" Margin="0,16,0,4"/>
            <TextBlock Text="What is holding this PC back - and what is already in good shape" Style="{StaticResource Sub}" Margin="0,0,0,12"/>
            <UniformGrid x:Name="HealthList" Columns="2" Margin="0,0,-14,0"/>
            <!-- PCPartPicker -->
            <Border Style="{StaticResource Card}" Margin="0,4,0,0">
              <StackPanel>
                <Grid>
                  <StackPanel>
                    <TextBlock Text="This PC on PCPartPicker" Style="{StaticResource H2}"/>
                    <TextBlock Text="PCPartPicker has no public API, so Zenith opens a search for each detected part - click 'Add to Part List' on each result. The case, power supply and CPU cooler can't be detected by software; add those yourself."
                               Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,0" MaxWidth="760" HorizontalAlignment="Left"/>
                  </StackPanel>
                  <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Top">
                    <Button x:Name="BtnPartsCopy" Style="{StaticResource GhostBtn}" Content="Copy parts list" Padding="12,6"/>
                    <Button x:Name="BtnPartsOpen" Style="{StaticResource AccentBtn}" Content="Search all on PCPartPicker" Padding="12,6" Margin="10,0,0,0"/>
                  </StackPanel>
                </Grid>
                <StackPanel x:Name="PartsList" Margin="0,14,0,0"/>
              </StackPanel>
            </Border>
          </StackPanel>
        </ScrollViewer>

        <!-- ===================== OPTIMIZATIONS ===================== -->
        <Grid x:Name="PageTweaks" Visibility="Collapsed">
          <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
          </Grid.RowDefinitions>
          <Grid Margin="28,6,28,14">
            <StackPanel>
              <TextBlock Text="Optimizations" Style="{StaticResource H1}"/>
              <TextBlock x:Name="TweakSummary" Text="" Style="{StaticResource Sub}" Margin="0,4,0,0"/>
            </StackPanel>
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
              <Grid Width="240" Margin="0,0,10,0">
                <TextBox x:Name="SearchBox" Style="{StaticResource Input}" Padding="32,8,10,8"/>
                <TextBlock Text="&#xE721;" FontFamily="{StaticResource Icons}" Foreground="#7A7393" VerticalAlignment="Center" Margin="12,0,0,0" IsHitTestVisible="False"/>
                <TextBlock x:Name="SearchHint" Text="Search tweaks" Foreground="#5E5679" VerticalAlignment="Center" Margin="34,0,0,0" IsHitTestVisible="False"/>
              </Grid>
              <Button x:Name="BtnTweaksApplyRec" Style="{StaticResource AccentBtn}" Content="Apply Recommended"/>
              <Button x:Name="BtnRevertAll" Style="{StaticResource GhostBtn}" Content="Revert all" Margin="10,0,0,0"/>
            </StackPanel>
          </Grid>
          <WrapPanel x:Name="ChipPanel" Grid.Row="1" Margin="28,0,28,8"/>
          <ScrollViewer x:Name="TweakScroll" Grid.Row="2" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
            <UniformGrid x:Name="TweakGrid" Columns="3" Margin="28,6,14,28" VerticalAlignment="Top"/>
          </ScrollViewer>
        </Grid>

        <!-- ===================== BOOST ===================== -->
        <ScrollViewer x:Name="PageBoost" Visibility="Collapsed" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
          <StackPanel Margin="28,6,28,28">
            <TextBlock Text="Boost Up" Style="{StaticResource H1}"/>
            <TextBlock Text="One-click actions to run before a gaming session, plus the GPU and in-game settings that matter most" Style="{StaticResource Sub}" Margin="0,4,0,18"/>
            <UniformGrid x:Name="BoostGrid" Columns="3" Margin="0,0,-14,0"/>

            <Grid Margin="0,4,0,0">
              <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
              </Grid.ColumnDefinitions>
              <Border Style="{StaticResource Card}" Margin="0,0,8,0">
                <StackPanel>
                  <Grid>
                    <TextBlock Text="Games" Style="{StaticResource H2}"/>
                    <Button x:Name="BtnFindGames" Style="{StaticResource AccentBtn}" Content="Find my games" Padding="12,5" HorizontalAlignment="Right"/>
                  </Grid>
                  <TextBlock Text="Games in this list start with High CPU priority, run on your dedicated graphics card (Windows' High performance GPU setting) and can start a Game Session automatically. 'Find my games' scans Steam, Epic, Riot, EA, Ubisoft and Battle.net - or add an .exe name or full path yourself."
                             Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,14"/>
                  <Grid>
                    <Grid.ColumnDefinitions>
                      <ColumnDefinition Width="*"/>
                      <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <TextBox x:Name="GameExe" Style="{StaticResource Input}"/>
                    <Button x:Name="BtnAddGame" Grid.Column="1" Style="{StaticResource GhostBtn}" Content="Add" Margin="10,0,0,0"/>
                  </Grid>
                  <ScrollViewer MaxHeight="360" VerticalScrollBarVisibility="Auto" Margin="0,14,0,0">
                    <StackPanel x:Name="GameList"/>
                  </ScrollViewer>
                </StackPanel>
              </Border>
              <Border x:Name="GpuCard" Grid.Column="1" Style="{StaticResource Card}" Margin="8,0,0,0">
                <StackPanel>
                  <Grid>
                    <TextBlock x:Name="GpuCardTitle" Text="GPU control panel setup" Style="{StaticResource H2}"/>
                    <Button x:Name="BtnOpenGpuPanel" Style="{StaticResource GhostBtn}" Content="Open panel" Padding="12,5" HorizontalAlignment="Right"/>
                  </Grid>
                  <TextBlock x:Name="GpuCardSub" Text="" Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,10"/>
                  <StackPanel x:Name="GpuList"/>
                </StackPanel>
              </Border>
            </Grid>

            <!-- Startup apps -->
            <Border Style="{StaticResource Card}" Margin="0,16,0,0">
              <StackPanel>
                <TextBlock Text="Startup apps" Style="{StaticResource H2}"/>
                <TextBlock x:Name="StartupSummary" Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,12"
                           Text="Apps that launch with Windows. Switching one off works exactly like Task Manager's Startup tab and can be switched back any time."/>
                <UniformGrid x:Name="StartupList" Columns="2" Margin="0,0,-16,0"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}" Margin="0,16,0,0">
              <StackPanel>
                <TextBlock Text="In-game settings that give the most FPS" Style="{StaticResource H2}"/>
                <TextBlock Text="The tweaks in this app remove Windows overhead and latency. In most games the graphics card sets the FPS ceiling - these settings move that ceiling the most." Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,12"/>
                <UniformGrid x:Name="GameTips" Columns="2"/>
              </StackPanel>
            </Border>
          </StackPanel>
        </ScrollViewer>

        <!-- ===================== TEST ===================== -->
        <ScrollViewer x:Name="PageTest" Visibility="Collapsed" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
          <StackPanel Margin="28,6,28,28">
            <TextBlock Text="Test" Style="{StaticResource H1}"/>
            <TextBlock Text="Measure instead of guessing: record FPS before and after optimizing, and find out where lag comes from" Style="{StaticResource Sub}" Margin="0,4,0,18"/>

            <!-- FPS test -->
            <Border Style="{StaticResource Card}">
              <StackPanel>
                <Grid>
                  <TextBlock Text="FPS test" Style="{StaticResource H2}"/>
                  <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                    <Button x:Name="BtnGetPm" Style="{StaticResource GhostBtn}" Content="Get PresentMon" Padding="12,5"/>
                    <Button x:Name="BtnFindPm" Style="{StaticResource GhostBtn}" Content="Locate..." Padding="12,5" Margin="8,0,0,0"/>
                  </StackPanel>
                </Grid>
                <TextBlock Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,4"
                           Text="Uses Intel's free, open-source PresentMon 2.x to record real frame times. Start your game, pick it below and press Start - you get 10 seconds to switch back to the game (a sound plays when recording starts and ends). Play the same scene before and after optimizing to compare."/>
                <TextBlock x:Name="PmStatus" FontSize="12" Foreground="#F5A524" Margin="0,0,0,14"/>
                <StackPanel Orientation="Horizontal">
                  <ComboBox x:Name="FpsGame" Width="300" Margin="0,0,10,0" Style="{StaticResource Combo}"/>
                  <ComboBox x:Name="FpsSecs" Width="90" Margin="0,0,10,0" Style="{StaticResource Combo}" SelectedIndex="1">
                    <ComboBoxItem Content="30 s"/><ComboBoxItem Content="60 s"/><ComboBoxItem Content="120 s"/>
                  </ComboBox>
                  <Grid Width="160" Margin="0,0,10,0">
                    <TextBox x:Name="FpsLabel" Style="{StaticResource Input}"/>
                    <TextBlock x:Name="FpsLabelHint" Text="Label, e.g. Before" Foreground="#5E5679" VerticalAlignment="Center" Margin="12,0,0,0" IsHitTestVisible="False"/>
                  </Grid>
                  <Button x:Name="BtnFps" Style="{StaticResource AccentBtn}" Content="Start test"/>
                </StackPanel>
                <TextBlock x:Name="FpsCompare" FontSize="13" FontWeight="SemiBold" Foreground="#22C55E" Margin="0,16,0,0" TextWrapping="Wrap"/>
                <StackPanel x:Name="FpsResults" Margin="0,10,0,0"/>
                <Button x:Name="BtnFpsClear" Style="{StaticResource GhostBtn}" Content="Clear results" Padding="12,5" HorizontalAlignment="Left" Margin="0,10,0,0"/>
              </StackPanel>
            </Border>

            <!-- Network test -->
            <Border Style="{StaticResource Card}" Margin="0,16,0,0">
              <StackPanel>
                <Grid>
                  <TextBlock Text="Network test" Style="{StaticResource H2}"/>
                  <Button x:Name="BtnNet" Style="{StaticResource AccentBtn}" Content="Run test" Padding="14,6" HorizontalAlignment="Right"/>
                </Grid>
                <TextBlock Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,12"
                           Text="Pings your router (your own network or Wi-Fi) and two large internet services (the route through your provider) to measure latency, jitter and packet loss. Game servers often block pings, so this tells you whether lag starts at home, at your provider, or further away."/>
                <UniformGrid x:Name="NetResults" Columns="3" Margin="0,0,-12,0"/>
                <TextBlock x:Name="NetVerdict" FontSize="13" FontWeight="SemiBold" TextWrapping="Wrap" Margin="0,10,0,0"/>
              </StackPanel>
            </Border>
          </StackPanel>
        </ScrollViewer>

        <!-- ===================== BACKUPS ===================== -->
        <ScrollViewer x:Name="PageBackup" Visibility="Collapsed" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
          <StackPanel Margin="28,6,28,28">
            <TextBlock Text="Backups &amp; Restore" Style="{StaticResource H1}"/>
            <TextBlock Text="Every change Zenith makes is recorded so it can be undone." Style="{StaticResource Sub}" Margin="0,4,0,18"/>
            <Grid>
              <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
              </Grid.ColumnDefinitions>
              <Border Style="{StaticResource Card}" Margin="0,0,8,0">
                <StackPanel>
                  <TextBlock Text="&#xE777;" FontFamily="{StaticResource Icons}" FontSize="26" Foreground="#A855F7"/>
                  <TextBlock Text="System Restore point" Style="{StaticResource H2}" Margin="0,10,0,0"/>
                  <TextBlock Text="A full Windows snapshot of the registry and system files. If anything ever goes wrong, boot into System Restore and roll back." Style="{StaticResource Sub}" Margin="0,6,0,16"/>
                  <StackPanel Orientation="Horizontal">
                    <Button x:Name="BtnCreateRP" Style="{StaticResource AccentBtn}" Content="Create restore point"/>
                    <Button x:Name="BtnOpenRstrui" Style="{StaticResource GhostBtn}" Content="Open System Restore" Margin="10,0,0,0"/>
                  </StackPanel>
                </StackPanel>
              </Border>
              <Border Grid.Column="1" Style="{StaticResource Card}" Margin="8,0,0,0">
                <StackPanel>
                  <TextBlock Text="&#xE74E;" FontFamily="{StaticResource Icons}" FontSize="26" Foreground="#8B5CF6"/>
                  <TextBlock Text="Zenith backup" Style="{StaticResource H2}" Margin="0,10,0,0"/>
                  <TextBlock x:Name="BackupInfo" Text="" Style="{StaticResource Sub}" Margin="0,6,0,16"/>
                  <StackPanel Orientation="Horizontal">
                    <Button x:Name="BtnRevertAll2" Style="{StaticResource DangerBtn}" Content="Revert every tweak"/>
                    <Button x:Name="BtnOpenData" Style="{StaticResource GhostBtn}" Content="Open backup folder" Margin="10,0,0,0"/>
                  </StackPanel>
                </StackPanel>
              </Border>
            </Grid>
            <Border Style="{StaticResource Card}" Margin="0,16,0,0">
              <Grid>
                <StackPanel Margin="0,0,330,0">
                  <TextBlock Text="Profile - take your setup to another PC" Style="{StaticResource H2}"/>
                  <TextBlock Style="{StaticResource Sub}" FontSize="12" Margin="0,6,0,0"
                             Text="Export saves the list of optimizations active on this PC to a file. Import on another PC queues the ones that apply there - it asks first and every one stays individually reversible."/>
                </StackPanel>
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                  <Button x:Name="BtnExport" Style="{StaticResource GhostBtn}" Content="Export profile"/>
                  <Button x:Name="BtnImport" Style="{StaticResource AccentBtn}" Content="Import profile" Margin="10,0,0,0"/>
                </StackPanel>
              </Grid>
            </Border>
            <Border Style="{StaticResource Card}" Margin="0,16,0,0">
              <StackPanel>
                <Grid>
                  <TextBlock Text="Activity log" Style="{StaticResource H2}"/>
                  <Button x:Name="BtnRefreshLog" Style="{StaticResource GhostBtn}" Content="Refresh" Padding="12,5" HorizontalAlignment="Right"/>
                </Grid>
                <TextBox x:Name="LogBox" Style="{StaticResource Input}" Height="300" Margin="0,12,0,0" IsReadOnly="True" TextWrapping="Wrap"
                         VerticalScrollBarVisibility="Auto" FontFamily="Consolas" FontSize="12" VerticalContentAlignment="Top"/>
              </StackPanel>
            </Border>
          </StackPanel>
        </ScrollViewer>

        <!-- ===================== SETTINGS ===================== -->
        <ScrollViewer x:Name="PageSettings" Visibility="Collapsed" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
          <StackPanel Margin="28,6,28,28" MaxWidth="900" HorizontalAlignment="Left">
            <TextBlock Text="Settings" Style="{StaticResource H1}" Margin="0,0,0,18"/>
            <Border Style="{StaticResource Card}">
              <StackPanel>
                <Grid Margin="0,0,0,18">
                  <StackPanel Margin="0,0,70,0">
                    <TextBlock Text="Create a restore point before applying" FontSize="14" FontWeight="SemiBold"/>
                    <TextBlock Text="Makes a Windows System Restore point the first time you apply tweaks in each session." Style="{StaticResource Sub}" FontSize="12" Margin="0,3,0,0"/>
                  </StackPanel>
                  <ToggleButton x:Name="SetRestore" Style="{StaticResource Switch}" HorizontalAlignment="Right"/>
                </Grid>
                <Grid Margin="0,0,0,18">
                  <StackPanel Margin="0,0,70,0">
                    <TextBlock Text="Show advanced tweaks" FontSize="14" FontWeight="SemiBold"/>
                    <TextBlock Text="Shows tweaks with security trade-offs (Memory Integrity, Spectre/Meltdown mitigations). They are never applied by 'Apply Recommended'." Style="{StaticResource Sub}" FontSize="12" Margin="0,3,0,0"/>
                  </StackPanel>
                  <ToggleButton x:Name="SetAdvanced" Style="{StaticResource Switch}" HorizontalAlignment="Right"/>
                </Grid>
                <Grid>
                  <StackPanel Margin="0,0,70,0">
                    <TextBlock Text="Confirm risky and feature-breaking tweaks" FontSize="14" FontWeight="SemiBold"/>
                    <TextBlock Text="Asks before enabling a tweak that removes a feature or lowers security." Style="{StaticResource Sub}" FontSize="12" Margin="0,3,0,0"/>
                  </StackPanel>
                  <ToggleButton x:Name="SetConfirm" Style="{StaticResource Switch}" HorizontalAlignment="Right"/>
                </Grid>
                <Grid Margin="0,18,0,0">
                  <StackPanel Margin="0,0,70,0">
                    <TextBlock Text="Hide to the tray while gaming" FontSize="14" FontWeight="SemiBold"/>
                    <TextBlock Text="When a game from your Games list starts, Zenith hides in the system tray - no window, no animations, no GPU use. Double-click the tray icon to bring it back." Style="{StaticResource Sub}" FontSize="12" Margin="0,3,0,0"/>
                  </StackPanel>
                  <ToggleButton x:Name="SetTray" Style="{StaticResource Switch}" HorizontalAlignment="Right"/>
                </Grid>
              </StackPanel>
            </Border>
            <Border Style="{StaticResource Card}" Margin="0,16,0,0">
              <StackPanel>
                <TextBlock Text="About Zenith" Style="{StaticResource H2}"/>
                <TextBlock x:Name="AboutText" Style="{StaticResource Sub}" Margin="0,8,0,0" LineHeight="19"/>
              </StackPanel>
            </Border>
          </StackPanel>
        </ScrollViewer>
      </Grid>
    </Grid>

    <!-- ===================== SPLASH (startup animation, covers the background scan) ===================== -->
    <Grid x:Name="Splash" Grid.ColumnSpan="2" Panel.ZIndex="100" Background="#000000" RenderTransformOrigin="0.5,0.5">
      <Grid.RenderTransform><ScaleTransform x:Name="SplashScale"/></Grid.RenderTransform>
      <Ellipse x:Name="SplashGlow" Width="900" Height="900" Opacity="0" IsHitTestVisible="False">
        <Ellipse.Fill>
          <RadialGradientBrush><GradientStop Color="#307C3AED" Offset="0"/><GradientStop Color="#00000000" Offset="0.7"/></RadialGradientBrush>
        </Ellipse.Fill>
      </Ellipse>
      <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
        <Grid Width="220" Height="200" HorizontalAlignment="Center">
          <Ellipse x:Name="SplashRing" Width="150" Height="150" Stroke="#C084FC" StrokeThickness="2" Opacity="0" RenderTransformOrigin="0.5,0.5">
            <Ellipse.RenderTransform><ScaleTransform x:Name="SplashRingScale" ScaleX="0.4" ScaleY="0.4"/></Ellipse.RenderTransform>
          </Ellipse>
          <Viewbox Width="180" Height="180">
            <Canvas Width="64" Height="64">
              <Path x:Name="SplashA" Data="{StaticResource ZA}" Fill="{StaticResource ZWhite}" Opacity="0">
                <Path.RenderTransform><TranslateTransform x:Name="SplashAT" X="-16" Y="-12"/></Path.RenderTransform>
              </Path>
              <Path x:Name="SplashB" Data="{StaticResource ZB}" Fill="{StaticResource ZWhite}" Opacity="0">
                <Path.RenderTransform><TranslateTransform x:Name="SplashBT" X="16" Y="12"/></Path.RenderTransform>
              </Path>
              <Path x:Name="SplashBlade" Data="{StaticResource ZBlade}" Fill="{StaticResource ZBladeFill}" Opacity="0" RenderTransformOrigin="0.5,0.5">
                <Path.RenderTransform><ScaleTransform x:Name="SplashBladeScale" ScaleX="0" ScaleY="0"/></Path.RenderTransform>
                <Path.Effect><DropShadowEffect Color="#C084FC" BlurRadius="12" ShadowDepth="0" Opacity="1"/></Path.Effect>
              </Path>
            </Canvas>
          </Viewbox>
        </Grid>
        <TextBlock x:Name="SplashWord" Text="Z&#x2009;&#x2009;E&#x2009;&#x2009;N&#x2009;&#x2009;I&#x2009;&#x2009;T&#x2009;&#x2009;H" FontSize="30" FontWeight="Bold" HorizontalAlignment="Center" Margin="0,6,0,0" Opacity="0">
          <TextBlock.Foreground>
            <LinearGradientBrush StartPoint="0,0" EndPoint="1,0"><GradientStop Color="#FFFFFF" Offset="0"/><GradientStop Color="#C084FC" Offset="1"/></LinearGradientBrush>
          </TextBlock.Foreground>
          <TextBlock.RenderTransform><TranslateTransform x:Name="SplashWordT" Y="14"/></TextBlock.RenderTransform>
        </TextBlock>
        <TextBlock x:Name="SplashTag" Text="G&#x2009;A&#x2009;M&#x2009;I&#x2009;N&#x2009;G&#x2003;P&#x2009;E&#x2009;R&#x2009;F&#x2009;O&#x2009;R&#x2009;M&#x2009;A&#x2009;N&#x2009;C&#x2009;E&#x2003;O&#x2009;P&#x2009;T&#x2009;I&#x2009;M&#x2009;I&#x2009;Z&#x2009;E&#x2009;R"
                   FontSize="10.5" FontWeight="SemiBold" Foreground="#8B84A3" HorizontalAlignment="Center" Margin="0,10,0,0" Opacity="0"/>
        <Border x:Name="SplashLoader" Width="180" Height="2" CornerRadius="1" Background="#1A1328" Margin="0,34,0,0" ClipToBounds="True" Opacity="0">
          <Border Width="60" HorizontalAlignment="Left" CornerRadius="1" Background="{StaticResource AccentGrad}">
            <Border.RenderTransform><TranslateTransform x:Name="SplashLoaderT" X="-60"/></Border.RenderTransform>
          </Border>
        </Border>
        <TextBlock x:Name="SplashStatus" Text="Scanning your hardware" FontSize="11.5" Foreground="#665F80" HorizontalAlignment="Center" Margin="0,10,0,0" Opacity="0"/>
      </StackPanel>
      <Grid.Triggers>
        <EventTrigger RoutedEvent="FrameworkElement.Loaded">
          <BeginStoryboard>
            <Storyboard>
              <DoubleAnimation Storyboard.TargetName="SplashGlow" Storyboard.TargetProperty="Opacity" To="1" Duration="0:0:0.9"/>
              <!-- the two halves slide together -->
              <DoubleAnimation Storyboard.TargetName="SplashA" Storyboard.TargetProperty="Opacity" To="1" BeginTime="0:0:0.1" Duration="0:0:0.3"/>
              <DoubleAnimation Storyboard.TargetName="SplashB" Storyboard.TargetProperty="Opacity" To="1" BeginTime="0:0:0.1" Duration="0:0:0.3"/>
              <DoubleAnimation Storyboard.TargetName="SplashAT" Storyboard.TargetProperty="X" To="0" BeginTime="0:0:0.1" Duration="0:0:0.45"><DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <DoubleAnimation Storyboard.TargetName="SplashAT" Storyboard.TargetProperty="Y" To="0" BeginTime="0:0:0.1" Duration="0:0:0.45"><DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <DoubleAnimation Storyboard.TargetName="SplashBT" Storyboard.TargetProperty="X" To="0" BeginTime="0:0:0.1" Duration="0:0:0.45"><DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <DoubleAnimation Storyboard.TargetName="SplashBT" Storyboard.TargetProperty="Y" To="0" BeginTime="0:0:0.1" Duration="0:0:0.45"><DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <!-- the blade slashes through, with a shockwave -->
              <DoubleAnimation Storyboard.TargetName="SplashBlade" Storyboard.TargetProperty="Opacity" To="1" BeginTime="0:0:0.5" Duration="0:0:0.05"/>
              <DoubleAnimation Storyboard.TargetName="SplashBladeScale" Storyboard.TargetProperty="ScaleX" To="1" BeginTime="0:0:0.5" Duration="0:0:0.25"><DoubleAnimation.EasingFunction><ExponentialEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <DoubleAnimation Storyboard.TargetName="SplashBladeScale" Storyboard.TargetProperty="ScaleY" To="1" BeginTime="0:0:0.5" Duration="0:0:0.25"><DoubleAnimation.EasingFunction><ExponentialEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <DoubleAnimation Storyboard.TargetName="SplashRing" Storyboard.TargetProperty="Opacity" From="0.9" To="0" BeginTime="0:0:0.55" Duration="0:0:0.7"/>
              <DoubleAnimation Storyboard.TargetName="SplashRingScale" Storyboard.TargetProperty="ScaleX" To="1.8" BeginTime="0:0:0.55" Duration="0:0:0.7"><DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <DoubleAnimation Storyboard.TargetName="SplashRingScale" Storyboard.TargetProperty="ScaleY" To="1.8" BeginTime="0:0:0.55" Duration="0:0:0.7"><DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <!-- wordmark, tagline, loader -->
              <DoubleAnimation Storyboard.TargetName="SplashWord" Storyboard.TargetProperty="Opacity" To="1" BeginTime="0:0:0.75" Duration="0:0:0.4"/>
              <DoubleAnimation Storyboard.TargetName="SplashWordT" Storyboard.TargetProperty="Y" To="0" BeginTime="0:0:0.75" Duration="0:0:0.5"><DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
              <DoubleAnimation Storyboard.TargetName="SplashTag" Storyboard.TargetProperty="Opacity" To="1" BeginTime="0:0:0.95" Duration="0:0:0.4"/>
              <DoubleAnimation Storyboard.TargetName="SplashLoader" Storyboard.TargetProperty="Opacity" To="1" BeginTime="0:0:1.1" Duration="0:0:0.3"/>
              <DoubleAnimation Storyboard.TargetName="SplashStatus" Storyboard.TargetProperty="Opacity" To="1" BeginTime="0:0:1.1" Duration="0:0:0.3"/>
            </Storyboard>
          </BeginStoryboard>
          <BeginStoryboard>
            <Storyboard RepeatBehavior="Forever">
              <DoubleAnimation Storyboard.TargetName="SplashLoaderT" Storyboard.TargetProperty="X" From="-60" To="180" Duration="0:0:1"><DoubleAnimation.EasingFunction><SineEase EasingMode="EaseInOut"/></DoubleAnimation.EasingFunction></DoubleAnimation>
            </Storyboard>
          </BeginStoryboard>
        </EventTrigger>
      </Grid.Triggers>
    </Grid>

    <!-- ===================== TOAST ===================== -->
    <Border x:Name="Toast" Grid.ColumnSpan="2" Panel.ZIndex="60" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,26,24"
            Background="#150F21" BorderBrush="#4A2E78" BorderThickness="1" CornerRadius="10" Padding="16,12" Opacity="0" IsHitTestVisible="False" MaxWidth="420">
      <Border.RenderTransform><TranslateTransform x:Name="ToastT"/></Border.RenderTransform>
      <Border.Effect><DropShadowEffect Color="#7C3AED" BlurRadius="24" ShadowDepth="0" Opacity="0.4"/></Border.Effect>
      <StackPanel Orientation="Horizontal">
        <TextBlock x:Name="ToastIcon" Text="&#xE73E;" FontFamily="{StaticResource Icons}" Foreground="#22C55E" FontSize="15" VerticalAlignment="Center" Margin="0,0,10,0"/>
        <TextBlock x:Name="ToastText" Text="" Foreground="#ECE9F3" TextWrapping="Wrap" VerticalAlignment="Center" MaxWidth="360"/>
      </StackPanel>
    </Border>
  </Grid>
</Window>
'@

# ================================================================ BUILD WINDOW
try {
    $script:Window = [Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $MainXaml))
} catch {
    $msg = $_.Exception.Message; if ($_.Exception.InnerException) { $msg += "`n`n" + $_.Exception.InnerException.Message }
    Write-Log "UI load failed: $msg"
    [System.Windows.MessageBox]::Show("Zenith could not load its interface:`n`n$msg", 'Zenith', 'OK', 'Error') | Out-Null
    exit
}
$Window = $script:Window
$ui = @{}
foreach ($m in [regex]::Matches($MainXaml.OuterXml, 'x:Name="([^"]+)"')) {
    $n = $m.Groups[1].Value
    $el = $Window.FindName($n)
    if ($el) { $ui[$n] = $el }
}

$NS   = 'xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"'
$BC   = New-Object System.Windows.Media.BrushConverter
$IconFont = New-Object System.Windows.Media.FontFamily('Segoe Fluent Icons, Segoe MDL2 Assets')
function Brush([string]$hex) { $BC.ConvertFromString($hex) }
function New-El([string]$x) { [Windows.Markup.XamlReader]::Parse($x.Replace('%NS%', $NS)) }
# Eased one-shot animation; $From = $null continues from the current (possibly mid-animation) value.
function Start-Anim($Target, $Prop, $From, [double]$To, [int]$Ms = 260) {
    $a = New-Object System.Windows.Media.Animation.DoubleAnimation
    if ($null -ne $From) { $a.From = [double]$From }
    $a.To = $To; $a.Duration = New-Object System.Windows.Duration([TimeSpan]::FromMilliseconds($Ms))
    $e = New-Object System.Windows.Media.Animation.CubicEase; $e.EasingMode = 'EaseOut'; $a.EasingFunction = $e
    $Target.BeginAnimation($Prop, $a)
}

# window icon
try {
    $bytes = [Convert]::FromBase64String($IconB64)
    $bmp = New-Object System.Windows.Media.Imaging.BitmapImage
    $bmp.BeginInit(); $bmp.StreamSource = New-Object System.IO.MemoryStream(, $bytes); $bmp.CacheOption = 'OnLoad'; $bmp.EndInit(); $bmp.Freeze()
    $Window.Icon = $bmp
} catch {}
$ui.VersionText.Text = "v$AppVersion"

# ---------------------------------------------------------------- tray (Zenith hides here while a game runs)
# WPF has no tray icon, so this is the WinForms one; WPF's dispatcher pumps its messages.
$script:Tray = New-Object System.Windows.Forms.NotifyIcon
$script:Tray.Text = 'Zenith'
try {
    $png = New-Object System.Drawing.Bitmap((New-Object System.IO.MemoryStream(, [Convert]::FromBase64String($IconB64))))
    $script:Tray.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap($png, 32, 32)).GetHicon())
} catch { $script:Tray.Icon = [System.Drawing.SystemIcons]::Application }
$trayMenu = New-Object System.Windows.Forms.ContextMenuStrip
$miOpen = $trayMenu.Items.Add('Open Zenith'); $miOpen.Font = New-Object System.Drawing.Font($miOpen.Font, [System.Drawing.FontStyle]::Bold)
$script:TraySession = $trayMenu.Items.Add('End game session')
[void]$trayMenu.Items.Add((New-Object System.Windows.Forms.ToolStripSeparator))
$miExit = $trayMenu.Items.Add('Exit Zenith')
$miOpen.Add_Click({ Show-FromTray })
$script:TraySession.Add_Click({ Invoke-Safe { Set-Session $false } })
$miExit.Add_Click({ Show-FromTray; $Window.Close() })   # shown first, so any "still working" question is visible
$trayMenu.Add_Opening({ $script:TraySession.Visible = $script:SessionOn })
$script:Tray.ContextMenuStrip = $trayMenu
$script:Tray.Add_MouseDoubleClick({ Show-FromTray })
$script:Tray.Add_BalloonTipClicked({ Show-FromTray })

function Hide-ToTray([string]$Tip) {
    $script:Tray.Visible = $true
    $Window.Hide()                     # hidden windows render nothing: no animations or GPU use while gaming
    if ($Tip) { $script:Tray.ShowBalloonTip(4000, 'Zenith', $Tip, [System.Windows.Forms.ToolTipIcon]::Info) }
}
function Show-FromTray {
    $Window.Show()
    if ($Window.WindowState -eq 'Minimized') { $Window.WindowState = 'Normal' }
    [void]$Window.Activate()
    $script:Tray.Visible = $false
}

# ================================================================ TOAST / DIALOGS
# Runs $Block once on the UI thread after $Ms milliseconds.
$script:Later = @{}
function Invoke-Later([int]$Ms, [scriptblock]$Block) {
    $t = New-Object System.Windows.Threading.DispatcherTimer; $t.Interval = [TimeSpan]::FromMilliseconds($Ms)
    $script:Later[$t] = $Block
    $t.Add_Tick({ param($s, $e) $s.Stop(); $b = $script:Later[$s]; $script:Later.Remove($s); Invoke-Safe $b })
    $t.Start()
}

$script:ToastTimer = New-Object System.Windows.Threading.DispatcherTimer
$script:ToastTimer.Interval = [TimeSpan]::FromSeconds(3.8)
$script:ToastTimer.Add_Tick({
    $script:ToastTimer.Stop()
    Start-Anim $ui.Toast ([System.Windows.UIElement]::OpacityProperty) $null 0 260
})
function Show-Toast([string]$Text, [string]$Kind = 'ok') {
    switch ($Kind) {
        'ok'   { $ui.ToastIcon.Text = [string][char]0xE73E; $ui.ToastIcon.Foreground = Brush '#22C55E' }
        'info' { $ui.ToastIcon.Text = [string][char]0xE946; $ui.ToastIcon.Foreground = Brush '#67E8F9' }
        'warn' { $ui.ToastIcon.Text = [string][char]0xE7BA; $ui.ToastIcon.Foreground = Brush '#F5A524' }
        'err'  { $ui.ToastIcon.Text = [string][char]0xE783; $ui.ToastIcon.Foreground = Brush '#EF4444' }
    }
    $ui.ToastText.Text = $Text
    Start-Anim $ui.Toast ([System.Windows.UIElement]::OpacityProperty) $null 1 150
    Start-Anim $ui.ToastT ([System.Windows.Media.TranslateTransform]::YProperty) 16 0 240
    $script:ToastTimer.Stop(); $script:ToastTimer.Start()
}

function Ask([string]$Text, [string]$Icon = 'Question') {
    ([System.Windows.MessageBox]::Show($Window, $Text, 'Zenith', 'YesNo', $Icon) -eq 'Yes')
}

function Invoke-Safe([scriptblock]$Block) {
    try { & $Block }
    catch {
        Write-Log "ERROR: $($_.Exception.Message) @ $($_.InvocationInfo.ScriptLineNumber)"
        Show-Toast "Something went wrong: $($_.Exception.Message)" 'err'
    }
}

# ================================================================ JOB QUEUE
# The UI never touches the system itself: it queues jobs for the background worker and refreshes
# from their results, so the window stays responsive and manual toggles stack up in order.
$script:Sync    = Start-Worker ([IO.File]::ReadAllText($PSCommandPath))
$script:Pending = @{}        # tweak id -> 'apply' / 'revert' while queued or running
$script:QueueTotal = 0; $script:QueueDone = 0; $script:QueuePct = -1
$script:LastCurrent = $null; $script:BulkToast = $null; $script:RestorePointQueued = $false
$script:CloseWhenIdle = $false; $script:Closing = $false
$script:Boot = [System.Diagnostics.Stopwatch]::StartNew()

function Add-Job([hashtable]$Job) { $script:Sync.Jobs.Add($Job); $script:QueueTotal++; Update-QueueBar }

function Add-TweakJob($t, [string]$Kind, [switch]$Quiet) {
    if ($Kind -eq 'apply') { Confirm-RestorePoint }
    $script:Pending[$t.Id] = $Kind
    Add-Job @{ Kind = $Kind; Id = $t.Id; Quiet = [bool]$Quiet }
    Update-Card $t
}

function Confirm-RestorePoint {
    if ($script:Settings.AutoRestorePoint -and -not $script:RestorePointQueued) { $script:RestorePointQueued = $true; Add-Job @{ Kind = 'restore' } }
}

function Get-JobLabel($Job) {
    if (-not $Job) { return 'Working...' }
    switch ($Job.Kind) {
        'apply'   { "Applying  $((Get-Tweak $Job.Id).Name)" }
        'revert'  { "Reverting  $((Get-Tweak $Job.Id).Name)" }
        'restore' { 'Creating a restore point - can take a minute' }
        'clean'   { $Job.Label }
        'states'  { 'Re-checking optimizations' }
        'explorer' { 'Restarting Explorer' }
        'startup'  { 'Updating startup apps' }
        'games'    { if ($Job.Detect) { 'Looking for installed games' } else { 'Updating your games' } }
        'session'  { if ($Job.On) { 'Starting game session' } else { 'Ending game session' } }
        { $_ -in 'net', 'fps' } { if ($script:Sync.Status) { $script:Sync.Status } elseif ($Job.Kind -eq 'net') { 'Network test' } else { 'FPS test' } }
        default   { 'Scanning your PC' }
    }
}

function Update-QueueBar {
    if ($script:QueueDone -ge $script:QueueTotal) {
        $ui.QueueBar.Visibility = 'Collapsed'; $script:QueueTotal = 0; $script:QueueDone = 0; $script:QueuePct = -1
        $ui.QueueProgress.BeginAnimation([System.Windows.Controls.ProgressBar]::ValueProperty, $null); $ui.QueueProgress.Value = 0
        return
    }
    $ui.QueueBar.Visibility = 'Visible'
    $waiting = $script:QueueTotal - $script:QueueDone - 1
    $ui.QueueText.Text = (Get-JobLabel $script:Sync.Current) + $(if ($waiting -gt 0) { "   +$waiting queued" } else { '' })
    $pct = [math]::Round(100.0 * $script:QueueDone / $script:QueueTotal)
    if ($pct -ne $script:QueuePct) { $script:QueuePct = $pct; Start-Anim $ui.QueueProgress ([System.Windows.Controls.ProgressBar]::ValueProperty) $null $pct 300 }
}

function Complete-Job($r) {
    $job = $r.Job; $script:QueueDone++
    if ($job.Id) { $script:Pending.Remove($job.Id) }
    $script:Backup = @{}; foreach ($k in @($r.BackupIds)) { $script:Backup[$k] = $true }
    foreach ($k in @($r.States.Keys)) { $script:State[$k] = $r.States[$k]; $x = Get-Tweak $k; if ($x) { Update-Card $x } }
    if ($r.Error) { Show-Toast "Something went wrong: $($r.Error)" 'err' }
    switch ($job.Kind) {
        'scan'    { Complete-Startup $r.Data }
        'rescan'  { $script:SysInfo = $r.Data; Show-ScanResults; Show-StartupApps; Show-Parts; Show-Toast 'Scan complete.' }
        'startup' {
            if ($r.Data) { $script:SysInfo.StartupApps = @($r.Data); $script:SysInfo.StartupCount = @($r.Data | Where-Object { $_.Enabled }).Count }
            Show-StartupApps
            if (-not $r.Error) { Show-Toast "$($job.Name) $(if ($job.Enable) { 'will start with Windows again' } else { 'no longer starts with Windows' })." }
        }
        'games'   {
            $d = $r.Data; if ($d) { Show-Games $d.List }
            $added = @($d.Added)
            if ($job.Detect) {
                Show-Toast $(if ($added.Count) { "Found $($d.Found) games - added $($added.Count) new: $(($added | Select-Object -First 4) -join ', ')$(if ($added.Count -gt 4) { ', ...' })." } else { "Found $($d.Found) games - all already in your list." })
            } elseif ($added.Count) { Show-Toast "$($added[0]) added - High priority$(if ($job.Add[0].Path) { ' and dedicated GPU' })." }
            elseif (@($job.Remove).Count -and -not $r.Error) { Show-Toast "$(@($job.Remove)[0]) removed - priority and GPU setting restored." 'info' }
        }
        'session' {
            $script:SessionBusy = $false
            if (-not $r.Error) { $script:SessionOn = [bool]$job.On }
            $d = $r.Data
            if ($job.On -and $d -and -not $r.Error) {
                $parts = @(); if (@($d.Closed).Count) { $parts += "closed $(@($d.Closed) -join ', ')" }
                if (@($d.Services).Count) { $parts += 'paused Windows Update' }; if ($d.Focus) { $parts += 'Do Not Disturb on' }
                $txt = 'Session on' + $(if ($job.Why) { " ($($job.Why))" } else { '' }) + ': ' + $(if ($parts) { $parts -join ', ' } else { 'nothing needed closing' }) + '.'
                Update-SessionCard $txt; Show-Toast $txt
            } elseif (-not $job.On -and -not $r.Error) { Update-SessionCard; Show-Toast 'Game session ended - apps, updates and notifications are back to normal.' 'info' }
            else { Update-SessionCard }
        }
        'net'     { if ($r.Data) { Show-NetResults $r.Data } }
        'fps'     { Show-FpsResults; if ($r.Data) { Show-Toast "FPS test done: $($r.Data.Avg) average FPS, $($r.Data.Low1) 1% low." } }
        'restore' {
            if (-not $r.Data) { Show-Toast 'Restore point could not be created (System Protection may be off). Zenith''s own backup is still active.' 'warn' }
            elseif ($job.Manual) { Show-Toast 'Restore point created.' }
            if ($job.Manual) { Show-Log }
        }
        'explorer' { Show-Toast 'Explorer restarted.' }
        'clean'   { Write-Log "$($job.Label): freed $($r.Data) bytes"; Show-Toast ($job.Done -f (Format-Bytes ([double]$r.Data))) }
        { $_ -eq 'apply' -or $_ -eq 'revert' } {
            $t = Get-Tweak $job.Id; $on = ($script:State[$t.Id] -eq 'On')
            if ($job.Kind -eq 'revert' -or $on) { Set-RebootFlag $t }
            if ($job.Quiet -or $r.Error) { break }
            if ($job.Kind -eq 'revert') { Show-Toast "$($t.Name) reverted." 'info' }
            elseif ($on) {
                $extra = if (@($t.Tags) -contains 'Reboot') { ' Restart to finish.' } elseif (@($t.Tags) -contains 'Sign-out') { ' Sign out or restart to see it.' } else { '' }
                Show-Toast "$($t.Name) enabled.$extra"
            } else { Show-Toast "$($t.Name) could not be fully applied - see the log in Backups." 'warn' }
        }
    }
}

$script:QueueTimer = New-Object System.Windows.Threading.DispatcherTimer
$script:QueueTimer.Interval = [TimeSpan]::FromMilliseconds(80)
$script:QueueTimer.Add_Tick({
    $r = $null; $any = $false
    while ($script:Sync.Results.TryDequeue([ref]$r)) { $any = $true; Invoke-Safe { Complete-Job $r } }
    # The card of the job that just started switches from "Queued" to "Applying...".
    $cur = $script:Sync.Current; $curId = if ($cur) { $cur.Id } else { $null }
    if ($curId -ne $script:LastCurrent) {
        foreach ($id in @($script:LastCurrent, $curId)) { if ($id) { Update-Card (Get-Tweak $id) } }
        $script:LastCurrent = $curId
    }
    if ($any -and $script:Cards.Count) { Update-ChipCounts; Update-Filter; Update-Dashboard; Update-BackupInfo }
    if ($ui.Splash.Visibility -eq 'Visible' -and $script:Sync.Status) { $ui.SplashStatus.Text = $script:Sync.Status }
    Update-QueueBar
    if ($script:QueueDone -ge $script:QueueTotal) {
        if ($script:BulkToast) { Show-Toast $script:BulkToast[0] $script:BulkToast[1]; $script:BulkToast = $null }
        if ($script:CloseWhenIdle) { $script:QueueTimer.Stop(); $Window.Close() }
    }
    if ($script:Sync.Handle.IsCompleted -and -not $script:Closing) {
        $script:Closing = $true; $script:QueueTimer.Stop()
        $err = "$(@($script:Sync.PS.Streams.Error)[0])"
        try { [void]$script:Sync.PS.EndInvoke($script:Sync.Handle) } catch { $err += " $($_.Exception.Message)" }
        Write-Log "Background worker stopped: $err"
        [System.Windows.MessageBox]::Show($Window, "Zenith's background worker stopped unexpectedly, so Zenith has to close.`n`n$err", 'Zenith', 'OK', 'Error') | Out-Null
        $Window.Close()
    }
})

function Complete-Startup($info) {
    $script:SysInfo = $info
    Set-AdaptiveRecommendations
    Build-TweakCards; Build-BoostPage; Show-Games; Show-ScanResults
    # Extra panels each get their own error guard, so one failing panel can never keep the splash up.
    foreach ($fill in 'Show-StartupApps', 'Show-Parts', 'Show-FpsResults', 'Update-PresentMonStatus') { Invoke-Safe { [void](& $fill) } }
    $script:SessionOn = [bool]$info.SessionOn; $ui.SetAutoSession.IsChecked = [bool]$script:Settings.AutoSession
    Update-SessionCard $(if ($script:SessionOn) { 'A game session is still on from last time - press End session to restore apps, updates and notifications.' } else { '' })
    Update-AllStates; Update-BackupInfo
    $script:StatsTimer.Start()
    Write-Log ("Scan: {0} | {1} | {2} | system drive {3}" -f $info.CpuName, $info.GpuName, $info.RamTotal, $info.SystemDiskType)
    # Let the intro animation play out before revealing the app.
    Invoke-Later ([math]::Max(0, 2300 - $script:Boot.ElapsedMilliseconds)) { Hide-Splash }
}

function Hide-Splash {
    Start-Anim $ui.Splash ([System.Windows.UIElement]::OpacityProperty) 1 0 380
    Start-Anim $ui.SplashScale ([System.Windows.Media.ScaleTransform]::ScaleXProperty) 1 1.06 420
    Start-Anim $ui.SplashScale ([System.Windows.Media.ScaleTransform]::ScaleYProperty) 1 1.06 420
    Invoke-Later 390 {
        $ui.Splash.Visibility = 'Collapsed'
        Show-Page 'PageDashboard'
        $script:ScoreShown = 0.0; Start-ScoreAnim    # the score ring fills in as the dashboard appears
    }
}

# ================================================================ TWEAK CARDS
$CardXaml = @'
<Border %NS% CornerRadius="12" Background="#0A0810" BorderBrush="#1C1530" BorderThickness="1" Margin="0,0,14,14" Padding="20,18,20,14" Height="244">
  <Border.Triggers>
    <EventTrigger RoutedEvent="Mouse.MouseEnter"><BeginStoryboard><Storyboard>
      <DoubleAnimation Storyboard.TargetName="Hl" Storyboard.TargetProperty="Opacity" To="1" Duration="0:0:0.14"/>
    </Storyboard></BeginStoryboard></EventTrigger>
    <EventTrigger RoutedEvent="Mouse.MouseLeave"><BeginStoryboard><Storyboard>
      <DoubleAnimation Storyboard.TargetName="Hl" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.25"/>
    </Storyboard></BeginStoryboard></EventTrigger>
  </Border.Triggers>
  <Grid>
    <Grid.RowDefinitions>
      <RowDefinition Height="Auto"/><RowDefinition Height="Auto"/><RowDefinition Height="*"/><RowDefinition Height="Auto"/><RowDefinition Height="Auto"/>
    </Grid.RowDefinitions>
    <Grid>
      <StackPanel Orientation="Horizontal">
        <Border CornerRadius="5" Background="#160F24" Padding="8,3"><TextBlock x:Name="Cat" Foreground="#B9B2CF" FontSize="11.5"/></Border>
        <Border CornerRadius="5" BorderBrush="#2B2142" BorderThickness="1" Padding="7,2" Margin="6,0,0,0" VerticalAlignment="Center">
          <TextBlock x:Name="Kind" Foreground="#7A7393" FontSize="10" FontWeight="SemiBold"/>
        </Border>
      </StackPanel>
      <TextBlock x:Name="Info" Text="&#xE946;" FontFamily="Segoe Fluent Icons, Segoe MDL2 Assets" Foreground="#5E5679" FontSize="15"
                 HorizontalAlignment="Right" VerticalAlignment="Center" Cursor="Help" ToolTipService.ShowDuration="60000" ToolTipService.InitialShowDelay="150"/>
    </Grid>
    <TextBlock x:Name="Title" Grid.Row="1" FontSize="16" FontWeight="SemiBold" Foreground="#F3F1F8" Margin="0,12,0,6" TextTrimming="CharacterEllipsis"/>
    <TextBlock x:Name="Desc" Grid.Row="2" TextWrapping="Wrap" TextTrimming="WordEllipsis" Foreground="#918AA8" FontSize="12.5" LineHeight="18"/>
    <WrapPanel x:Name="Tags" Grid.Row="3" Margin="0,8,0,0" Height="18" ClipToBounds="True"/>
    <Border Grid.Row="4" BorderBrush="#1C1530" BorderThickness="0,1,0,0" Margin="-20,10,-20,0" Padding="20,10,20,0">
      <Grid>
        <TextBlock x:Name="Impact" FontSize="11.5" VerticalAlignment="Center"/>
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
          <TextBlock x:Name="Status" Foreground="#918AA8" FontSize="12" VerticalAlignment="Center" Margin="0,0,10,0"/>
          <ToggleButton x:Name="Toggle" Style="{DynamicResource Switch}"/>
        </StackPanel>
      </Grid>
    </Border>
    <!-- hover highlight: purple edge + faint tint, faded in by the triggers above -->
    <Border x:Name="Hl" Grid.RowSpan="5" Margin="-21,-19,-21,-15" CornerRadius="12" BorderThickness="1" Opacity="0" IsHitTestVisible="False">
      <Border.BorderBrush>
        <LinearGradientBrush StartPoint="0,0" EndPoint="1,1"><GradientStop Color="#C084FC" Offset="0"/><GradientStop Color="#4A2E78" Offset="0.5"/><GradientStop Color="#7C3AED" Offset="1"/></LinearGradientBrush>
      </Border.BorderBrush>
      <Border.Background>
        <LinearGradientBrush StartPoint="0,0" EndPoint="1,1"><GradientStop Color="#14A855F7" Offset="0"/><GradientStop Color="#00A855F7" Offset="0.6"/></LinearGradientBrush>
      </Border.Background>
    </Border>
  </Grid>
</Border>
'@

$TagDefs = @{
    'Recommended'      = @{ G = 0xE734; C = '#A855F7' }
    'Power Hungry'     = @{ G = 0xE945; C = '#34D399' }
    'Feature Breaking' = @{ G = 0xE7BA; C = '#F5A524' }
    'Security Risk'    = @{ G = 0xE72E; C = '#F87171' }
    'Not Reversible'   = @{ G = 0xE74D; C = '#F87171' }
    'Reboot'           = @{ G = 0xE72C; C = '#67E8F9' }
    'Sign-out'         = @{ G = 0xE72C; C = '#67E8F9' }
    'HDD'              = @{ G = 0xEDA2; C = '#F0ABFC' }
    'SSD'              = @{ G = 0xEDA2; C = '#F0ABFC' }
    'Win11'            = @{ G = 0xE770; C = '#F0ABFC' }
}
function New-TagEl([string]$Name) {
    $d = $TagDefs[$Name]; if (-not $d) { $d = @{ G = 0xE946; C = '#918AA8' } }
    $sp = New-Object System.Windows.Controls.StackPanel; $sp.Orientation = 'Horizontal'; $sp.Margin = '0,0,12,0'
    $g = New-Object System.Windows.Controls.TextBlock; $g.Text = [string][char]$d.G; $g.FontFamily = $IconFont; $g.FontSize = 11; $g.Foreground = Brush $d.C; $g.VerticalAlignment = 'Center'
    $t = New-Object System.Windows.Controls.TextBlock; $t.Text = $Name; $t.FontSize = 11.5; $t.Foreground = Brush $d.C; $t.Margin = '5,0,0,0'; $t.VerticalAlignment = 'Center'
    [void]$sp.Children.Add($g); [void]$sp.Children.Add($t)
    return $sp
}

$script:Cards = @{}
$script:Filter = 'All'
$ImpactW = @{ High = 3; Medium = 2; Low = 1 }

function New-TweakCard($t) {
    $card = New-El $CardXaml
    $card.FindName('Cat').Text   = $t.Cat
    $card.FindName('Kind').Text  = $t.Kind
    $card.FindName('Title').Text = $t.Name
    $card.FindName('Title').ToolTip = $t.Name
    $card.FindName('Desc').Text  = $t.Desc
    $tip = New-Object System.Windows.Controls.TextBlock
    $tip.Text = "What this changes:`n`n" + (Get-TweakChangeText $t); $tip.FontFamily = 'Consolas'; $tip.FontSize = 11.5; $tip.MaxWidth = 720; $tip.TextWrapping = 'Wrap'
    $card.FindName('Info').ToolTip = $tip
    $desc = New-Object System.Windows.Controls.TextBlock; $desc.Text = $t.Desc; $desc.MaxWidth = 420; $desc.TextWrapping = 'Wrap'
    $card.FindName('Desc').ToolTip = $desc
    $tags = $card.FindName('Tags')
    $list = @(); if ($t.Rec) { $list += 'Recommended' }; $list += @($t.Tags)
    foreach ($tg in ($list | Select-Object -First 3)) { [void]$tags.Children.Add((New-TagEl $tg)) }
    $imp = $card.FindName('Impact')
    switch ($t.Impact) {
        'High'   { $imp.Text = [string][char]0x25CF + [char]0x25CF + [char]0x25CF + '  High impact';   $imp.Foreground = Brush '#22C55E' }
        'Medium' { $imp.Text = [string][char]0x25CF + [char]0x25CF + [char]0x25CB + '  Medium impact'; $imp.Foreground = Brush '#9BD15A' }
        default  { $imp.Text = [string][char]0x25CF + [char]0x25CB + [char]0x25CB + '  Low impact';    $imp.Foreground = Brush '#756E8D' }
    }
    $toggle = $card.FindName('Toggle')
    $toggle.Tag = $t.Id
    $toggle.Add_Click({ param($s, $e) Invoke-Safe { Invoke-TweakToggle $s } })
    $script:Cards[$t.Id] = @{ Card = $card; Toggle = $toggle; Status = $card.FindName('Status') }
    return $card
}

function Update-Card($t) {
    if (-not $t) { return }
    $c = $script:Cards[$t.Id]; if (-not $c) { return }
    $p = $script:Pending[$t.Id]
    if ($p) {
        # queued or running in the background: show where it is going, lock the switch until done
        $busy = $script:Sync.Current -and $script:Sync.Current.Id -eq $t.Id
        $c.Toggle.IsChecked = ($p -eq 'apply'); $c.Toggle.IsEnabled = $false; $c.Card.Opacity = 1
        $c.Status.Text = if (-not $busy) { 'Queued' } elseif ($p -eq 'apply') { 'Applying...' } else { 'Reverting...' }
        $c.Status.Foreground = Brush '#F5A524'
        return
    }
    $st = $script:State[$t.Id]
    $c.Toggle.IsChecked = ($st -eq 'On')
    $c.Toggle.IsEnabled = ($st -ne 'NA') -and -not ($t.Appx -and $st -eq 'On')
    switch ($st) {
        'On'    { $c.Status.Text = if ($t.Appx) { 'Removed' } else { 'Active' }; $c.Status.Foreground = Brush '#67E8F9'; $c.Card.Opacity = 1 }
        'NA'    { $c.Status.Text = 'Not needed on this PC'; $c.Status.Foreground = Brush '#5E5679'; $c.Card.Opacity = 0.6 }
        default { $c.Status.Text = 'Activate'; $c.Status.Foreground = Brush '#918AA8'; $c.Card.Opacity = 1 }
    }
}

function Build-TweakCards {
    $ui.TweakGrid.Children.Clear()
    foreach ($t in $script:Tweaks) { [void]$ui.TweakGrid.Children.Add((New-TweakCard $t)) }

    $script:Chips = @{}
    $ui.ChipPanel.Children.Clear()
    $defs = @('All', 'Recommended', 'Active', 'FPS & Latency', 'GPU & Display', 'Power & CPU', 'Registry', 'Memory & Storage', 'Network & Ping', 'Debloat', 'Privacy', 'Quality of Life', 'Advanced')
    foreach ($d in $defs) {
        $rb = New-Object System.Windows.Controls.RadioButton
        $rb.Style = $Window.FindResource('Chip'); $rb.Tag = $d; $rb.Content = $d
        if ($d -eq 'All') { $rb.IsChecked = $true }
        $rb.Add_Checked({ param($s, $e) $script:Filter = [string]$s.Tag; Update-Filter; $ui.TweakScroll.ScrollToTop() })
        [void]$ui.ChipPanel.Children.Add($rb)
        $script:Chips[$d] = $rb
    }
}

function Test-Visible($t) {
    if ($t.Only -and -not (Test-OnlyOk $t)) { return $false }
    if ($t.Cat -eq 'Advanced' -and -not $script:Settings.ShowAdvanced) { return $false }
    return $true
}

function Update-Filter {
    $q = "$($ui.SearchBox.Text)".Trim()
    foreach ($t in $script:Tweaks) {
        $c = $script:Cards[$t.Id]; if (-not $c) { continue }
        $vis = Test-Visible $t
        if ($vis) {
            switch ($script:Filter) {
                'All'         { }
                'Recommended' { $vis = [bool]$t.Rec }
                'Active'      { $vis = ($script:State[$t.Id] -eq 'On') }
                default       { $vis = ($t.Cat -eq $script:Filter) }
            }
        }
        if ($vis -and $q) { $vis = ($t.Name -like "*$q*") -or ($t.Desc -like "*$q*") -or ($t.Cat -like "*$q*") -or ($t.Kind -like "*$q*") }
        $c.Card.Visibility = if ($vis) { 'Visible' } else { 'Collapsed' }
    }
}

function Update-ChipCounts {
    $vis = @($script:Tweaks | Where-Object { Test-Visible $_ })
    foreach ($k in $script:Chips.Keys) {
        $n = switch ($k) {
            'All'         { $vis.Count }
            'Recommended' { @($vis | Where-Object { $_.Rec }).Count }
            'Active'      { @($vis | Where-Object { $script:State[$_.Id] -eq 'On' }).Count }
            default       { @($vis | Where-Object { $_.Cat -eq $k }).Count }
        }
        $script:Chips[$k].Content = "$k  $([char]0x00B7)  $n"
        $script:Chips[$k].Visibility = if ($n -eq 0 -and $k -ne 'Active') { 'Collapsed' } else { 'Visible' }
    }
}

# Refreshes every card from $script:State (the worker does the actual checking).
function Update-AllStates {
    foreach ($t in $script:Tweaks) { Update-Card $t }
    Update-ChipCounts
    Update-Filter
    Update-Dashboard
}

$script:NeedReboot = $false
function Set-RebootFlag($t) {
    if (@($t.Tags) -contains 'Reboot') { $script:NeedReboot = $true; $ui.RebootBanner.Visibility = 'Visible' }
}

function Test-ShouldConfirm($t) {
    if (-not $script:Settings.ConfirmRisky) { return $false }
    return ($t.Risk -eq 'Risky' -or $t.Risk -eq 'Moderate' -or (@($t.Tags) | Where-Object { $_ -in 'Feature Breaking', 'Security Risk', 'Not Reversible' }))
}

function Invoke-TweakToggle($tg) {
    $t = Get-Tweak ([string]$tg.Tag)
    if (-not $t -or $script:Pending[$t.Id]) { return }
    $want = [bool]$tg.IsChecked
    if ($want) {
        if (Test-ShouldConfirm $t) {
            $warn = @()
            if (@($t.Tags) -contains 'Security Risk') { $warn += 'SECURITY TRADE-OFF: this lowers protection against some attacks.' }
            if (@($t.Tags) -contains 'Feature Breaking') { $warn += 'This turns off a Windows feature you may use.' }
            if (@($t.Tags) -contains 'Not Reversible') { $warn += 'Removed apps can only be restored by reinstalling them from the Microsoft Store.' }
            if ($t.Risk -eq 'Moderate') { $warn += 'This is an advanced tweak - test your games afterwards and revert if anything feels worse.' }
            if (-not (Ask ("Enable '$($t.Name)'?`n`n$($t.Desc)`n`n" + ($warn -join "`n")) 'Warning')) { $tg.IsChecked = $false; return }
        }
        Add-TweakJob $t 'apply'
    } else {
        if ($t.Appx) {
            [System.Windows.MessageBox]::Show($Window, "These apps were uninstalled. To get any of them back, open the Microsoft Store and install it again.", 'Zenith', 'OK', 'Information') | Out-Null
            $tg.IsChecked = $true; return
        }
        Add-TweakJob $t 'revert'
    }
    Update-Dashboard    # the result toast and card refresh come from Complete-Job
}

function Invoke-ApplyRecommended {
    $list = @($script:Tweaks | Where-Object { $_.Rec -and $_.Risk -ne 'Risky' -and $script:State[$_.Id] -eq 'Off' -and -not $script:Pending[$_.Id] -and (Test-Visible $_) })
    if ($list.Count -eq 0) { Show-Toast 'All recommended optimizations are already active or queued.'; return }
    $fb = @($list | Where-Object { @($_.Tags) -contains 'Feature Breaking' -or @($_.Tags) -contains 'Not Reversible' } | ForEach-Object { "  - $($_.Name)" })
    $msg = "Apply $($list.Count) recommended optimizations for this PC?"
    if ($fb.Count) { $msg += "`n`nThese ones remove or turn off Windows features:`n" + ($fb -join "`n") + "`n`n(You can still toggle any of them back afterwards, except removed apps.)" }
    $msg += "`n`nRisky security tweaks are never included."
    if (-not (Ask $msg)) { return }
    foreach ($t in $list) { Add-TweakJob $t 'apply' -Quiet }
    Add-Job @{ Kind = 'states' }    # some tweaks change how others read (e.g. the power plan), so re-check all at the end
    $script:BulkToast = @("$($list.Count) optimizations applied. Restart your PC to get the full effect.", 'ok')
    Update-Dashboard
    Show-Toast "$($list.Count) optimizations queued - they apply in the background." 'info'
}

function Invoke-RevertAll {
    $ids = @($script:Backup.Keys)
    $list = @($script:Tweaks | Where-Object { $ids -contains $_.Id -and -not $_.Appx -and -not $script:Pending[$_.Id] })
    [array]::Reverse($list)
    if ($list.Count -eq 0) { Show-Toast 'Nothing to revert - Zenith has no active changes.' 'info'; return }
    if (-not (Ask "Revert all $($list.Count) Zenith tweaks and restore your original Windows settings?`n`n(Removed Store apps are not reinstalled automatically.)" 'Warning')) { return }
    foreach ($t in $list) { Add-TweakJob $t 'revert' -Quiet }
    Add-Job @{ Kind = 'states' }
    $script:BulkToast = @('All tweaks reverted. Restart your PC to complete.', 'info')
    Update-Dashboard
    Show-Toast "$($list.Count) reverts queued - they run in the background." 'info'
}

# ================================================================ DASHBOARD
$RecRowXaml = @'
<Border %NS% CornerRadius="10" Background="#0F0B16" Padding="16,12" Margin="0,0,0,8">
  <Grid>
    <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="Auto"/></Grid.ColumnDefinitions>
    <StackPanel Margin="0,0,16,0">
      <StackPanel Orientation="Horizontal">
        <TextBlock x:Name="Name" FontSize="14" FontWeight="SemiBold" Foreground="#F3F1F8"/>
        <TextBlock x:Name="Gain" FontSize="12" Foreground="#A855F7" Margin="10,1,0,0" VerticalAlignment="Center"/>
      </StackPanel>
      <TextBlock x:Name="Desc" FontSize="12" Foreground="#8B84A3" TextTrimming="CharacterEllipsis" Margin="0,4,0,0"/>
    </StackPanel>
    <ToggleButton x:Name="Toggle" Grid.Column="1" Style="{DynamicResource Switch}" VerticalAlignment="Center"/>
  </Grid>
</Border>
'@

function Get-Score {
    $tot = 0; $got = 0
    foreach ($t in $script:Tweaks) {
        if (-not $t.Rec -or $t.Risk -eq 'Risky' -or -not (Test-Visible $t)) { continue }
        $st = $script:State[$t.Id]; if ($st -eq 'NA' -or -not $st) { continue }
        $w = $ImpactW[$t.Impact]; $tot += $w; if ($st -eq 'On') { $got += $w }
    }
    if ($tot -eq 0) { return @{ Score = 100; Total = 1 } }
    return @{ Score = [math]::Round(100 * $got / $tot); Total = $tot }
}

$script:ScoreShown = 0.0; $script:ScoreTarget = 0.0
function Set-Arc([double]$Pct) {
    if ($Pct -le 0.3) { $ui.ScoreArc.Data = $null; return }
    $Pct = [math]::Min($Pct, 99.9)
    $r = 78.0; $cx = 85.0; $cy = 85.0
    $ang = 360.0 * $Pct / 100.0; $rad = ($ang - 90.0) * [math]::PI / 180.0
    $x = $cx + $r * [math]::Cos($rad); $y = $cy + $r * [math]::Sin($rad)
    $large = if ($ang -gt 180) { 1 } else { 0 }
    $d = [string]::Format([Globalization.CultureInfo]::InvariantCulture, 'M {0},{1} A {2},{2} 0 {3} 1 {4:0.###},{5:0.###}', $cx, ($cy - $r), $r, $large, $x, $y)
    $ui.ScoreArc.Data = [System.Windows.Media.Geometry]::Parse($d)
}
# Score ring easing, stepped once per rendered frame (vsync) and by elapsed time, so it is equally
# smooth at 60 or 240 Hz; it unhooks itself when it arrives.
$script:ScoreRunning = $false
$script:ScoreClock = New-Object System.Diagnostics.Stopwatch
$script:ScoreFrame = [EventHandler]{
    $dt = [math]::Min(0.1, $script:ScoreClock.Elapsed.TotalSeconds); $script:ScoreClock.Restart()
    $diff = $script:ScoreTarget - $script:ScoreShown
    if ([math]::Abs($diff) -lt 0.2) {
        $script:ScoreShown = $script:ScoreTarget; $script:ScoreRunning = $false
        [System.Windows.Media.CompositionTarget]::remove_Rendering($script:ScoreFrame)
    } else { $script:ScoreShown += $diff * (1 - [math]::Exp(-9 * $dt)) }
    Set-Arc $script:ScoreShown
    $ui.ScoreText.Text = ('{0:0}%' -f $script:ScoreShown)
}
function Start-ScoreAnim {
    if ($script:ScoreRunning) { return }
    $script:ScoreRunning = $true; $script:ScoreClock.Restart()
    [System.Windows.Media.CompositionTarget]::add_Rendering($script:ScoreFrame)
}

function Update-Dashboard {
    $sc = Get-Score
    $script:ScoreTarget = [double]$sc.Score
    Start-ScoreAnim
    $left = @($script:Tweaks | Where-Object { $_.Rec -and $_.Risk -ne 'Risky' -and $script:State[$_.Id] -eq 'Off' -and -not $script:Pending[$_.Id] -and (Test-Visible $_) })
    $active = @($script:Tweaks | Where-Object { $script:State[$_.Id] -eq 'On' -and (Test-Visible $_) })
    $ui.HeroCount.Text = "$($left.Count)"
    if ($sc.Score -ge 97) { $ui.HeroTitle.Text = 'Fully optimized. Nice.'; $ui.HeroSub.Text = 'Every recommended optimization for this PC is active. Check Boost Up for the GPU settings that still matter.' }
    elseif ($sc.Score -ge 70) { $ui.HeroTitle.Text = 'Almost there. Enhance your PC to the max'; $ui.HeroSub.Text = 'A few more recommended tweaks are waiting - each one removes overhead or latency.' }
    else { $ui.HeroTitle.Text = 'Your PC could run smoother'; $ui.HeroSub.Text = "Windows is running with default settings that waste CPU time and add latency." }
    $ui.StatActive.Text = "$($active.Count)"
    $ui.StatLeft.Text   = "$($left.Count)"
    $ui.StatTotal.Text  = "$(@($script:Tweaks | Where-Object { Test-Visible $_ }).Count)"
    $ui.BtnApplyAllRec.Content = if ($left.Count) { "Apply all $($left.Count) recommendations" } else { 'All recommendations applied' }
    $ui.BtnApplyAllRec.IsEnabled = ($left.Count -gt 0)
    $ui.BtnApplyRec.IsEnabled = ($left.Count -gt 0)
    $ui.BtnTweaksApplyRec.IsEnabled = ($left.Count -gt 0)
    $ui.TweakSummary.Text = "$(@($script:Tweaks | Where-Object { Test-Visible $_ }).Count) optimizations  $([char]0x00B7)  $($active.Count) active  $([char]0x00B7)  $($left.Count) recommended left  $([char]0x00B7)  hover the (i) icon on a card to see exactly what it changes"

    $ui.RecList.Children.Clear()
    $top = $left | Sort-Object @{ Expression = { $ImpactW[$_.Impact] }; Descending = $true } | Select-Object -First 6
    if (-not $top) {
        $tb = New-Object System.Windows.Controls.TextBlock; $tb.Text = 'Nothing left - every recommended optimization is active.'; $tb.Foreground = Brush '#8B84A3'; $tb.Margin = '0,0,0,8'
        [void]$ui.RecList.Children.Add($tb)
    }
    foreach ($t in $top) {
        $row = New-El $RecRowXaml
        $row.FindName('Name').Text = $t.Name
        $row.FindName('Gain').Text = ('+{0:0.0}% score' -f (100.0 * $ImpactW[$t.Impact] / $sc.Total))
        $row.FindName('Desc').Text = $t.Desc
        $tg = $row.FindName('Toggle'); $tg.Tag = $t.Id
        $tg.Add_Click({ param($s, $e) Invoke-Safe { Invoke-TweakToggle $s } })
        [void]$ui.RecList.Children.Add($row)
    }
}

# ================================================================ SCANNER PAGE
$SpecXaml = @'
<Border %NS% CornerRadius="12" Background="#0A0810" BorderBrush="#1C1530" BorderThickness="1" Margin="0,0,14,14" Padding="20,18">
  <StackPanel>
    <StackPanel Orientation="Horizontal">
      <Border Width="34" Height="34" CornerRadius="9" Background="#1A0F2E">
        <TextBlock x:Name="Glyph" FontFamily="Segoe Fluent Icons, Segoe MDL2 Assets" FontSize="16" Foreground="#A855F7" HorizontalAlignment="Center" VerticalAlignment="Center"/>
      </Border>
      <TextBlock x:Name="Label" Foreground="#8B84A3" FontSize="11" FontWeight="Bold" VerticalAlignment="Center" Margin="12,0,0,0"/>
    </StackPanel>
    <TextBlock x:Name="Main" FontSize="16" FontWeight="SemiBold" Foreground="#F5F3FA" Margin="0,14,0,10" TextWrapping="Wrap"/>
    <StackPanel x:Name="Rows"/>
  </StackPanel>
</Border>
'@
$HealthXaml = @'
<Border %NS% CornerRadius="10" Background="#0A0810" BorderBrush="#1C1530" BorderThickness="1" Margin="0,0,14,12" Padding="16,14">
  <Grid>
    <Grid.ColumnDefinitions><ColumnDefinition Width="Auto"/><ColumnDefinition Width="*"/></Grid.ColumnDefinitions>
    <TextBlock x:Name="Icon" FontFamily="Segoe Fluent Icons, Segoe MDL2 Assets" FontSize="16" Margin="0,2,14,0" VerticalAlignment="Top"/>
    <StackPanel Grid.Column="1">
      <TextBlock x:Name="Title" FontSize="13.5" FontWeight="SemiBold" Foreground="#F3F1F8" TextWrapping="Wrap"/>
      <TextBlock x:Name="Text" FontSize="12" Foreground="#8B84A3" TextWrapping="Wrap" Margin="0,4,0,0" LineHeight="17"/>
    </StackPanel>
  </Grid>
</Border>
'@

function Add-SpecCard([int]$Glyph, [string]$Label, [string]$Main, [object[]]$Rows) {
    $c = New-El $SpecXaml
    $c.FindName('Glyph').Text = [string][char]$Glyph
    $c.FindName('Label').Text = $Label
    $c.FindName('Main').Text = $Main
    $rp = $c.FindName('Rows')
    foreach ($r in $Rows) {
        $g = New-Object System.Windows.Controls.Grid; $g.Margin = '0,0,0,6'
        $k = New-Object System.Windows.Controls.TextBlock; $k.Text = [string]$r[0]; $k.Foreground = Brush '#7A7393'; $k.FontSize = 12.5
        $v = New-Object System.Windows.Controls.TextBlock; $v.Text = [string]$r[1]; $v.Foreground = Brush '#DCD7E8'; $v.FontSize = 12.5
        $v.HorizontalAlignment = 'Right'; $v.TextTrimming = 'CharacterEllipsis'; $v.Margin = '110,0,0,0'; $v.TextAlignment = 'Right'; $v.ToolTip = [string]$r[1]
        [void]$g.Children.Add($k); [void]$g.Children.Add($v)
        [void]$rp.Children.Add($g)
    }
    [void]$ui.ScanGrid.Children.Add($c)
}

function Show-ScanResults {
    $s = $script:SysInfo
    $ui.ScanGrid.Children.Clear()
    Add-SpecCard 0xE950 'PROCESSOR' $s.CpuName @(
        @('Cores / threads', "$($s.CpuCores) / $($s.CpuThreads)"), @('Base clock', ('{0:N2} GHz' -f ($s.CpuClock / 1000))),
        @('L3 cache', $s.CpuL3), @('Socket', $s.CpuSocket))
    Add-SpecCard 0xE7FC 'GRAPHICS' $s.GpuName @(
        @('Video memory', $s.GpuVram), @('Driver', $s.GpuDriver),
        @('Driver date', $(if ($s.GpuDriverDate) { ([datetime]$s.GpuDriverDate).ToString('yyyy-MM-dd') } else { '-' })),
        @('MSI-capable', $(if ($s.GpuInstanceId) { 'Yes' } else { '-' })))
    Add-SpecCard 0xE8F1 'MEMORY' "$($s.RamTotal) $($s.RamType)" @(
        @('Speed', $s.RamSpeed), @('Modules', "$($s.RamSticks) of $($s.RamSlots) slots"), @('Mode', $s.RamChannel), @('Manufacturer', $s.RamMaker))
    $diskRows = @(); foreach ($d in $s.Disks) { $diskRows += , @("$($d.Type)  $($d.Size)", $d.Name) }
    Add-SpecCard 0xEDA2 'STORAGE' "$($s.StorageTotal) total" ($diskRows + , @('Windows drive', "$($env:SystemDrive) on $($s.SystemDiskType)"))
    $volRows = @(); foreach ($v in $s.Volumes) { $volRows += , @("$($v.Letter) $($v.Label)", ('{0} free of {1}' -f (Format-Bytes $v.Free), (Format-Bytes $v.Size))) }
    Add-SpecCard 0xE8B7 'VOLUMES' "$(@($s.Volumes).Count) drive letter(s)" $volRows
    Add-SpecCard 0xE770 'OPERATING SYSTEM' "$($s.OsName)" @(
        @('Version', "$($s.OsVer)"), @('Build', "$($s.Build).$($s.UBR)"), @('Uptime', $s.Uptime), @('Computer', $s.Computer))
    Add-SpecCard 0xE7F4 'DISPLAY' $(if ($s.ResX) { "$($s.ResX) x $($s.ResY)" } else { 'Unknown' }) @(
        @('Refresh rate', $(if ($s.Refresh) { "$($s.Refresh) Hz" } else { '-' })), @('Output', $s.GpuName))
    Add-SpecCard 0xE9D9 'MOTHERBOARD' $s.Board @( , @('BIOS', $s.Bios) )
    Add-SpecCard 0xE945 'POWER & SECURITY' $s.PowerPlan @(
        @('Memory Integrity', $(if ($s.HvciOn) { 'On (costs FPS)' } else { 'Off' })), @('Startup apps', "$($s.StartupCount)"), @('Processes', "$($s.ProcCount)"))

    $ui.HealthList.Children.Clear()
    foreach ($h in (Get-HealthChecks)) {
        $r = New-El $HealthXaml
        $ic = $r.FindName('Icon')
        if ($h.Ok) { $ic.Text = [string][char]0xE73E; $ic.Foreground = Brush '#22C55E' } else { $ic.Text = [string][char]0xE7BA; $ic.Foreground = Brush '#F5A524' }
        $r.FindName('Title').Text = $h.Title
        $r.FindName('Text').Text = $h.Text
        [void]$ui.HealthList.Children.Add($r)
    }

    $kind = if ($s.IsLaptop) { 'laptop' } else { 'desktop' }
    $ui.ProfileText.Text = [string][char]0x2713 + "  Recommendations adapted to this $kind"
    $ui.ProfileBadge.Background = Brush '#0F2418'; $ui.ProfileBadge.BorderBrush = Brush '#1E5A35'; $ui.ProfileText.Foreground = Brush '#4ADE80'
    $ui.DashMatch.Text = [string][char]0x25CF + " Adapted to this $kind"
    $ui.TitleProfile.Text = "$($s.CpuName)  +  $($s.GpuName)"
    $ui.ScanSub.Text = "Scanned $(Get-Date -Format 'HH:mm')  $([char]0x00B7)  $($s.Computer)"

    $ui.DashCpu.Text = $s.CpuName
    $ui.DashGpu.Text = "$($s.GpuName)  $([char]0x00B7)  $($s.GpuVram)"
    $ui.DashRam.Text = "$($s.RamTotal) $($s.RamType) $($s.RamSpeed)  $([char]0x00B7)  $($s.StorageTotal) storage  $([char]0x00B7)  $($s.OsName)"
    $ui.StatProcs.Text = "$($s.ProcCount)"

    $gpuNote = "Zenith removes Windows overhead, background activity and input latency. Your graphics card ($($s.GpuName), $($s.GpuVram)) still sets the FPS ceiling in most games - in-game settings (resolution, textures, shadows) decide how close you get to it."
    if ($s.XmpOff) { $gpuNote += "`n`nYour RAM is at its stock $($s.RamSpeed) - enabling XMP/EXPO in the BIOS is likely the biggest free gain on this PC (see the Health check)." }
    if ($s.SystemIsHDD) { $gpuNote += "`n`nWindows is on a hard drive: moving Windows and your most-played games to an SSD will cut loading stutter more than any tweak." }
    $ui.InsightText.Text = $gpuNote
}

function Set-AdaptiveRecommendations {
    $s = $script:SysInfo
    $t = Get-Tweak 'mem_sysmain'
    if ($s.SystemIsSSD) { $t.Rec = $true; $t.Desc += ' Detected: Windows is on an SSD - recommended.' }
    elseif ($s.SystemIsHDD) { $t.Rec = $false; $t.Desc += ' Detected: Windows is on a hard drive - keep SysMain ON.' }
    $t = Get-Tweak 'pwr_diskidle'
    if (-not (@($s.Disks) | Where-Object { $_.Type -eq 'HDD' })) { $t.Rec = $false; $t.Desc = 'Prevents Windows from spinning down hard drives. No hard drive was detected in this PC, so this is optional.' }
    $t = Get-Tweak 'mem_compression'
    if ($s.RamBytes -lt 15GB) { $t.Rec = $false }
    $t = Get-Tweak 'adv_vbs'
    if (-not $s.HvciOn) { $t.Desc += ' (Currently not running on this PC.)' }

    # Still available on the Optimizations page, just not part of "Apply Recommended".
    if ($s.IsLaptop) {
        foreach ($id in 'pwr_plan', 'pwr_coreparking', 'pwr_minstate', 'fps_powerthrottle', 'pwr_hibernate') {
            $t = Get-Tweak $id; $t.Rec = $false; $t.Desc += ' Not recommended on laptops: costs battery life and heat, and laptops rely on hibernation.'
        }
    } elseif ($s.CpuName -match 'Ryzen') {
        # Ryzen picks its fastest cores itself (CPPC) and X3D chips park the non-V-Cache cores; forcing all cores awake undoes both.
        foreach ($id in 'pwr_plan', 'pwr_coreparking', 'pwr_minstate') {
            $t = Get-Tweak $id; $t.Rec = $false; $t.Desc += ' Not recommended on Ryzen: AMD recommends the Balanced plan.'
        }
    }
}

# ================================================================ BOOST PAGE
$BoostXaml = @'
<Border %NS% CornerRadius="12" Background="#0A0810" BorderBrush="#1C1530" BorderThickness="1" Margin="0,0,14,14" Padding="20,18" Height="178">
  <Grid>
    <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
    <StackPanel Orientation="Horizontal">
      <Border Width="34" Height="34" CornerRadius="9" Background="#1A0F2E">
        <TextBlock x:Name="Glyph" FontFamily="Segoe Fluent Icons, Segoe MDL2 Assets" FontSize="16" Foreground="#A855F7" HorizontalAlignment="Center" VerticalAlignment="Center"/>
      </Border>
      <TextBlock x:Name="Title" FontSize="15" FontWeight="SemiBold" Foreground="#F5F3FA" VerticalAlignment="Center" Margin="12,0,0,0"/>
    </StackPanel>
    <TextBlock x:Name="Desc" Grid.Row="1" FontSize="12" Foreground="#8B84A3" TextWrapping="Wrap" TextTrimming="WordEllipsis" Margin="0,10,0,0" LineHeight="17"/>
    <Button x:Name="Run" Grid.Row="2" Style="{DynamicResource GhostBtn}" HorizontalAlignment="Left" Padding="14,6"/>
  </Grid>
</Border>
'@

$BoostActions = @(
    @{ Key = 'temp';     G = 0xE74D; T = 'Clean temp files';        B = 'Clean now';  D = 'Deletes temporary files, old Windows Update downloads and crash dumps. Frees space and speeds up file scans.' }
    @{ Key = 'bgclose';  G = 0xE711; T = 'Close background apps';   B = 'Close apps'; D = 'Closes OneDrive, Teams, Edge, Phone Link, Widgets and similar apps before you launch a game. Asks first.' }
    @{ Key = 'shader';   G = 0xE7FC; T = 'Reset shader cache';      B = 'Reset';      D = 'Clears NVIDIA, AMD and DirectX shader caches. Do this after a driver update if games stutter - shaders rebuild on first launch.' }
    @{ Key = 'dns';      G = 0xE774; T = 'Flush DNS cache';         B = 'Flush';      D = 'Clears cached DNS records. Fixes "can''t connect to server" errors after a game changes servers.' }
    @{ Key = 'explorer'; G = 0xE72C; T = 'Restart Explorer';        B = 'Restart';    D = 'Restarts the taskbar and desktop shell - clears a laggy taskbar or Start menu without a reboot.' }
    @{ Key = 'startup';  G = 0xE7E8; T = 'Startup apps';            B = 'Open';       D = 'Opens Task Manager''s Startup tab - it also lists Store apps, which the Startup apps list below does not.' }
    @{ Key = 'defrag';   G = 0xEDA2; T = 'Optimize drives';         B = 'Open';       D = 'Opens Optimize Drives - defragments your hard drive(s) and TRIMs SSDs. Run it on the drive your games live on.' }
    @{ Key = 'cleanmgr'; G = 0xE8B7; T = 'Disk Cleanup';            B = 'Open';       D = 'Opens Windows Disk Cleanup for deeper cleaning such as old Windows Update and upgrade files.' }
    @{ Key = 'gfx';      G = 0xE7F4; T = 'Windows graphics settings'; B = 'Open';     D = 'Per-game GPU preference, HAGS and "Optimizations for windowed games" in Windows Settings.' }
)

$GpuGuides = @{
    NVIDIA = @{
        Title = 'NVIDIA Control Panel setup'; Short = 'NVIDIA Panel'
        Sub   = 'Manage 3D settings > Global Settings. These can''t be set safely from the registry, so set them once by hand:'
        Rows  = @(
            @('Power management mode', 'Prefer maximum performance'),
            @('Low Latency Mode', 'On  (Ultra if the game has no Reflex)'),
            @('Texture filtering - Quality', 'High performance'),
            @('Anisotropic sample optimization', 'On'),
            @('Trilinear optimization', 'On'),
            @('Threaded optimization', 'On'),
            @('Shader Cache Size', '10 GB'),
            @('Vertical sync', 'Off  (cap FPS in-game instead)'),
            @('Max Frame Rate', 'A value you can hold steadily'))
    }
    AMD = @{
        Title = 'AMD Adrenalin setup'; Short = 'AMD Software'
        Sub   = 'AMD Software > Gaming > Graphics (global settings). These can''t be set safely from the registry, so set them once by hand:'
        Rows  = @(
            @('Radeon Anti-Lag', 'Enabled'),
            @('Radeon Chill', 'Disabled'),
            @('Radeon Boost', 'Disabled  (On only for more FPS in shooters)'),
            @('Radeon Super Resolution', 'Disabled  (use FSR in-game)'),
            @('AMD Fluid Motion Frames', 'Off in competitive games (adds latency)'),
            @('Wait for Vertical Refresh', 'Off, unless application specifies'),
            @('Enhanced Sync', 'Disabled'),
            @('Frame Rate Target Control', 'Disabled  (cap FPS in-game instead)'),
            @('Texture Filtering Quality', 'Performance'),
            @('Tessellation Mode', 'AMD Optimized'),
            @('AMD FreeSync (Display tab)', 'Enabled if your monitor supports it'))
    }
}

function Build-BoostPage {
    $ui.BoostGrid.Children.Clear()
    foreach ($a in $BoostActions) {
        $c = New-El $BoostXaml
        $c.FindName('Glyph').Text = [string][char]$a.G
        $c.FindName('Title').Text = $a.T
        $c.FindName('Desc').Text = $a.D
        $b = $c.FindName('Run'); $b.Content = $a.B; $b.Tag = $a.Key
        $b.Add_Click({ param($s, $e) Invoke-Safe { Invoke-BoostAction ([string]$s.Tag) } })
        [void]$ui.BoostGrid.Children.Add($c)
    }

    # The control-panel guide matches the GPU vendor; Intel / unknown GPUs get no card or shortcut.
    $guide = $GpuGuides["$($script:SysInfo.GpuVendor)"]
    $vis = if ($guide) { 'Visible' } else { 'Collapsed' }
    $ui.GpuCard.Visibility = $vis; $ui.ShortGpu.Visibility = $vis
    $ui.GpuList.Children.Clear()
    if ($guide) {
        $ui.GpuCardTitle.Text = $guide.Title; $ui.GpuCardSub.Text = $guide.Sub; $ui.ShortGpuText.Text = $guide.Short
        foreach ($r in $guide.Rows) {
            $g = New-Object System.Windows.Controls.Grid
            $bd = New-Object System.Windows.Controls.Border; $bd.BorderBrush = Brush '#150F21'; $bd.BorderThickness = '0,0,0,1'; $bd.Padding = '0,7,0,7'
            $k = New-Object System.Windows.Controls.TextBlock; $k.Text = $r[0]; $k.Foreground = Brush '#B9B2CF'; $k.FontSize = 12.5
            $v = New-Object System.Windows.Controls.TextBlock; $v.Text = $r[1]; $v.Foreground = Brush '#D8B4FE'; $v.FontSize = 12.5; $v.HorizontalAlignment = 'Right'
            [void]$g.Children.Add($k); [void]$g.Children.Add($v); $bd.Child = $g
            [void]$ui.GpuList.Children.Add($bd)
        }
    }

    $s = $script:SysInfo
    $hz = if ($s.Refresh) { "$($s.Refresh) Hz" } else { 'refresh rate' }
    $tips = @(
        @('Upscaling is king', 'DLSS (GeForce RTX), FSR or XeSS on Quality/Balanced - or render scale 75-85% - is the single biggest FPS gain in demanding games.'),
        @('Keep textures inside your VRAM', "Your $($s.GpuName) has $($s.GpuVram). Going over it causes heavy stutter, not just lower FPS - drop textures one step if you see it."),
        @('Shadows & ambient occlusion: Low / Off', 'These are the most expensive effects and the least noticeable while playing.'),
        @('Anti-aliasing: Off or FXAA', 'Avoid MSAA and heavy TAA. FXAA / low TAA costs almost nothing.'),
        @('Cap your FPS', "Set an in-game limit slightly below what you can hold, or 3 below your $hz with G-Sync/FreeSync. A GPU that is not pegged at 100% gives smoother frames and lower input lag."),
        @('Use Reflex / Anti-Lag when available', 'Turn on NVIDIA Reflex or AMD Anti-Lag in supported games (Fortnite, Valorant, CS2, Apex...). It cuts render queue latency.'),
        @('Fullscreen over windowed', 'Exclusive fullscreen (or borderless with "Optimizations for windowed games") gives the lowest latency.'),
        @('Close the browser while playing', 'Chrome/Edge use the GPU for video and animations - a YouTube tab can cost FPS, most of all on entry-level cards.')
    )
    $ui.GameTips.Children.Clear()
    foreach ($tp in $tips) {
        $sp = New-Object System.Windows.Controls.StackPanel; $sp.Margin = '0,0,24,14'
        $h = New-Object System.Windows.Controls.TextBlock; $h.Text = $tp[0]; $h.FontWeight = 'SemiBold'; $h.FontSize = 13.5; $h.Foreground = Brush '#F3F1F8'
        $d = New-Object System.Windows.Controls.TextBlock; $d.Text = $tp[1]; $d.FontSize = 12; $d.Foreground = Brush '#8B84A3'; $d.TextWrapping = 'Wrap'; $d.Margin = '0,3,0,0'
        [void]$sp.Children.Add($h); [void]$sp.Children.Add($d)
        [void]$ui.GameTips.Children.Add($sp)
    }
}

function Open-GpuPanel {
    if ($script:SysInfo.GpuVendor -eq 'AMD') {
        $exe = Join-Path $env:ProgramFiles 'AMD\CNext\CNext\RadeonSoftware.exe'
        if (Test-Path -LiteralPath $exe) { Start-Process -FilePath $exe }
        else { Show-Toast 'AMD Software not found - install it with the driver from amd.com.' 'warn' }
        return
    }
    $exe = Join-Path $env:ProgramFiles 'NVIDIA Corporation\Control Panel Client\nvcplui.exe'
    if (Test-Path -LiteralPath $exe) { Start-Process -FilePath $exe; return }
    try { Start-Process -FilePath 'explorer.exe' -ArgumentList 'shell:AppsFolder\NVIDIACorp.NVIDIAControlPanel_56jk4xe1v3a2m!NVIDIACorp.NVIDIAControlPanel' }
    catch { Show-Toast 'NVIDIA Control Panel not found - install it from the Microsoft Store or with the NVIDIA driver.' 'warn' }
}

function Invoke-BoostAction([string]$Key) {
    switch ($Key) {
        'temp' {
            Add-Job @{ Kind = 'clean'; Label = 'Cleaning temp files'; Done = 'Cleaned {0} of temporary files.'
                       Paths = @($env:TEMP, "$env:WINDIR\Temp", "$env:WINDIR\SoftwareDistribution\Download", "$env:LOCALAPPDATA\CrashDumps") }
            Show-Toast 'Cleaning temp files in the background - files in use are skipped.' 'info'
        }
        'shader' {
            if (-not (Ask "Reset the GPU and DirectX shader caches?`n`nGames will rebuild their shaders the next time they start, so the first few minutes may stutter. Close your games first.")) { return }
            Add-Job @{ Kind = 'clean'; Label = 'Resetting shader cache'; Done = 'Shader cache reset ({0} cleared).'
                       Paths = @("$env:LOCALAPPDATA\NVIDIA\DXCache", "$env:LOCALAPPDATA\NVIDIA\GLCache", "$env:USERPROFILE\AppData\LocalLow\NVIDIA\PerDriverVersion\DXCache", "$env:ProgramData\NVIDIA Corporation\NV_Cache",
                                 "$env:LOCALAPPDATA\AMD\DxCache", "$env:LOCALAPPDATA\AMD\DxcCache", "$env:LOCALAPPDATA\AMD\VkCache", "$env:LOCALAPPDATA\AMD\GLCache", "$env:LOCALAPPDATA\D3DSCache") }
        }
        'bgclose' {
            $names = 'OneDrive', 'Teams', 'ms-teams', 'msedge', 'PhoneExperienceHost', 'YourPhone', 'Widgets', 'WidgetService', 'Cortana', 'SkypeApp', 'GoogleDriveFS', 'Dropbox', 'Copilot'
            $running = @(Get-Process -Name $names -ErrorAction SilentlyContinue)
            if ($running.Count -eq 0) { Show-Toast 'No common background apps are running.' 'info'; return }
            $list = ($running | Select-Object -ExpandProperty ProcessName -Unique) -join ', '
            if (-not (Ask "Close these background apps now?`n`n$list`n`nSave any open work in them first.")) { return }
            $running | Stop-Process -Force -ErrorAction SilentlyContinue
            Show-Toast "Closed: $list"
        }
        'dns'      { & ipconfig.exe /flushdns | Out-Null; Show-Toast 'DNS cache flushed.' }
        'explorer' { Add-Job @{ Kind = 'explorer' } }
        'startup'  { Start-Process -FilePath 'taskmgr.exe' -ArgumentList '/0 /startup' }
        'defrag'   { Start-Process -FilePath "$env:WINDIR\System32\dfrgui.exe" }
        'cleanmgr' { Start-Process -FilePath "$env:WINDIR\System32\cleanmgr.exe" -ArgumentList "/d $($env:SystemDrive.TrimEnd(':'))" }
        'gfx'      { Start-Process 'ms-settings:display-advancedgraphics' }
    }
}

# ---------------------------------------------------------------- shared list rows / links
# One rounded list row: title + small subtitle on the left, any control on the right.
function New-ListRow([string]$Title, [string]$Sub, $Right, [string]$Tip = '', [string]$Margin = '0,0,0,6') {
    $bd = New-Object System.Windows.Controls.Border; $bd.Background = Brush '#0F0B16'; $bd.CornerRadius = '8'; $bd.Padding = '14,8,10,8'; $bd.Margin = $Margin
    $g = New-Object System.Windows.Controls.Grid
    [void]$g.ColumnDefinitions.Add((New-Object System.Windows.Controls.ColumnDefinition))
    $cd = New-Object System.Windows.Controls.ColumnDefinition; $cd.Width = 'Auto'; [void]$g.ColumnDefinitions.Add($cd)
    $sp = New-Object System.Windows.Controls.StackPanel; $sp.VerticalAlignment = 'Center'; $sp.Margin = '0,0,12,0'
    $t = New-Object System.Windows.Controls.TextBlock; $t.Text = $Title; $t.FontWeight = 'SemiBold'; $t.TextTrimming = 'CharacterEllipsis'
    [void]$sp.Children.Add($t)
    if ($Sub) { $st = New-Object System.Windows.Controls.TextBlock; $st.Text = $Sub; $st.FontSize = 11.5; $st.Foreground = Brush '#8B84A3'; $st.TextTrimming = 'CharacterEllipsis'; $st.Margin = '0,2,0,0'; [void]$sp.Children.Add($st) }
    if ($Tip) { $sp.ToolTip = $Tip }
    [void]$g.Children.Add($sp)
    if ($Right) { [System.Windows.Controls.Grid]::SetColumn($Right, 1); $Right.VerticalAlignment = 'Center'; [void]$g.Children.Add($Right) }
    $bd.Child = $g
    $bd
}

# Opens a web page as the normal user - a browser started straight from elevated Zenith would run elevated too.
function Open-Url([string]$Url) { if ($Url -match '^https://') { Start-Process -FilePath "$env:WINDIR\explorer.exe" -ArgumentList "`"$Url`"" } }

# ---------------------------------------------------------------- games
function Show-Games($List = (Get-GameList)) {
    $List = @($List | Sort-Object Name)
    $ui.GameList.Children.Clear()
    if (-not $List.Count) {
        $tb = New-Object System.Windows.Controls.TextBlock; $tb.Text = 'No games yet - press "Find my games".'; $tb.Foreground = Brush '#5E5679'
        [void]$ui.GameList.Children.Add($tb)
    }
    foreach ($g in $List) {
        $b = New-Object System.Windows.Controls.Button; $b.Content = 'Remove'; $b.Style = $Window.FindResource('GhostBtn'); $b.Padding = '10,4'; $b.Tag = $g.Exe
        $b.Add_Click({ param($s, $e) Invoke-Safe { Add-Job @{ Kind = 'games'; Remove = @([string]$s.Tag) } } })
        $what = 'High priority' + $(if ($g.GpuSet) { '  -  dedicated GPU' } else { '' })
        [void]$ui.GameList.Children.Add((New-ListRow $g.Name "$($g.Exe)  -  $what" $b "$($g.Path)"))
    }
    # The FPS test picker and the Game Session watcher follow the same list.
    $keep = if ($ui.FpsGame.SelectedItem) { $ui.FpsGame.SelectedItem.Tag } else { $null }
    $ui.FpsGame.Items.Clear()
    foreach ($g in $List) { $it = New-Object System.Windows.Controls.ComboBoxItem; $it.Content = $g.Name; $it.Tag = $g.Exe; [void]$ui.FpsGame.Items.Add($it); if ($g.Exe -eq $keep) { $ui.FpsGame.SelectedItem = $it } }
    if (-not $ui.FpsGame.SelectedItem -and $ui.FpsGame.Items.Count) { $ui.FpsGame.SelectedIndex = 0 }
    $script:Live.GameNames = @($List | ForEach-Object { [IO.Path]::GetFileNameWithoutExtension($_.Exe) })
}
function Add-Game {
    $in = "$($ui.GameExe.Text)".Trim().Trim('"'); $path = $null
    if ($in -match '[\\/]') { if ($in -match '\.exe$' -and [IO.File]::Exists($in)) { $path = $in }; $in = Split-Path $in -Leaf }
    $exe = $in; if ($exe -notmatch '\.exe$') { $exe += '.exe' }
    if ($exe -notmatch '^[\w\-\. \(\)\[\]]+\.exe$' -or $exe -in 'explorer.exe', 'svchost.exe', 'csrss.exe', 'dwm.exe', 'lsass.exe', 'winlogon.exe') { Show-Toast 'Enter a valid game .exe name or full path, e.g. cs2.exe' 'warn'; return }
    Add-Job @{ Kind = 'games'; Add = @(@{ Name = [IO.Path]::GetFileNameWithoutExtension($exe); Exe = $exe; Path = $path }) }
    $ui.GameExe.Text = ''
}

# ---------------------------------------------------------------- startup apps
function Show-StartupApps {
    $ui.StartupList.Children.Clear()
    $apps = @($script:SysInfo.StartupApps | Sort-Object @{ Expression = { -not $_.Enabled } }, Name)
    $ui.StartupSummary.Text = "$(@($apps | Where-Object { $_.Enabled }).Count) of $($apps.Count) apps launch with Windows. Switching one off works exactly like Task Manager's Startup tab and can be switched back any time."
    foreach ($a in $apps) {
        $tg = New-Object System.Windows.Controls.Primitives.ToggleButton; $tg.Style = $Window.FindResource('Switch'); $tg.IsChecked = [bool]$a.Enabled; $tg.Tag = $a
        $tg.Add_Click({ param($s, $e) Invoke-Safe {
            $a = $s.Tag; $s.IsEnabled = $false
            Add-Job @{ Kind = 'startup'; Approved = $a.Approved; ValueName = $a.ValueName; Enable = [bool]$s.IsChecked; Name = $a.Name } } })
        [void]$ui.StartupList.Children.Add((New-ListRow $a.Name $a.Scope $tg $a.Command '0,0,16,6'))
    }
}

# ---------------------------------------------------------------- game session
$script:SessionOn = $false; $script:SessionBusy = $false; $script:SessionAuto = $false; $script:SessionEndTried = $false; $script:TrayAuto = $null
function Update-SessionCard([string]$Detail) {
    $ui.BtnSession.Content = if ($script:SessionOn) { 'End session' } else { 'Start session' }
    $ui.BtnSession.IsEnabled = -not $script:SessionBusy
    if ($Detail) { $ui.SessionText.Text = $Detail }
    elseif (-not $script:SessionOn) { $ui.SessionText.Text = 'Closes background apps, pauses Windows Update and turns on Do Not Disturb while you play - and puts it all back afterwards.' }
}
function Set-Session([bool]$On, [string]$Why = '') {
    if ($script:SessionBusy -or $script:SessionOn -eq $On) { return }
    $script:SessionBusy = $true; Update-SessionCard
    Add-Job @{ Kind = 'session'; On = $On; Why = $Why }
}

# ---------------------------------------------------------------- FPS test
function Find-PresentMon {
    $dirs = @($PSScriptRoot, (Join-Path $env:USERPROFILE 'Downloads')) | Where-Object { $_ }
    $c = @($script:Settings.PresentMonPath) + @(Get-ChildItem -LiteralPath $dirs -Filter 'PresentMon*.exe' -File -ErrorAction SilentlyContinue |
                                                Sort-Object LastWriteTime -Descending | ForEach-Object { $_.FullName })
    $c | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
}
function Update-PresentMonStatus {
    $pm = Find-PresentMon
    if ($pm) { $ui.PmStatus.Text = "PresentMon: $pm"; $ui.PmStatus.Foreground = Brush '#5E5679' }
    else { $ui.PmStatus.Text = 'PresentMon not found - press "Get PresentMon" and save the latest PresentMon-2.x-x64.exe to your Downloads or Zenith folder (or use Locate...).'; $ui.PmStatus.Foreground = Brush '#F5A524' }
    $pm
}
function Show-FpsResults {
    $ui.FpsResults.Children.Clear()
    $res = @(Get-BenchResults)
    foreach ($r in ($res | Select-Object -Last 8)) {
        $v = New-Object System.Windows.Controls.TextBlock; $v.FontSize = 13; $v.Foreground = Brush '#E9D5FF'
        $v.Text = "$($r.Avg) FPS avg     $($r.Low1) 1% low     $($r.Low01) 0.1% low"
        [void]$ui.FpsResults.Children.Add((New-ListRow "$($r.Label)  -  $($r.Game)" "$($r.Time)  -  $($r.Seconds) s, $($r.Frames) frames" $v))
    }
    # Newest run against the first run of the same game - the before/after answer.
    $ui.FpsCompare.Text = ''
    if ($res.Count -ge 2) {
        $last = $res[-1]; $first = $res | Where-Object { $_.Game -eq $last.Game } | Select-Object -First 1
        if ($first -and -not [object]::ReferenceEquals($first, $last) -and $first.Avg -and $first.Low1) {
            $pct = { param($a, $b) '{0:+0;-0;0}%' -f (100 * ($a - $b) / $b) }
            $ui.FpsCompare.Text = "$($last.Label) vs $($first.Label) ($($last.Game)):  $(& $pct $last.Avg $first.Avg) average FPS,  $(& $pct $last.Low1 $first.Low1) 1% low"
            $ui.FpsCompare.Foreground = Brush $(if ($last.Avg -ge $first.Avg) { '#22C55E' } else { '#F5A524' })
        }
    }
    $ui.BtnFpsClear.Visibility = if ($res.Count) { 'Visible' } else { 'Collapsed' }
}
function Start-FpsTest {
    $pm = Update-PresentMonStatus
    if (-not $pm) { Show-Toast 'Get PresentMon first - see the note on the Test page.' 'warn'; return }
    $item = $ui.FpsGame.SelectedItem
    if (-not $item) { Show-Toast 'Add your games on the Boost Up page first (Find my games).' 'warn'; return }
    $label = "$($ui.FpsLabel.Text)".Trim(); if (-not $label) { $label = "Run $(@(Get-BenchResults).Count + 1)" }
    Add-Job @{ Kind = 'fps'; PresentMon = $pm; Exe = [string]$item.Tag; Seconds = @(30, 60, 120)[[math]::Max(0, $ui.FpsSecs.SelectedIndex)]; Label = $label }
    Show-Toast "FPS test queued - switch to $($item.Content) when the countdown starts (watch the title bar)." 'info'
}

# ---------------------------------------------------------------- network test
function Show-NetResults($Res) {
    $ui.NetResults.Children.Clear()
    foreach ($t in @($Res)) {
        $v = New-Object System.Windows.Controls.TextBlock; $v.FontSize = 20; $v.FontWeight = 'Bold'
        $v.Text = if ($null -ne $t.Avg) { "$($t.Avg) ms" } else { 'no reply' }
        [void]$ui.NetResults.Children.Add((New-ListRow $t.Name "jitter $(if ($null -ne $t.Jitter) { "$($t.Jitter) ms" } else { '-' })  -  loss $($t.Loss)%" $v $t.Host '0,0,12,6'))
    }
    $bad = { param($t, $ms, $jit) $t.Loss -gt 0 -or $null -eq $t.Avg -or $t.Avg -gt $ms -or $t.Jitter -gt $jit }
    $router = @($Res | Where-Object { $_.Name -eq 'Your router' }) | Select-Object -First 1
    $net = @($Res | Where-Object { $_.Name -ne 'Your router' })
    if ($router -and (& $bad $router 10 5)) {
        $ui.NetVerdict.Text = 'Lag starts at home: the connection to your router is unstable - usually Wi-Fi. Use a network cable or move closer to the router.'; $ui.NetVerdict.Foreground = Brush '#F87171'
    } elseif (-not @($net | Where-Object { -not (& $bad $_ 80 15) }).Count) {
        $ui.NetVerdict.Text = 'Your home network is fine, but the route through your internet provider is slow or unstable. Restart the modem/router; if it keeps happening, contact your provider.'; $ui.NetVerdict.Foreground = Brush '#F5A524'
    } else {
        $ui.NetVerdict.Text = 'Your connection looks healthy. If games still lag, it is the game server or your PC - check your FPS with the test above.'; $ui.NetVerdict.Foreground = Brush '#22C55E'
    }
}

# ---------------------------------------------------------------- PCPartPicker
function Get-PartList {
    $s = $script:SysInfo
    $cpu = ($s.CpuName -replace '\(R\)|\(TM\)', '' -replace '\s+CPU\s+@.*$', '' -replace '\d+-Core Processor|Processor', '' -replace '\s+', ' ').Trim()
    $gpu = ("$($s.GpuBrand) " + ($s.GpuName -replace '^(NVIDIA|AMD|Intel\(R\))\s+', '' -replace '\(TM\)|\(R\)', '')).Trim()
    $ram = if ($s.RamPart) { $s.RamPart } else { "$($s.RamTotal) $($s.RamType)-$($s.RamMts)" }
    $parts = @(@{ Kind = 'CPU'; Name = $cpu }, @{ Kind = 'Graphics card'; Name = $gpu }, @{ Kind = 'Memory'; Name = $ram }, @{ Kind = 'Motherboard'; Name = $s.Board })
    $parts += @($s.Disks | ForEach-Object { @{ Kind = 'Storage'; Name = $_.Name } })
    $parts | Where-Object { $_.Name -and $_.Name -ne '-' } | ForEach-Object {
        [pscustomobject]@{ Kind = $_.Kind; Name = $_.Name; Url = 'https://pcpartpicker.com/search/?q=' + [Uri]::EscapeDataString($_.Name) } }
}
function Show-Parts {
    $ui.PartsList.Children.Clear()
    foreach ($grp in @(Get-PartList | Group-Object Name)) {
        $p = $grp.Group[0]
        $b = New-Object System.Windows.Controls.Button; $b.Content = 'Search'; $b.Style = $Window.FindResource('GhostBtn'); $b.Padding = '12,4'; $b.Tag = $p.Url
        $b.Add_Click({ param($s, $e) Invoke-Safe { Open-Url ([string]$s.Tag) } })
        [void]$ui.PartsList.Children.Add((New-ListRow ($p.Name + $(if ($grp.Count -gt 1) { "   x$($grp.Count)" } else { '' })) $p.Kind $b))
    }
}

# ---------------------------------------------------------------- profiles
function Export-Profile {
    $dlg = New-Object Microsoft.Win32.SaveFileDialog; $dlg.Filter = 'Zenith profile (*.json)|*.json'; $dlg.FileName = "zenith-profile-$env:COMPUTERNAME.json"
    if (-not $dlg.ShowDialog($Window)) { return }
    $ids = @($script:Tweaks | Where-Object { $script:State[$_.Id] -eq 'On' -and -not $_.Appx } | ForEach-Object { $_.Id })
    [pscustomobject]@{ App = 'Zenith'; Version = $AppVersion; Created = (Get-Date).ToString('s'); Computer = $env:COMPUTERNAME; Tweaks = $ids } |
        ConvertTo-Json | Set-Content -LiteralPath $dlg.FileName -Encoding UTF8
    Show-Toast "Profile with $($ids.Count) optimizations saved."
}
function Import-Profile {
    $dlg = New-Object Microsoft.Win32.OpenFileDialog; $dlg.Filter = 'Zenith profile (*.json)|*.json|All files (*.*)|*.*'
    if (-not $dlg.ShowDialog($Window)) { return }
    $ids = Read-ZenithProfile $dlg.FileName
    $list = @($script:Tweaks | Where-Object { $ids -contains $_.Id -and $script:State[$_.Id] -eq 'Off' -and -not $script:Pending[$_.Id] -and (Test-Visible $_) })
    if (-not $list.Count) { Show-Toast 'Everything in that profile is already active on this PC, or does not apply here.' 'info'; return }
    $flag = @($list | Where-Object { $_.Risk -ne 'Safe' -or (@($_.Tags) | Where-Object { $_ -in 'Feature Breaking', 'Security Risk', 'Not Reversible' }) } | ForEach-Object { "  - $($_.Name)" })
    $msg = "Apply $($list.Count) optimizations from this profile?" + $(if ($flag) { "`n`nThese ones turn off features, lower security or cannot be undone in-app:`n" + ($flag -join "`n") } else { '' })
    if (-not (Ask $msg)) { return }
    foreach ($t in $list) { Add-TweakJob $t 'apply' -Quiet }
    Add-Job @{ Kind = 'states' }
    $script:BulkToast = @("$($list.Count) optimizations from the profile applied. Restart your PC to get the full effect.", 'ok')
    Update-Dashboard
}

# ================================================================ BACKUP / SETTINGS PAGES
function Update-BackupInfo {
    $n = $script:Backup.Count
    $ui.BackupInfo.Text = "$n tweak(s) have their original Windows values saved and can be restored exactly.`nStored in: $BackupFile"
    $ui.BtnRevertAll2.IsEnabled = ($n -gt 0)
    $ui.BtnRevertAll.IsEnabled = ($n -gt 0)
}
function Show-Log {
    if (Test-Path -LiteralPath $LogFile) { $ui.LogBox.Text = (Get-Content -LiteralPath $LogFile -Tail 300) -join "`r`n"; $ui.LogBox.ScrollToEnd() }
    else { $ui.LogBox.Text = 'No activity yet.' }
}

$ui.AboutText.Text = "Zenith $AppVersion - a Windows gaming optimizer that scans each PC and adapts its recommendations (desktop or laptop, Intel or AMD CPU, NVIDIA / AMD / Intel GPU, SSD or HDD).`n`n" +
    "It applies $($script:Tweaks.Count) individually reversible tweaks: power and CPU scheduling, GPU and display, registry/kernel settings, memory and storage, network latency, debloat and privacy. " +
    "Before changing anything it records the original value, and you can create a System Restore point at any time.`n`n" +
    "Honest note: no software makes a graphics card faster. These tweaks remove overhead, background activity and latency - the result is smoother frame times, fewer stutters and better 1% lows, with the largest FPS gains in CPU-heavy games. Pair them with the in-game settings on the Boost Up page.`n`n" +
    "Data folder: $DataDir"

# ================================================================ LIVE STATS
# Sampled on a small background runspace (WMI and nvidia-smi take 50-300 ms per call), so the
# dashboard animations never hitch; the UI only reads the latest numbers.
$script:Live = [hashtable]::Synchronized(@{ Run = $true; Active = $false; Stamp = 0 })
$LiveLoop = {
    $smi = @("$env:WINDIR\System32\nvidia-smi.exe", "$env:ProgramFiles\NVIDIA Corporation\NVSMI\nvidia-smi.exe") | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    $Live.HasSmi = [bool]$smi
    $null = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue   # warm-up while the splash plays
    $tick = 0; $gameClock = [System.Diagnostics.Stopwatch]::StartNew()
    while ($Live.Run) {
        # Game Session watcher: is a game from the list running? (every 2 s, whatever page is open)
        if ($gameClock.ElapsedMilliseconds -ge 2000) {
            $gameClock.Restart(); $names = $Live.GameNames
            $Live.GameRunning = if ($names) { (Get-Process -Name $names -ErrorAction SilentlyContinue | Select-Object -First 1).ProcessName } else { $null }
        }
        if ($Live.Active) {
            $tick++
            try {
                $Live.Cpu = [double](Get-CimInstance Win32_PerfFormattedData_PerfOS_Processor -Filter "Name='_Total'" -ErrorAction Stop).PercentProcessorTime
                $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
                $Live.RamPct = [double][math]::Round(100 * (1 - $os.FreePhysicalMemory / $os.TotalVisibleMemorySize))
                $Live.RamGb = ($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / 1MB
            } catch {}
            if ($smi -and ($tick % 2 -eq 1)) {
                try {
                    $p = "$(& $smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits 2>$null | Select-Object -First 1)" -split ',\s*'
                    if ($p.Count -ge 4) { $Live.Gpu = $p }
                } catch {}
            }
            if ($tick % 5 -eq 1) { $Live.Procs = @(Get-Process).Count }
            $Live.Stamp++
        }
        Start-Sleep -Milliseconds $(if ($Live.Active) { 1500 } else { 200 })
    }
}
$lrs = [runspacefactory]::CreateRunspace(); $lrs.Open(); $lrs.SessionStateProxy.SetVariable('Live', $script:Live)
$script:LivePS = [powershell]::Create(); $script:LivePS.Runspace = $lrs
[void]$script:LivePS.AddScript($LiveLoop.ToString()); [void]$script:LivePS.BeginInvoke()

$script:LiveStamp = 0
$script:StatsTimer = New-Object System.Windows.Threading.DispatcherTimer
$script:StatsTimer.Interval = [TimeSpan]::FromMilliseconds(250)
$script:StatsTimer.Add_Tick({
    $g = $script:Live.GameRunning
    # Auto Game Session: start when a listed game launches, end when it closes (only sessions it started itself).
    if ($script:Settings.AutoSession) {
        if ($g -and -not $script:SessionOn -and -not $script:SessionAuto) { $script:SessionAuto = $true; Set-Session $true "$g started" }
        elseif (-not $g -and $script:SessionAuto) { $script:SessionAuto = $false; if ($script:SessionOn) { Set-Session $false } }
    }
    # Hide to the tray when a listed game starts - once per launch, so reopening Zenith mid-game sticks.
    # A game already running when Zenith opens counts as seen: you opened Zenith on purpose.
    if ($null -eq $script:TrayAuto) { $script:TrayAuto = [bool]$g }
    if ($g -and -not $script:TrayAuto) {
        $script:TrayAuto = $true
        if ($script:Settings.TrayWhileGaming -and $Window.IsVisible) { Hide-ToTray "$g is running - Zenith is in the tray. Double-click the icon to open it." }
    } elseif (-not $g -and $script:TrayAuto) {
        $script:TrayAuto = $false
        if (-not $Window.IsVisible) { $script:Tray.ShowBalloonTip(3000, 'Zenith', 'Game closed - double-click the tray icon to open Zenith.', [System.Windows.Forms.ToolTipIcon]::Info) }
    }
    $script:Live.Active = ($Window.IsVisible -and $ui.PageDashboard.Visibility -eq 'Visible' -and $ui.Splash.Visibility -ne 'Visible' -and $Window.WindowState -ne 'Minimized')
    if ($script:Live.Stamp -eq $script:LiveStamp) { return }
    $script:LiveStamp = $script:Live.Stamp; $L = $script:Live
    $vp = [System.Windows.Controls.ProgressBar]::ValueProperty
    if ($null -ne $L.Cpu)    { Start-Anim $ui.CpuBar $vp $null $L.Cpu 450; $ui.CpuPct.Text = "$($L.Cpu)%" }
    if ($null -ne $L.RamPct) { Start-Anim $ui.RamBar $vp $null $L.RamPct 450; $ui.RamPct.Text = ('{0:N1} GB  ({1}%)' -f $L.RamGb, $L.RamPct) }
    if ($L.Gpu) {
        $p = $L.Gpu; Start-Anim $ui.GpuBar $vp $null ([double]$p[0]) 450
        $ui.GpuPct.Text = "$($p[0])%  $([char]0x00B7)  $($p[1]) $([char]0x00B0)C  $([char]0x00B7)  VRAM $($p[2]) / $($p[3]) MB"
    } elseif ($L.HasSmi -eq $false) { $ui.GpuPct.Text = 'n/a (NVIDIA driver tools not found)' }
    if ($L.Procs) { $ui.StatProcs.Text = "$($L.Procs)" }
})

# ================================================================ WIRING
$NavMap = [ordered]@{
    NavDashboard = 'PageDashboard'; NavScanner = 'PageScanner'; NavTweaks = 'PageTweaks'
    NavBoost = 'PageBoost'; NavTest = 'PageTest'; NavBackup = 'PageBackup'; NavSettings = 'PageSettings'
}
function Show-Page([string]$Page) {
    foreach ($p in $NavMap.Values) { $ui[$p].Visibility = 'Collapsed' }
    $el = $ui[$Page]; $el.Visibility = 'Visible'
    # fade + slide up on every page switch
    if ($el.RenderTransform -isnot [System.Windows.Media.TranslateTransform]) { $el.RenderTransform = New-Object System.Windows.Media.TranslateTransform }
    Start-Anim $el ([System.Windows.UIElement]::OpacityProperty) 0 1 170
    Start-Anim $el.RenderTransform ([System.Windows.Media.TranslateTransform]::YProperty) 12 0 220
    if ($Page -eq 'PageBackup') { Show-Log; Update-BackupInfo }
}
foreach ($k in $NavMap.Keys) {
    $ui[$k].Add_Checked({ param($s, $e) Invoke-Safe { Show-Page $NavMap[$s.Name] } })
}

# window chrome
$ui.BtnMin.Add_Click({ $Window.WindowState = 'Minimized' })
$ui.BtnMax.Add_Click({ $Window.WindowState = if ($Window.WindowState -eq 'Maximized') { 'Normal' } else { 'Maximized' } })
$ui.BtnClose.Add_Click({ $Window.Close() })
$Window.Add_StateChanged({
    if ($Window.WindowState -eq 'Maximized') { $ui.Root.Margin = '7'; $ui.BtnMax.Content = [string][char]0xE923 }
    else { $ui.Root.Margin = '0'; $ui.BtnMax.Content = [string][char]0xE922 }
})
$ui.BtnRestart.Add_Click({
    if (Ask 'Restart the PC now to finish applying tweaks? Save your work first.') { & shutdown.exe /r /t 5 /c 'Zenith: restarting to apply optimizations' }
})

# dashboard
$ui.BtnApplyRec.Add_Click({ Invoke-Safe { Invoke-ApplyRecommended } })
$ui.BtnApplyAllRec.Add_Click({ Invoke-Safe { Invoke-ApplyRecommended } })
$ui.BtnGoTweaks.Add_Click({ $ui.NavTweaks.IsChecked = $true })
$ui.ShortScan.Add_Click({ $ui.NavScanner.IsChecked = $true })
$ui.ShortBoost.Add_Click({ $ui.NavBoost.IsChecked = $true })
$ui.ShortBackup.Add_Click({ $ui.NavBackup.IsChecked = $true })
$ui.ShortGpu.Add_Click({ Invoke-Safe { Open-GpuPanel } })

# scanner
$ui.BtnRescan.Add_Click({ Invoke-Safe { Add-Job @{ Kind = 'rescan' } } })

# optimizations
$ui.BtnTweaksApplyRec.Add_Click({ Invoke-Safe { Invoke-ApplyRecommended } })
$ui.BtnRevertAll.Add_Click({ Invoke-Safe { Invoke-RevertAll } })
$ui.SearchBox.Add_TextChanged({
    $ui.SearchHint.Visibility = if ([string]::IsNullOrEmpty($ui.SearchBox.Text)) { 'Visible' } else { 'Collapsed' }
    Update-Filter
})
$ui.TweakScroll.Add_SizeChanged({
    $w = $ui.TweakScroll.ActualWidth
    $ui.TweakGrid.Columns = if ($w -lt 980) { 2 } elseif ($w -gt 1720) { 4 } else { 3 }
})

# boost
$ui.BtnAddGame.Add_Click({ Invoke-Safe { Add-Game } })
$ui.GameExe.Add_KeyDown({ param($s, $e) if ($e.Key -eq 'Return') { Invoke-Safe { Add-Game } } })
$ui.BtnOpenGpuPanel.Add_Click({ Invoke-Safe { Open-GpuPanel } })
$ui.BtnFindGames.Add_Click({ Invoke-Safe { Add-Job @{ Kind = 'games'; Detect = $true }; Show-Toast 'Looking for installed games in the background...' 'info' } })

# game session
$ui.BtnSession.Add_Click({ Invoke-Safe { Set-Session (-not $script:SessionOn) } })
$ui.SetAutoSession.Add_Click({ $script:Settings.AutoSession = [bool]$ui.SetAutoSession.IsChecked; Save-Settings; if (-not $script:Settings.AutoSession) { $script:SessionAuto = $false } })

# test page
$ui.BtnFps.Add_Click({ Invoke-Safe { Start-FpsTest } })
$ui.BtnFpsClear.Add_Click({ Invoke-Safe { if (Ask 'Delete all FPS test results?') { Remove-Item -LiteralPath $BenchFile -ErrorAction SilentlyContinue; Show-FpsResults } } })
$ui.BtnGetPm.Add_Click({ Open-Url 'https://github.com/GameTechDev/PresentMon/releases' })
$ui.BtnFindPm.Add_Click({ Invoke-Safe {
    $d = New-Object Microsoft.Win32.OpenFileDialog; $d.Filter = 'PresentMon (*.exe)|*.exe'
    if ($d.ShowDialog($Window)) { $script:Settings.PresentMonPath = $d.FileName; Save-Settings; [void](Update-PresentMonStatus) } } })
$ui.FpsLabel.Add_TextChanged({ $ui.FpsLabelHint.Visibility = if ($ui.FpsLabel.Text) { 'Collapsed' } else { 'Visible' } })
$ui.BtnNet.Add_Click({ Invoke-Safe { Add-Job @{ Kind = 'net' }; Show-Toast 'Network test running in the background - about 10 seconds.' 'info' } })

# scanner: PCPartPicker
$ui.BtnPartsOpen.Add_Click({ Invoke-Safe {
    $u = @(Get-PartList | ForEach-Object { $_.Url } | Select-Object -Unique); foreach ($x in $u) { Open-Url $x }
    Show-Toast "Opened $($u.Count) PCPartPicker searches in your browser." } })
$ui.BtnPartsCopy.Add_Click({ Invoke-Safe {
    $t = @(Get-PartList | Group-Object Name | ForEach-Object { "$($_.Group[0].Kind): $($_.Name)" + $(if ($_.Count -gt 1) { " x$($_.Count)" } else { '' }) })
    [System.Windows.Clipboard]::SetText((@($t) + 'Case / power supply / CPU cooler: not detectable - add manually') -join "`r`n")
    Show-Toast 'Parts list copied to the clipboard.' } })

# backups
$ui.BtnCreateRP.Add_Click({ Invoke-Safe { Add-Job @{ Kind = 'restore'; Manual = $true }; Show-Toast 'Creating a restore point in the background...' 'info' } })
$ui.BtnOpenRstrui.Add_Click({ Start-Process "$env:WINDIR\System32\rstrui.exe" })
$ui.BtnRevertAll2.Add_Click({ Invoke-Safe { Invoke-RevertAll } })
$ui.BtnOpenData.Add_Click({ Start-Process explorer.exe $DataDir })
$ui.BtnRefreshLog.Add_Click({ Show-Log })
$ui.BtnExport.Add_Click({ Invoke-Safe { Export-Profile } })
$ui.BtnImport.Add_Click({ Invoke-Safe { Import-Profile } })

# settings
$ui.SetRestore.IsChecked  = [bool]$script:Settings.AutoRestorePoint
$ui.SetAdvanced.IsChecked = [bool]$script:Settings.ShowAdvanced
$ui.SetConfirm.IsChecked  = [bool]$script:Settings.ConfirmRisky
$ui.SetRestore.Add_Click({ $script:Settings.AutoRestorePoint = [bool]$ui.SetRestore.IsChecked; Save-Settings })
$ui.SetConfirm.Add_Click({ $script:Settings.ConfirmRisky = [bool]$ui.SetConfirm.IsChecked; Save-Settings })
$ui.SetTray.IsChecked = [bool]$script:Settings.TrayWhileGaming
$ui.SetTray.Add_Click({ $script:Settings.TrayWhileGaming = [bool]$ui.SetTray.IsChecked; Save-Settings })
$ui.SetAdvanced.Add_Click({
    $script:Settings.ShowAdvanced = [bool]$ui.SetAdvanced.IsChecked; Save-Settings
    Update-ChipCounts; Update-Filter; Update-Dashboard
})

$Window.Add_Closing({
    param($s, $e)
    if (-not $script:Closing) {
        # Jobs that change the system (a scan in progress can simply be dropped).
        $busy = @(@($script:Sync.Jobs.ToArray()) + $script:Sync.Current | Where-Object { $_ -and $_.Kind -notin 'scan', 'rescan', 'states', 'net', 'fps' })
        if ($busy.Count) {
            $e.Cancel = $true
            if ($script:CloseWhenIdle) { return }
            if (-not (Ask "Zenith is still working on $($busy.Count) job(s).`n`nClose once the current step finishes? Queued jobs that have not started are skipped." 'Warning')) { return }
            # Drop what has not started; the running job finishes (so its backup is saved), then the queue timer closes the window.
            $j = $null; while ($script:Sync.Jobs.TryTake([ref]$j)) { $script:QueueDone++; if ($j.Id) { $script:Pending.Remove($j.Id) } }
            $script:CloseWhenIdle = $true; $script:BulkToast = $null
            return
        }
        if ($script:SessionOn -and -not $script:SessionEndTried) {
            # Put apps, Windows Update and notifications back first; the queue timer closes the window when that is done.
            $script:SessionEndTried = $true; $e.Cancel = $true; $script:CloseWhenIdle = $true; $script:SessionBusy = $false; Set-Session $false
            return
        }
    }
    $script:Closing = $true
    $script:Sync.Jobs.CompleteAdding(); $script:Live.Run = $false
    $script:StatsTimer.Stop(); $script:QueueTimer.Stop(); $script:ToastTimer.Stop()
    $script:Tray.Visible = $false; $script:Tray.Dispose()   # otherwise a dead icon lingers in the tray
    Write-Log 'Zenith closed'
})

# ================================================================ STARTUP
# The scan starts on the worker right away; the splash animation plays meanwhile, and
# Complete-Startup builds the interface when the results arrive.
$Window.Add_Loaded({ $script:Boot.Restart() })
Write-Log "Zenith $AppVersion started"
Add-Job @{ Kind = 'scan' }
$script:QueueTimer.Start()

# fit smaller screens
try {
    $wa = [System.Windows.SystemParameters]::WorkArea
    if ($Window.Height -gt $wa.Height) { $Window.MinHeight = [math]::Min($Window.MinHeight, $wa.Height - 10); $Window.Height = $wa.Height - 10 }
    if ($Window.Width -gt $wa.Width)   { $Window.MinWidth = [math]::Min($Window.MinWidth, $wa.Width - 10);   $Window.Width = $wa.Width - 10 }
} catch {}

[void]$Window.ShowDialog()
