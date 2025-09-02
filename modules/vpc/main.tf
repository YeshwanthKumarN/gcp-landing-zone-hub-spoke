resource "google_compute_network" "custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Delete the default subnet (if exists)
resource "google_compute_subnetwork" "default" {
  name          = "default"
  network       = google_compute_network.custom_vpc.id
  region        = var.region

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [ip_cidr_range] # so deletion doesn't block on drift
  }

  # Ensure this waits until VPC exists
  depends_on = [google_compute_network.custom_vpc]
}

resource "google_compute_subnetwork" "custom_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.custom_vpc.id
}
