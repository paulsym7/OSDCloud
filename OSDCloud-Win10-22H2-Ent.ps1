Write-Output 'Making sure the latest OSD module is installed'
$Installed = Get-Module -Name OSD
Write-Output "Version $($Installed.Version.ToString()) of the OSD module is currently installed"
$Latest = Find-Module -Name OSD
if($Installed.Version.ToString() -lt $Latest.Version.ToString()){
    Write-Output "Installing version $($Latest.Version.ToString()) of the OSD module"
    Install-Module -Name OSD -Force
    Import-Module -Name OSD -Force
}
else{
    Write-Output 'This is the latest avaiable version'
}

Write-Output 'Starting OSD Cloud...'
Write-Output 'Installing Windows 10 22H2 Enterprise'
<#
$Params = @{
  OSName = 'Windows 10 22H2 x64'
  OSEdition = 'Enterprise'
  OSLanguage = 'en-gb'
  OSLicense = 'Volume'
  Firmware = $false
  Screenshot = $true
  SkipAutoPilot = $true
  Restart = $true
  ZTI = $true
}
Start-OSDCloud @params
#>

$Params = @{
    OSVersion   = 'Windows 10'
    OSBuild     = '22H2'
    OSLicense   = 'Retail'
    OSLanguage  = 'en-gb'
}
$FeatureUpdate = Get-FeatureUpdate @Params

$Global:MyOSDCloud = @{
	GetFeatureUpdate = $FeatureUpdate
	#ImageFileName = $FeatureUpdate.FileName
	ImageFileUrl = $FeatureUpdate.FileUri
        MSCatalogFirmware = $false
        #MSCatalogDiskDrivers = $false
        #MSCatalogNetDrivers = $false
        #MSCatalogScsiDrivers = $false
	OSBuild = '22H2'
	OSEdition = 'Enterprise'
	OSLanguage = 'en-gb'
	OSLicense = 'Volume'
	Restart = $true
	SkipAutoPilot = $true
	ZTI = $true
}

Invoke-OSDCloud
