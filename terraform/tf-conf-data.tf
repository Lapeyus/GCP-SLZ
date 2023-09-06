data "google_organization" "org" {
  domain = "owner.com"
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}
