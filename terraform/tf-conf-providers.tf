terraform {
  required_version = "1.5.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.78.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

provider "google" {
  project = "owner-seed-001"
  region  = "us-east1"
  zone    = "us-east1-c"
}

provider "google-beta" {
  project = "owner-seed-001"
  region  = "us-east1"
  zone    = "us-east1-c"
}
