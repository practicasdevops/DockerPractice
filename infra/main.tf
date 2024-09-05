provider "azurerm" {
    features {}

     tenant_id = var.tenant_id
     subscription_id = var.subscription_id
}

#Create a resourse group
resource "azurerm_resource_group" "resource_group" {
    name     = "Practica_DevOps"
    location = "East US"
}
#Create a container instance
resource "azurerm_container_group" "container_group" {
    name                = "container-group"
    location            = azurerm_resource_group.resource_group.location
    resource_group_name = azurerm_resource_group.resource_group.name
    os_type             = "Linux"

    container {
        name   = "container"
        image  = "docker.io/acarrilloclever/repodevops:latest"
        cpu    = "0.5"
        memory = "1.5"
        ports {
            port     = 80
            protocol = "TCP"
        }
    }
    dns_name_label = "mycustomdomain"  # Cambia esto por el nombre de dominio que desees

   image_registry_credential {
        server   = "docker.io"
        username = var.docker_username
        password = var.docker_password
    }

    tags = {
        environment = "staging"
    }
}
