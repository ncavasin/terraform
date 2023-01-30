#resource "google_compute_network" "auto_vpc" {
#  name                    = "auto-vpc"
#  # Create a subnet in each region
#  auto_create_subnetworks = true
#}

resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}