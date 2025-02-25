resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
          image = "debian-cloud/debian-11"
              size  = var.disk_size
     }
  }

  network_interface {
    network = "default"
    access_config {
     // Ephemeral public IP
    }
  }

  tags = ["allow-ssh"]
}
