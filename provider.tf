terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "78b86be0-6f19-4552-88d4-f12345bea95d"
  tenant_id       = "bcf7e359-c4cc-4f7a-8590-b9c3ea27e2f3"
  client_id       = "125381ce-2451-435d-ab57-7e781754304f"
  client_secret   = "pW68Q~MVoDnWd2zdmqXq-iv2AhPJjWdcRlexMcCM"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azuread" {
   tenant_id       = "bcf7e359-c4cc-4f7a-8590-b9c3ea27e2f3"
  client_id       = "125381ce-2451-435d-ab57-7e781754304f"
  client_secret   = ".Dv8Q~Sn6Yi9fY4uSVCkDdWUqS3aYRtVGBlsabuf"
}