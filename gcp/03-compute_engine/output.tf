output "vpc-name" {
  value = "VPC name is: '${google_compute_network.custom_vpc.name}'"
}

output "subnetwork-1" {
  value = "Subnetwork-1 CIDR is: ${google_compute_subnetwork.subnetwork-east-1.ip_cidr_range}"
}

output "subnetwork-2" {
  value = "Subnetwork-2 CIDR is: ${google_compute_subnetwork.subnetwork-east-2.ip_cidr_range}"
}

output "subnetwork-3" {
  value = "Subnetwork-3 CIDR is: ${google_compute_subnetwork.subnetwork-east-3.ip_cidr_range}"
}

output "firewall" {
  value = "Firewall name is: ${google_compute_firewall.default.name}"
}

output "disk" {
  value = "SSD name is: ${google_compute_disk.vm-disk.name}"
}

output "instance" {
  value = "Instance name is: ${google_compute_instance.virtual_machine.name}"
}
