 terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }
}

provider "google" {
  project = "learn-terraform-376103"
  region = "us-east1"
  zone = "us-east1-a"
  credentials = "tf-gcp-service-account.json"
}