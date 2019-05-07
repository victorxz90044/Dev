# log in to the box

#validate that it doesn't exist

#excute command

# catch any errors

function install-choco {
    param (
        $host
    )

    $installedSoftware = "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName,DisplayVersion, Publisher, InstallDate"
    if($installedSoftware -notcontains "chocolatey"){
        try{ 
            Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
        }
        Catch {
            return $_.Exception.Message+$_.Exception.ItemName

        }
        
    }
    else {
        $message = "Chocolatery is already installed"
        $chocolateyInstall = $installedSoftware | Where-Object{ $_.DisplayName -like "Choco*"}
        return $message+$chocolateyInstall  

    }    
}

