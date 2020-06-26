<#
.SYNOPSIS
    Removes sample infrastructure using Azure CLI
.DESCRIPTION
    Prerequisites:
    - Azure Subscription
    - Azure CLI installed
.PARAMETER tenantDomain
    target Azure AD Tenant
.PARAMETER user
    Admin account name
.PARAMETER password
    Admin account password
.EXAMPLE
    D:\> .\Remove-Infrastructure.ps1 `
    -tenantDomain 'xxxxoutlook.onmicrosoft.com' `
    -password 'xxxxxxxx'
.NOTES
    Author: Nikolay Mozgovoy
    Date:   June, 2020
#>

param (
	[string] $tenantDomain,
	[string] $user,
	[string] $password,
	[string] $rgName = 'fp-test')

# note that az command results are objects ready to use
#$tenantId = 'd9a85028-879d-4d11-9bdb-7fd464d81cbd'; # option 1
# $tenantDomain = 'distanttraveloutlook.onmicrosoft.com' # option 2
# $user = 'test.admin@distanttraveloutlook.onmicrosoft.com'
# $password = '!Beaver2506' # never store in script

#az login --tenant $tenantId
az login `
--tenant $tenantDomain `
--user $user `
--password $password

# remove resource group
az group delete --name $rgName