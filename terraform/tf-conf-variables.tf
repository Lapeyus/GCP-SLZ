variable "owner" {
  type    = string
  default = "clientname"
}

variable "org_id" {
  type    = string
  default = "137946739361"
}

variable "billing_account" {
  type    = string
  default = "012F00-93BFC2-44CBB0"
}

variable "activate_apis" {
  type = map(list(string))
  default = {
    seed = [
      "cloudidentity.googleapis.com",
      "orgpolicy.googleapis.com",
      "servicenetworking.googleapis.com",
      "cloudbilling.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "serviceusage.googleapis.com",
      "iam.googleapis.com",
      "iamcredentials.googleapis.com",
      "seprojectbitycenter.googleapis.com",
      "billingbudgets.googleapis.com",
      "pubsub.googleapis.com",
      "vpcaccess.googleapis.com",
      "compute.googleapis.com"
    ]
    Billing = [
      "compute.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "pubsub.googleapis.com",
      "billingbudgets.googleapis.com"
    ]
    Network = [
      "servicenetworking.googleapis.com",
      "compute.googleapis.com",
      "vpcaccess.googleapis.com",
      "container.googleapis.com"
    ]
    owner-projecta = [
      "compute.googleapis.com",
      "run.googleapis.com",
    ]
    owner-projectb = [
      "compute.googleapis.com",
      "bigquery.googleapis.com",
    ]
    owner-projectc = [
      "compute.googleapis.com",
      "bigquery.googleapis.com",
      "composer.googleapis.com",
      "container.googleapis.com",
      "secretmanager.googleapis.com",
      "dataform.googleapis.com"
    ]
    CICD = [
      "cloudbuild.googleapis.com",
      "artifactregistry.googleapis.com"
    ]
  }
}
