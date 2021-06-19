module "kubernetes-engine_private-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "15.0.0"
  # insert the 9 required variables here
  project_id        = "imank-vault"
  region            = "asia-southeast2"
  name              = "vault-cluster"
  network           = google_compute_network.vpc-network.name
  subnetwork        = google_compute_subnetwork.vpc-network-subnet.name
  ip_range_pods     = "pod-subnet"
  ip_range_services = "service-subnet"
  # optional variable
  zones                    = ["asia-southeast2-a", "asia-southeast2-b", "asia-southeast2-c"]
  http_load_balancing      = true
  enable_private_endpoint  = true
  enable_private_nodes     = true
  master_authorized_networks = [{
        cidr_block   = var.shared_vpc_cidr
        display_name = "shared_vpc_cidr"
      }]
  # master_ipv4_cidr_block   = var.gke_master_cidr
  remove_default_node_pool = true
  
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-small"
      node_locations     = "asia-southeast2-a,asia-southeast2-b,asia-southeast2-c"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      disk_size_gb       = 40
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "76174897788-compute@developer.gserviceaccount.com"
      preemptible        = true
      initial_node_count = 1
    },
  ]
  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
