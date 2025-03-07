az login
az account set --subscription "your-subscription-name"
az group create --name myResourceGroup --location eastus
az storage account create --name myfuncstorageaccount --location eastus --resource-group myResourceGroup --sku Standard_LRS
az functionapp create --resource-group myResourceGroup --consumption-plan-location eastus \
  --runtime python --runtime-version 3.9 \
  --functions-version 4 \
  --name myFastApiApp \
  --storage-account myfuncstorageaccount
#az functionapp deployment source config-zip --resource-group myResourceGroup --name myFastApiApp --src myFastApiApp.zip

#install func core tools
# setup locally
func init --worker-runtime python
func new --name HttpTrigger --template "HTTP trigger"


# deploy to azure
func azure functionapp publish myFastApiApp
az functionapp log tail --name myFastApiApp --resource-group myResourceGroup
az functionapp show --name myFastApiApp --resource-group myResourceGroup --query defaultHostName --output tsv
curl https://<your-function-app-name>.azurewebsites.net/api/HttpTrigger


func azure functionapp publish myFastApiApp

az functionapp show --name npflserver --resource-group npfl-api-rg


---
az functionapp config appsettings set \
  --name npflserver \
  --resource-group npfl-api-rg \
  --settings APPINSIGHTS_INSTRUMENTATIONKEY=<your-instrumentation-key>



