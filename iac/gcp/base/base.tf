terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = file("/home/dare/workspace/creds/gcp_terraform_sandbox_0ddf5d0aa8f5.json")

  project = "sandbox-302518"
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "http" "base-infra-script" {
  url = "https://raw.githubusercontent.com/benny-sec/infra-config/main/basic-infra-config.sh"
}

resource "google_compute_address" "vm_static_ip" {
  name = "rev-shell-static-ip"
}

resource "google_compute_instance" "bamboo_instance" {
  name         = "bamboo-server"
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
    content     = data.http.base-infra-script.body
    destination = "/tmp/script.sh"
    
    connection {
        type        = "ssh"
        user        = "blackhawk"
        private_key = file("/home/dare/workspace/creds/google-cloud-def-key")
        host        = google_compute_instance.bamboo_instance.network_interface[0].access_config[0].nat_ip
    } 


  }  

  provisioner "remote-exec" {
    connection {
        type        = "ssh"
        user        = "blackhawk"
        private_key = file("/home/dare/workspace/creds/google-cloud-def-key")
        host        = google_compute_instance.bamboo_instance.network_interface[0].access_config[0].nat_ip
    } 
    
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]
  }
}

resource "google_compute_instance" "rev_shell_instance" {
  name         = "rev-shell"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210211"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }
}

output "static_ip_revshell" {
    value =  google_compute_address.vm_static_ip.address
}
output "ip_bamboo_server" {
    value =  google_compute_instance.bamboo_instance.network_interface[0].access_config[0].nat_ip
}






