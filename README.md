# Introduction 
These templates are modified versions of the [Azure Lighthouse samples]([Azure Lighthouse samples](https://docs.microsoft.com/en-us/azure/lighthouse/samples/)). Refer to [Onboard a customer to Azure Lighthouse](https://docs.microsoft.com/en-us/azure/lighthouse/how-to/onboard-customer) for further additional information.

# Deploying Templates
## Prerequisites
1. A tenant and Azure subscription representing the service provider.
2. A tenant and Azure subscription representing the customer.
3. Azure CLI must be installed if deploying from a local machine.
4. The customer subscription must have an existing resource group that will be targeted for delegation. The ARM templates use a default resource group name value of "rg-customer".
5. The provider subscription must have an existing empty virtual network. The ARM templates use default values of "vnet-provider" and "rg-customer" for VNET and resource group respectively.

## Deployment steps
1. Clone or download the repository on your local machine or Azure cloud shell.
2. Navigate to the /templates/delegation folder and replace the the following values within the rgDelegatedResourceManagement.parameters.json file:
- managedByTenantId - this is the service provider's tenant Id (unique identifier)
- principalId - provide at least one set of authorization values. The recommended practice is to create corresponding Azure Active Directory security groups. Use the Object Id of the security group.
4. From a terminal of your choice (local or cloud shell), log in on the customer subscription with a user that has the built-in <b>Owner</b> role. Execute the following command (the delegation may take a few minutes before becoming visible within the Azure portal of the provider subscription):
```
az deployment sub create \
    --name "MyDelegatedResourceDeployment" \
    --location WestUS2 \
    --template-file rgDelegatedResourceManagement.json \
    --parameters rgDelegatedResourceManagement.parameters.json \
    --verbose
```
5. Navigate to the /templates/peering folder and replace the following values within the peering.templates.json file:
-  remoteSubscriptionId - replace with the customer/remote subscription Id
-  localSubscriptionId - replace with the provider/local subscription Id

## Cross-Tenant Private Link
Configure private link from the provider subscription that targets a SQL Server (PaaS) instance on the customer subscription using [Quickstart: Create a private endpoint using Azure CLI](https://docs.microsoft.com/en-us/azure/private-link/create-private-endpoint-cli).