>Remoting enables you to access remote machines across a network and retrieve data from or execute code on one or many remote computers You have three options to perform these actions; Invoke-command, pssessions, and SSH


### Invoke-Command
> The `Invoke-Command` cmdlet runs commands on a local or remote computer and returns all output from the commands, including errors. Using a single
    `Invoke-Command` command, you can run commands on multiple computers.


### Enter-Pssession
>The `Enter-PSSession` cmdlet starts an interactive session with a single remote computer. During the session, the commands that you type run on the
    remote computer, just as if you were typing directly on the remote computer. You can have only one interactive session at a time.

### SSH
> Windows 10 and Windows 11 include a built-in SSH server and client that are based on OpenSSH, a connectivity tool for remote sign-in that uses the SSH protocol.



### Testing Powershell Remoting
> Tests whether the WinRM service is running on a local or remote computer
```
Test-WSMan
```


### WinRm, the power behind powershell remoting
> PowerShell Remoting uses [Windows Remote Management (WinRM)](https://learn.microsoft.com/en-us/windows/win32/winrm/portal), which is the Microsoft implementation of the [Web Services for Management (WS-Management)](https://www.dmtf.org/sites/default/files/standards/documents/DSP0226_1.2.0.pdf) protocol, to allow users to run PowerShell commands on remote computers. You can find more information about using PowerShell Remoting at [Running Remote Commands](https://learn.microsoft.com/en-us/powershell/scripting/learn/remoting/running-remote-commands?view=powershell-7.3).

- Windows will use http://localhost:5985/wsman as the WinRM endpoint
- PowerShell Remoting (and WinRM) listen on the ports  HTTP: 5985, HTTPS: 5986
- By default, PowerShell Remoting only allows connections from members of the Administrators group. Sessions are launched under the user's context, so all operating system access controls applied to individual users and groups continue to apply to them while connected over PowerShell Remoting.

### PowerShell versions
> BEWARE: PowerShell version determine the types of commands available on a given server.

- A common gotcha during development is forgetting the versions on the dev server vs target servers.
- For example, for-eachobject -parallel only exist in PowerShell v7 and up. while 2016 servers run on PowerShell 5.
- Upgrades for PowerShell on available but knowing the base line helps when troubleshooting remote executions
- Keep in mind that other may have developed scripts for that server in a particular PowerShell version. Comminute with the team if you are going to perform PowerShell upgrades.

##### Quick Reference below on base versions
1.0
Windows XP SP2  
Server 2003 SP1  
Windows Vista

2.0
Windows 7  
Windows Server 2008 R2
Windows XP SP3  
Windows Server 2003 SP2  
Windows Vista SP1

3.0
Windows 8  
Windows Server 2012
Windows 7 SP1  
Windows Server 2008 SP1  
Windows Server 2008 R2 SP1

4.0
Windows 8.1  
Windows Server 2012 R2
Windows 7 SP1  
Windows Server 2008 R2 SP1  
Windows Server 2012

5.1
Windows 10 Anniversary Update  
Windows Server 2016
Windows 7  
Windows Server 2008  
Windows Server 2008 R2  
Windows Server 2012  
Windows Server 2012 R2


### Executing Commands locally vs remotely
Lets start by selecting the credential you are going to use. 
```
$cred = Get-Credential
# Prompt will appear for credentials
# user: first.last@example.com pass:password
```
Now select a target server
```
$server = test.example.com
```
First start by running a local command
```
get-psdrive
```
Lets run the same but on a remote
```
Invoke-command -computername $server -Credential $cred -ScriptBlock {get-psdrive}
```
Using invoke command creates a small session, executes the commands, and closes the session.

### PSSession
Sessions come into play when we want a persistent connection to the remote server.
```
Enter-PSSession - ComputerName Server01 -Credential $cred
[test.example: PS C:\Users\user\Documents>_
```
You can use enter-pssession like you would with SSH and naviagate through the remote server. To end the session and return back to the local computer; simply type 'exit' and hit enter.

You can create sessions and send commands to them.
```
$s = New-PSSession -ComputerName Server01 -Credential $cred
Invoke-Command -Session $s -ScriptBlock {get-services}
```

You can compare what services live in the remote server compared to your local one.
```
$remote_services = Invoke-Command -Session $s -ScriptBlock {get-services}
$local_services = get-services
diff ($remote_services | select name) ($local_services | select name)
```


You can use your powershell console to access object directly from the cmdlet
```
Get-EventLog -ComputerName $server
```
These cmdlets have that combability
-   Restart-Computer
-   Test-Connection
-   Clear-EventLog
-   Get-EventLog
-   Get-HotFix
-   Get-Process
-   Get-Service
-   Set-Service
-   Get-WinEvent


### Running on multiple servers
You can place all servers in a variable and execute.
```
$s = New-PSSession -ComputerName S1, S2, S3 -Credential $cred
Invoke-Command -Session $s -ScriptBlock {hostname}
```

### Locals variables in remote servers
Lets create some variable on the local computer that the remote servers know nothing about. Then send that variable to the remote server.
```
$text = "Hello World"
$text
Invoke-Command -ComputerName $server -Credential $cred {write $using:text}
```


### Splatting
PowerShell splatting passes a collection of parameter names and values to a command.
```
$Splat = @{ Name = "Win*"; Include = "WinRM" }
Invoke-Command -Session $s -ScriptBlock { Get-Service @Using:Splat }
```

### Local Functions on Remote Servers
We can create functions locally and send to the remote server to be executed. That function can be stored in a variable or called directly.
```
# Send function through a variable
$sb = function Get-LocalName {write $env:COMPUTERNAME}
Invoke-Command -ComputerName $sever -Credential $cred -ScriptBlock {$using:sb}

#Calling the fucntion directly
Invoke-Command -ComputerName $sever -Credential $cred -ScriptBlock ${function:get-localname}

# Calling the function directly with parameters
$parm1 = "Hello"
$parm2 = "World"
function write-text($string1,$string2){
write "$string1 $string2"
}

Invoke-Command -ComputerName $sever -Credential $cred -ScriptBlock ${function:write-text} -ArgumentList ("Hello",$env:COMPUTERNAME)

#You can call the fucntion and using remote variables

Invoke-Command -ComputerName $sever -Credential $cred -ScriptBlock ${function:write-text("Hello",$env:COMPUTERNAME)}
```

### Running multiple commands on a one-liner
You can run commands one after another with ";".
```
Invoke-Command -Session $s -ScriptBlock { write hostname; get-process; get-eventlog }
```

### Writing Multiline Script Block
You can run a script block with better readability with ticks.
```
Invoke-Command -Session $s -ScriptBlock {`
get-serveice `
-id `
10748
}
```

### Using a local script
We can execute a local script to the remote server.
```
Invoke-Command -ComputerName S1, S2 -FilePath C:\Test\Sample.ps1
```

### Copying between servers.
Its often useful to send files between servers. I'm going to show how we can send the file back and forth.
```
#Create the empty file
New-Item -ItemType File -Name "test.txt"
# Select the file, session, and destination on the remote server
Copy-Item -Path .\test.txt -ToSession $s -Destination C:\
# Lets check if arrived
Invoke-Command -Session $s {ls C:\}
#Give it some data
Invoke-Command -Session $s {Get-Process > C:\test.txt}
# Let see the data
Invoke-Command -Session $s {cat C:\test.txt}
#Bring that file home
Copy-Item -FromSession $s -Path C:\test.txt  -Destination X:\
```
We are using the ToSession flag to send the file and FromSession flag to receive the file.

### Closing our sessions
Let make sure we close our sessions after every use. We don't want open connections on our servers using up memory and waiting for it be hijacked.
```
$s | Disconnect-PSSession
# If you have multiple sessions
Disconnect-PSSession -id $id
```

### Working with different domains or non-domain servers
There are times when you want to use powershell on servers that don't exist on your domain. If the firewalls and permissions exist. You can use the local TrustedHosts file to grant permissions to them.

To view the list of TrustedHosts added to the machine, type the following command. By default, its value is blank.
```
Get-Item WSMan:\localhost\Client\TrustedHosts
```


Using the Set-Item cmdlet and the wildcard you can add all the computers to the TrustedHosts list with the following command.
```
Set-Item WSMan:\localhost\Client\TrustedHosts -Value *
```

In the following command, replace .yourdomain.com with your own domain name.
```
Set-Item WSMan:\localhost\Client\TrustedHosts *.yourdomain.com
```
