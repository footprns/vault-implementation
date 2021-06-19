resource "google_compute_network" "vpc-network" {
  name                    = "infra-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc-network-subnet" {
  name          = "infra01-subnetwork"
  ip_cidr_range = var.shared_vpc_cidr
  region        = "asia-southeast2"
  network       = google_compute_network.vpc-network.id
  secondary_ip_range {
    range_name    = "pod-subnet"
    ip_cidr_range = var.cluster_ipv4_cidr
  }
  secondary_ip_range {
    range_name    = "service-subnet"
    ip_cidr_range = var.services_ipv4_cidr
  }
}
