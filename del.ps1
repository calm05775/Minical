using System;
using System.IO;
using System.Net;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

class Program
{
    static void Main()
    {
        string psScriptUrl = "https://raw.githubusercontent.com/<your-user>/<repo>/main/YourScript.ps1";
        string psScript = DownloadContent(psScriptUrl);
        
        // Now we have the entire PS script in memory
        ExecutePowerShellInMemory(psScript);
    }

    private static string DownloadContent(string url)
    {
        using (WebClient wc = new WebClient())
        {
            return wc.DownloadString(url);
        }
    }

    private static void ExecutePowerShellInMemory(string psCode)
    {
        using (Runspace runspace = RunspaceFactory.CreateRunspace())
        {
            runspace.Open();
            using (PowerShell ps = PowerShell.Create())
            {
                ps.Runspace = runspace;
                ps.AddScript(psCode);
                ps.Invoke();  // Execute the loaded code
            }
        }
    }
}
