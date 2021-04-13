terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

variable "server-name" {
  type = string
}

provider "google" {

  credentials = file("/home/dare/workspace/creds/gcp_terraform_sandbox_0ddf5d0aa8f5.json")

  project = "sandbox-302518"
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "http" "basic-infra-script" {
  url = "https://raw.githubusercontent.com/benny-sec/infra-config/main/basic-infra-config.sh"
}

resource "google_compute_instance" "base_compute_instance" {
  name         = var.server-name
  machine_type = "e2-standard-2"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210211"
      type = "pd-ssd"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  provisioner "file" {
    content     = data.http.basic-infra-script.body
    destination = "/tmp/script.sh"
    
    connection {
        type        = "ssh"
        user        = "blackhawk"
        private_key = file("/home/dare/workspace/creds/google-cloud-def-key")
        host        = google_compute_instance.base_compute_instance.network_interface[0].access_config[0].nat_ip
    } 


  }  

  provisioner "remote-exec" {
    connection {
        type        = "ssh"
        user        = "blackhawk"
        private_key = file("/home/dare/workspace/creds/google-cloud-def-key")
        host        = google_compute_instance.base_compute_instance.network_interface[0].access_config[0].nat_ip
    } 
    
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]
  }
}

output "ip_remote_server" {
    value =  google_compute_instance.base_compute_instance.network_interface[0].access_config[0].nat_ip
}






