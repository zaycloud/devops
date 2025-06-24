#!/bin/bash

# Variables
RESOURCE_GROUP="modern-rg"
LOCATION="westeurope"
APP_SERVICE_PLAN="modern-asp"
WEB_APP="modern-webapp"

# Create Resource Group
echo "Creating Resource Group: $RESOURCE_GROUP in $LOCATION..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create App Service Plan (Free tier)
echo "Creating App Service Plan: $APP_SERVICE_PLAN (Free tier) in $RESOURCE_GROUP..."
az appservice plan create --name $APP_SERVICE_PLAN --resource-group $RESOURCE_GROUP --location $LOCATION --sku F1

# Create Web App
echo "Creating Web App: $WEB_APP in $RESOURCE_GROUP using $APP_SERVICE_PLAN..."
az webapp create --name $WEB_APP --resource-group $RESOURCE_GROUP --plan $APP_SERVICE_PLAN

echo "Azure resources created successfully."
