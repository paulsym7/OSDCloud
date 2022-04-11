[CmdletBinding()]
param(
    [System.String]$Customer = 'nwl',

    [ValidateSet('Windows-10','Windows-11')]
    [System.String]$OS = 'Windows-10',

    [System.String]$Version = '21H2'
)

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module Az.Storage
$Storage = Invoke-RestMethod -Uri "https://virtualengine.azure-api.net/imagebuilder/customers?subscription-key=cb79e9127b7b4eada94183260bda5841&customercode=$($Customer.ToLower())" -ErrorAction Stop
$Context = New-AzStorageContext -StorageAccountName $Storage.StorageAccount -SasToken $Storage.StorageAccountSasToken
$ImageFile = Get-AzStorageFile -ShareName image -Context $Context | Where-Object{$_.Name -like "*$OS*$Version*.wim"} | Sort-Object -Property Name -Descending | Select-Object -First 1
$FileUri = $ImageFile.CloudFile.Uri.AbsoluteUri
$DownloadUri = '{0}{1}' -f $FileUri,$Storage.StorageAccountReadOnlySasToken
Start-OSDCloud -ImaeFileUrl $DownloadUri
