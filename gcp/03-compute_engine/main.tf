resource "random_pet" "random_disk_name" {
  length = 1
}

resource "random_pet" "random_vm_name" {
  length = 3
}

resource "google_compute_network" "custom_vpc" {
  name                    = "vms-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork-east-1" {
  ip_cidr_range            = "10.1.0.0/24"
  name                     = "sub-east-1"
  region                   = "us-east1"
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnetwork-east-2" {
  ip_cidr_range            = "10.2.0.0/24"
  name                     = "sub-east-2"
  region                   = "us-east1"
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnetwork-east-3" {
  ip_cidr_range            = "10.3.0.0/24"
  name                     = "sub-east-3"
  region                   = "us-east1"
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "default" {
  name    = "vms-firewall"
  network = google_compute_network.custom_vpc.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_disk" "vm-disk" {
  name = random_pet.random_disk_name.id
  type = "pd-ssd"
  size = 15
  zone = "us-east1-b"
}

resource "google_compute_instance" "virtual_machine" {
  name                      = random_pet.random_vm_name.id
  machine_type              = "n1-standard-2"
  zone                      = "us-east1-b"
  allow_stopping_for_update = true
  labels                    = { "env" : "dev", "department" : "sre" }
  network_interface {
    network    = google_compute_network.custom_vpc.id
    subnetwork = google_compute_subnetwork.subnetwork-east-1.id
  }
  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20221206"
      size  = 35
    }
    # Avoids disk deletion when instance gets deleted
    auto_delete = false
  }
  scheduling {
    preemptible       = false
    automatic_restart = false
  }
  service_account {
    email  = "tf-gcp@learn-terraform-376103.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  # Required per the documentation
  lifecycle {
    ignore_changes = [attached_disk]
  }
}

# Attach created ssd with virtual machine
resource "google_compute_attached_disk" "vm-disk" {
  disk     = google_compute_disk.vm-disk.id
  instance = google_compute_instance.virtual_machine.id
}