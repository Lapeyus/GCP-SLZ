terraform {
  required_version = ">= 1.5.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.81.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.81.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
}
