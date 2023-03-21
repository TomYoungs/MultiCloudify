resource "google_compute_subnetwork" "example_subnet" {
  name          = "example-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.example_network.self_link
}