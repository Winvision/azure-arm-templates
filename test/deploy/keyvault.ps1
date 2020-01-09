$templateFile = "../../keyvault.json"
$rgName = "wvarmtemp"
$keyVaultName = "wvarmtemp"

# New-AzResourceGroup -Name $rgName -Location "westeurope"
New-AzResourceGroupDeployment `
    -ResourceGroupName $rgName `
    -TemplateFile $templateFile `
    -nameFromTemplate $keyVaultName
