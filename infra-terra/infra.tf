provider "azurerm" {
    features {}

     tenant_id = var.tenant_id
     subscription_id = var.subscription_id
}

#create a resource group
resource "azurerm_resource_group" "resource_group" {
    name     = var.resource_group_name
    location = var.location
}

resource "azurerm_kubernetes_cluster" "example" {
    name                = var.aks_cluster_name
    location            = azurerm_resource_group.resource_group.location
    resource_group_name = azurerm_resource_group.resource_group.name
    dns_prefix          = var.dns_prefix

    default_node_pool {
        name       = "clusteraks1"
        node_count = var.node_count
        vm_size    = var.vm_size
    }

    identity {
        type = "SystemAssigned"
    }
}

provider "kubernetes" {
    host                   = azurerm_kubernetes_cluster.example.kube_config[0].host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.example.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.example.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.example.kube_config[0].cluster_ca_certificate)
}

resource "kubernetes_namespace" "example" {
    metadata {
        name = "example"
    }
}

resource "kubernetes_deployment" "example" {
    metadata {
        name      = "example-deployment"
        namespace = kubernetes_namespace.example.metadata[0].name
    }

    spec {
        replicas = 1

        selector {
            match_labels = {
                app = "example"
            }
        }

        template {
            metadata {
                labels = {
                    app = "example"
                }
            }

            spec {
        container {
          name  = "example-container"
          image = "docker.io/${var.docker_username}/repodevops:latest"
          
          resources {
            limits = {
              cpu    = "0.5"
              memory = "1.5Gi"
            }
            requests = {
              cpu    = "0.5"
              memory = "1.5Gi"
            }
          }
                    port {
                        container_port = 80
                        protocol       = "TCP"
                    }
                }
            }
        }
    }
}

resource "kubernetes_service" "example" {
    metadata {
        name      = "example-service"
        namespace = kubernetes_namespace.example.metadata[0].name
    }

    spec {
        selector = {
            app = "example"
        }

        port {
            port        = 80
            target_port = 80
            protocol    = "TCP"
        }

        type = "LoadBalancer"
    }
}