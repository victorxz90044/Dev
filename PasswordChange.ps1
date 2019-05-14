
function script{
    param ($server, $user, $pass)

    function invokeChange {
        param (
            $serverName, $fileLocation, $user, $password
        )
        if((test-connection $serverName -Quiet).Equals($True)){
                if((net user) -match $user){
                        try{
                            net user $user $password
                            appendToFile -computerName $serverName -message "Pass" -fileLocation $fileLocation
                        }
                        catch{
                            appendToFile -computerName $serverName -message $_.Exception.Message -fileLocation $fileLocation
                        }
                        }
                else{
                        appendToFile -computerName $serverName -message "User not found" -fileLocation $fileLocation
                }
            
        }
        else{
            appendToFile -computerName $serverName -message "Fail to connect" -fileLocation $fileLocation
    
            
            }
        }
    
    
    
    
    function appendToFile{
        param(
            $computerName, $message, $fileLocation
        )
        $date= get-date | Select -ExpandProperty DateTime
        $appendMessage = @($computerName," ",$message," ",$date)
        $appendMessage | Out-File $fileLocation -NoNewline -Append
        "`n" | Out-File $fileLocation -Append
    
    
    }
    

    
     
 

    
    invokeChange -serverName $server -fileLocation "C:\Users\$env:USERNAME\Desktop\passwordChange.txt" -user $user -password $pass
}



Function Get-FilePath{ 
    try{
            
            
        [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
        Out-Null
        #creating new object for opening file dialog
        $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $OpenFileDialog.filter = "All files (*.*)| *.*"
        $OpenFileDialog.ShowDialog() | Out-Null
        $OpenFileDialog.filename
    }
    Catch{
            Write-Host "ERROR: $($Error[0])";
        }
        
    }


    
    $serverList = Get-FilePath
    $list = Get-Content $serverList
    
    $user = read-host "Enter the name of the user you want to change"
    $pass = read-host -assecurestring "New Password" | convertfrom-securestring | ConvertTo-SecureString
    
  


  if($list -match "localhost"){
    script -server $list -user $user -pass $pass
  }
  else{
      $mycred = Get-Credential -Message "Enter creds to log into the servers"
      $list | Invoke-Command -ComputerName $_ -Credential $mycred -scriptblock {script -server $_ -user $user -pass $pass}
  }
  
    

    
