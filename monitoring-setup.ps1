# Variables
$resourceGroup = "modern-rg"
$webApp = "modern-webapp"
$location = "westeurope"
$appInsights = "modern-ai"
$alertRule = "HighCPUAlert"

# Create Application Insights
az monitor app-insights component create `
  --app $appInsights `
  --location $location `
  --resource-group $resourceGroup `
  --application-type web

# Link App Insights to Web App
az webapp config appsettings set `
  --name $webApp `
  --resource-group $resourceGroup `
  --settings "APPINSIGHTS_INSTRUMENTATIONKEY=$(az monitor app-insights component show --app $appInsights --resource-group $resourceGroup --query instrumentationKey -o tsv)"

# Create CPU Alert Rule (when average CPU > 80% over 5 minutes)
az monitor metrics alert create `
  --name $alertRule `
  --resource-group $resourceGroup `
  --scopes $(az webapp show --name $webApp --resource-group $resourceGroup --query id -o tsv) `
  --description "Alert when CPU usage is high" `
  --condition "avg CPUPercentage > 80" `
  --window-size 5m `
  --evaluation-frequency 1m `
  --action-group "" # Add your action group resource ID here if you want notifications

Write-Host "Monitoring and CPU alert rule set up for $webApp."
