variable "prefix" {
  description = "The prefix used for all resources in this example"
  default = "tf-fyi"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  default = "East US"
}

variable "environment" {
  description = "The envrironment"
  default = "development"
}

variable "sql_user" {
  description = "The Azure sql server user"
}

variable "sql_password" {
  description = "The Azure sql server password"
}
