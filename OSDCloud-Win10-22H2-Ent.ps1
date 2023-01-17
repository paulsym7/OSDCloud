Write-Output 'Making sure the latest OSD module is installed'
Install-Module -Name OSD -Force
Import-Module -Name OSD -Force
Write-Output 'Starting OSD Cloud...'
Write-Output 'Installing Windows 10 22H2 Enterprise'
<#
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
Start-OSDCloud @params
#>

$Params = @{
    OSVersion   = 'Windows 10'
    OSBuild     = '22H2'
    OSLicense   = 'Retail'
    OSLanguage  = 'en-gb'
}
$FeatureUpdate = Get-FeatureUpdate @Params
$OSDImageFile = Find-OSDCloudFile -Name $FeatureUpdate.FileName -Path '\OSDCloud\OS\' | Sort-Object FullName | Where-Object {$_.Length -gt 3GB}
$ImageFileItem = $OSDImageFile | Where-Object {$_.FullName -notlike "C*"} | Where-Object {$_.FullName -notlike "X*"} | Select-Object -First 1
Write-Output "Using '$ImageFileItem' as the image file item."

$Global:MyOSDCloud = @{
	ImageFileItem = $ImageFileItem
	ImageFileName = $FeatureUpdate.FileName
	ImageFileUrl = $FeatureUpdate.FileUri
        MSCatalogFirmware = $false
        #MSCatalogDiskDrivers = $false
        #MSCatalogNetDrivers = $false
        #MSCatalogScsiDrivers = $false
	OSBuild = '22H2'
	OSEdition = 'Enterprise'
	OSLanguage = 'en-gb'
	OSLicense = 'Retail'
	Restart = $true
	SkipAutoPilot = $true
	#ZTI = $true
}

Invoke-OSDCloud

