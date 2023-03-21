resource "google_compute_instance" "example_instance" {
  name         = "example-instance"
  machine_type = "f1-micro" # replace with your desired machine type
  zone         = "us-west1-a" # replace with your desired zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10" # replace with your desired OS image
    }
  }

  network_interface {
    network = google_compute_network.example_network.self_link
    subnetwork = google_compute_subnetwork.example_subnet.self_link
  }

  tags = ["example-tag"]
}