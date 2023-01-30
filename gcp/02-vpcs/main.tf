resource "google_compute_network" "auto_vpc" {
  name                    = "auto-vpc"
  # Create a subnet in each region
  auto_create_subnetworks = true
}

resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork-east" {
  ip_cidr_range            = "10.1.0.0/24"
  name                     = "sub-east"
  region                   = "us-east1"
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnetwork-central" {
  ip_cidr_range            = "10.2.0.0/24"
  name                     = "sub-central"
  region                   = "us-central1"
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp"
  network = google_compute_network.custom_vpc.id
  allow {
    protocol = "ICMP"
  }
  source_ranges = ["181.170.109.131"]
}