Write-Output 'Making sure the latest OSD module is installed'
Install-Module -Name OSD -Force
Import-Module -Name OSD -Force
Write-Output 'Starting OSD Cloud...'
Write-Output 'Installing Windows 10 22H2 Enterprise'
$Params = @{
  OSName = 'Windows 10 22H2 x64'
  OSEdition = 'Enterprise'
  OSLanguage = 'en-gb'
  OSLicense = 'Retail'
  Firmware = $false
  Screenshot = $true
  SkipAutoPilot = $true
  Restart = $true
  ZTI = $true
}
#Start-OSDCloud @params

$Global:MyOSDCloud = @{
        MSCatalogFirmware = $false
        MSCatalogDiskDrivers = $false
        MSCatalogNetDrivers = $false
        MSCatalogScsiDrivers = $false
	OSBuild = '22H2'
	OSEdition = 'Enterprise'
	OSLanguage = 'en-gb'
	OSLicense = 'Retail'
	Restart = $true
	ScreenshotCapture = $true
	SkipAutoPilot = $true
	#ZTI = $true
}

Invoke-OSDCloud
