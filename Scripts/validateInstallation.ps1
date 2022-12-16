$SoftwareName = "Win*"


function validateProgramInstallation{
    param($SoftwareToCheck)
    $ServiceCheck = get-service | Select DisplayName, Status
    $checkInstalledPrograms = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select DisplayName,DisplayVersion, Publisher, InstallDate
   
    #check installation
    if($checkInstalledPrograms.displayname -match $SoftwareNameToCheck){
        #vadilate service is running
        if($ServiceCheck.displayname -match $SoftwareNameToCheck){
            return 0
        }
        else{
            $formatServiceResults = $ServiceCheck | %{write "$_.display is $_.status"}
            write "$formatServiceResults" 
            return 1
        }

    }
    
    else{
        write "$SoftwareToCheck is not installed"
        return 1
    }
}

validateProgramInstallation -SoftwareNameToCheck $SoftwareName