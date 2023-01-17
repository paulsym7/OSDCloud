Write-Output 'Making sure latest OSD module is installed'
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
  ZTI = $false
}
Start-OSDCloud @params
