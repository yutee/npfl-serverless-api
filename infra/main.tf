# main.tf - Terraform configuration for creating Azure resources

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# cosmosdb for storing club details
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  free_tier_enabled   = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "database" {
  name                = "npfl-db"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "clubs" {
  name                   = "clubs"
  resource_group_name    = azurerm_resource_group.rg.name
  account_name           = azurerm_cosmosdb_account.cosmosdb.name
  database_name          = azurerm_cosmosdb_sql_database.database.name
  partition_key_paths    = ["/club"]
}

# storage for club logos
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "logos" {
  name                  = "logos"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}

# upload images from local machine to the container
resource "azurerm_storage_blob" "images" {
  for_each               = fileset("../data/logos", "*_logo.png")
  name                   = each.value
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.logos.name
  type                   = "Block"
  source                 = "../data/logos/${each.value}"
}

# function app for Serverless api
resource "azurerm_storage_account" "function_storage" {
  name                     = "${var.function_app_name}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "function_plan" {
  name                = "npfl-functions-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function_app" {
  name                       = var.function_app_name
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  service_plan_id            = azurerm_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }
}