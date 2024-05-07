resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  project = var.project_id
  network = module.vpc-client.network_id
  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24"]
}


resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  project = var.project_id
  network = module.vpc-client.network_id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
