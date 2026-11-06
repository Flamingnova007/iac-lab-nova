variable "resource_group_name" {
  description = "Existing resource group, set with the TF_VAR_resource_group_name environment variable"
  type        = string
}

variable "location" {
  type    = string
  default = "uaenorth"
}

variable "storage_account_name" {
  description = "Globally unique, 3 to 24 lowercase letters and numbers"
  type        = string
  default     = "arshiacstorage01"
}

variable "tags" {
  type = map(string)
  default = {
    Owner     = "Arsh"
    Week      = "9"
    ManagedBy = "Terraform"
  }
}
