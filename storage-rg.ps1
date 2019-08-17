#$companyName = "Dunder Mifflin Paper"
#$companyShortName = "df"
$rgName = "storage-dev-rg"
$location = "eastus"
$env = "dev"

#---Create resource group
Write-Host "Create resource group: $rgName" -ForegroundColor green
New-AzResourceGroup -Name $rgName `
    -Location $location `
    -Tag @{LoB="platform"; CostCenter="IT"; Env=$env}


#---Create storage account (Can't create ADLS Gen2 as it isn't yet supported by the API)
Write-Host "Create storage account" -ForegroundColor green
Write-Information -MessageData "Create Create storage account"
$storageAccount = New-AzStorageAccount -Name "dfdata001" `
    -ResourceGroupName $rgName `
    -Location $location `
    -Kind "StorageV2" `
    -SkuName "Standard_LRS" `
    -AccessTier "Hot" `
    -Tag @{LoB="platform"; CostCenter="IT"; Env=$env}


#---Blob: Create container
Write-Host "Blob: Create container" -ForegroundColor green
New-AzStorageContainer -Container "datasets" `
    -Context $storageAccount.Context


#---Queue: Create 2 queues
Write-Host "Queue: Create 2 queues" -ForegroundColor green
New-AzStorageQueue -Name "citibikenyc-q" `
    -Context $storageAccount.Context

New-AzStorageQueue -Name "flight-q" `
    -Context $storageAccount.Context


#---Table: Create 2 tables
Write-Host "Table: Create 2 tables" -ForegroundColor green
New-AzStorageTable -Name "citibikenyctbl" `
    -Context $storageAccount.Context

New-AzStorageTable -Name "flighttbl" `
    -Context $storageAccount.Context

#Remove-AzResourceGroup $rgName