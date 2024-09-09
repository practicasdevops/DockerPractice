variable "subscription_id" {
    description = "The subscription ID for Azure"
    type        = string
}

variable "tenant_id" {
    description = "The tenant ID for Azure"
    type        = string
}

variable "docker_username" {
    description = "The Docker registry username"
    type        = string
}

variable "docker_password" {
    description = "The Docker registry password"
    type        = string
    sensitive   = true
}

variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
    default     = "DevOpsAKSRG"
}

variable "location" {
    description = "The Azure region to deploy resources"
    type        = string
    default     = "East US"
}

variable "aks_cluster_name" {
    description = "The name of the AKS cluster"
    type        = string
    default     = "exampleaks"
}

variable "dns_prefix" {
    description = "The DNS prefix for the AKS cluster"
    type        = string
    default     = "exampleaks"
}

variable "node_count" {
    description = "The number of nodes in the AKS cluster"
    type        = number
    default     = 1
}

variable "vm_size" {
    description = "The size of the VMs in the AKS cluster"
    type        = string
    default     = "Standard_DS2_v2"
}