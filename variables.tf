variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Name for the GCE instance"
  type        = string
  default = "codelab-instance"
}

variable "machine_type" {
  description = "Machine type for the GCE instance"
  type        = string
  default = "e2-medium"
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default = 10
}

