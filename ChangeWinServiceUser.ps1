#Getting the list
$serverList = Get-FilePath
$list = Get-Content $serverList

#the user to change
$user = read-host "Enter the name of the user you want to change"
$password = read-host -assecurestring "New Password" | convertfrom-securestring | ConvertTo-SecureString

if($list -match "localhost"){
        changeWinServiceAccount -winservice $winService -user $user -pass $password
  }
  else{
      #executing remotely
      $mycred = Get-Credential -Message "Enter creds to log into the servers"
      $list | %{
                try{ 
                    Invoke-Command -ComputerName $_ -Credential $mycred -scriptblock {
   
                     
                        Function changeWinServiceAccount{
                            param (
                                $winService, $user, $password            
                            )
                            if((get-Service) -match $winService){
                                try{
                                    sc.exe config $winService obj= $user password= $password
                                    $message = "pass"    
                                    return $message                                    
                                        }
                                catch{
                                    $message = $_.Exception.Message
                                    return  $message
                                }
                            }
                            else{
                                $message = "Service not found"
                                return  $message
                            }
                    }

                        $user = $using:user
                        $password = $using:password
                        $winservice = $using:winService

                        changeWinServiceAccount -winservice $winService -user $user -pass $password    

                    }
                    return appendToFile -computerName $_ -message $message -fileLocation C:\Users\$env:USERNAME\Desktop\changeWinServiceAccount.txt  
                }
                catch {
                    appendToFile -computerName $_ -message "failed to connect" -fileLocation C:\Users\$env:USERNAME\Desktop\changeWinServiceAccount.txt
                }           
            }
    }    
    



Function changeWinServiceAccount{
        param (
            $winService, $user, $password            
        )
        if((get-Service) -match $winService){
            try{
                sc.exe config $winService obj= $user password= $password
                $message = "pass"    
                return $message                                    
                    }
            catch{
                $message = $_.Exception.Message
                return  $message
            }
        }
        else{
            $message = "Service not found"
            return  $message
        }
}






Function Get-FilePath{ 
    try{
            
        #loading module for windows forums            
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
Function appendToFile{
        param(
            $computerName, $message, $fileLocation
        )
        $date= get-date | Select -ExpandProperty DateTime
        $appendMessage = @($computerName," ",$message," ",$date)
        $appendMessage | Out-File $fileLocation -NoNewline -Append
        "`n" | Out-File $fileLocation -Append
    
    
    }






        