
# login as provider
az login

az deployment group create \
  -g rg-provider \
  --template-file peering.template.json \
  --parameters peering.parameters.json \
  --verbose