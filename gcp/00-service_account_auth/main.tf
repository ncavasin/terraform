terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }
}

provider "google" {
  # Configuration options

  # Project ID
  project = "learn-terraform-376103"
  region = "us-east1"
  zone = "us-east1-a"
  credentials = "tf-gcp-service-account.json"
}

resource "google_storage_bucket" "storage_bucket" {
  location = ""
  name     = "bucket-created-with-terraform"
}