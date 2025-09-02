provider "google" {
  project = var.project_id
  region  = var.region

  # Prefer impersonation if available
  impersonate_service_account = var.impersonate_service_account
}

variable "project_id" {}
variable "region" { default = "us-east4" }
variable "impersonate_service_account" { default = null }
