$serverList = Get-FilePath
$list = Get-Content $serverList

$user = read-host "Enter the name of the user you want to change (DOMAIN\User)"
$pass = read-host -assecurestring "New Password" | convertfrom-securestring | ConvertTo-SecureString




if($list -match "localhost"){
script -server $list -user $user -pass $pass
}
else{
  $mycred = Get-Credential -Message "Enter creds to log into the servers"
  $list | Invoke-Command -ComputerName $_ -Credential $mycred -scriptblock {script -server $_ -user $user -pass $pass}
}


function script{
    param($server,$user,$pass)
    function changeWinServiceUser {
        param ($server,$user,$pass)
        $winService = ""
        try{
        sc.exe config $winService obj= $user password= $pass
        appendToFile -computerName $server -message "Changed"   
        }
        catch{
            appendToFile -computerName $server -message 
        }

    }


    function appendToFile{
        param(
            $computerName, $message
        )
        $fileLocation = "C:\Users\$env:USERNAME\Desktop\passwordChange.txt"
        $date= get-date | Select -ExpandProperty DateTime
        $appendMessage = @($computerName," ",$message," ",$date)
        $appendMessage | Out-File $fileLocation -NoNewline -Append
        "`n" | Out-File $fileLocation -Append


    }


changeWinServiceUser -server $server -user $user -pass $pass    
}