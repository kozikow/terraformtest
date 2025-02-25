# Configure the Google Cloud provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0, < 6.0"  # Good practice to pin versions
    }
  }
}

provider "google" {
  project = var.project_id  # Use a variable for project ID
  region  = var.region      # Use a variable for region
  zone    = var.zone        # Use a variable for zone
}

# Define variables
variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
}

variable "region" {
  type        = string
  description = "The region to deploy the VM in"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The zone to deploy the VM in"
  default     = "us-central1-a"
}

variable "machine_type" {
  type        = string
  description = "The machine type of the VM"
  default     = "e2-micro" # Small and cost-effective for testing
}

variable "image_name" {
  type = string
  description = "The name of the operating system image"
  default = "debian-cloud/debian-11"
}

variable "instance_name" {
    type = string
    description = "Name of the instance"
    default = "simple-vm"
}


# Create a network
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = true # Creates a subnet in each region
}



# Create a compute instance
resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  allow_stopping_for_update = true # Allow Terraform to stop the VM for updates


  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }


  network_interface {
    network = google_compute_network.vpc_network.self_link # Use the network created above

    # Access config for external IP.  Omit to have no external IP at all.
     access_config {
       // Ephemeral IP (no `nat_ip` specified)
     }
  }

    # Very simple metadata startup script example.  Runs ONCE on creation.
    metadata_startup_script = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      EOF

}

output "instance_ip" {
    value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}
