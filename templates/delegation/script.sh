#
# log in on customer account
#
az login

#
# can be executed locally or in Azure cloud shell
#
az deployment sub create \
    --name "Intergalactic-Deployment" \
    --location WestUS2 \
    --template-file rgDelegatedResourceManagement.json \
    --parameters rgDelegatedResourceManagement.parameters.json \
    --verbose