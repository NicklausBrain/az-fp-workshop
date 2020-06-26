<#
.SYNOPSIS
    Creates sample infrastructure using Azure CLI
.DESCRIPTION
    Prerequisites:
    - Azure Subscription
    - Azure CLI installed
.PARAMETER branch
    target branch to release
.PARAMETER push
    confirm push to the remote
.EXAMPLE
	D:\> .\Create-Infrastructure.ps1 `
	-tenantDomain 'xxxx.onmicrosoft.com' `
	-user 'xxxxoutlook.onmicrosoft.com' `
	-password 'xxxxxxxx'
.NOTES
    Author: Nikolay Mozgovoy
    Date:   June, 2020
#>

param (
	[string] $tenantDomain,
	[string] $user,
	[string] $password,
	[string] $gitUrl = 'https://github.com/NicklausBrain/SnakeGame',
	[string] $gitBranch = 'master')

#$tenantId = 'd9a85028-879d-4d11-9bdb-7fd464d81cbd'; # option 1
#az login --tenant $tenantId
# note that az command results are objects ready to use
az login `
	--tenant $tenantDomain `
	--user $user `
	--password $password

# az account list-locations
# create resource group
$rgName = 'fp-test';
az group create `
	--location 'westeurope' `
	--name $rgName

# create app service
az appservice plan create `
	--name 'fp-test' `
	--resource-group $rgName `
	--sku 'SHARED' # explain it

# create web app
az webapp create `
	--name 'fp-test' `
	--plan 'fp-test' `
	--resource-group $rgName `
	--deployment-source-url $gitUrl `
	--deployment-source-branch $gitBranch

# az webapp deployment source show --resource-group 'fp-test' --name 'fp-test'
# az webapp delete `
# --name 'fp-test' `
# --resource-group $rgName
# az group delete --name $rgName