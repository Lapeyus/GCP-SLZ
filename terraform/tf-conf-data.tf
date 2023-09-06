data "google_organization" "org" {
  domain = "altuspower.com"
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}
