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