data "google_organization" "org" {
  domain = "ownerpower.com"
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}