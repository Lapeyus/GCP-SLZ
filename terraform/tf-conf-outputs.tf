output "terraform-seed-sa" {
  description = "The email address of the service account created for seeding Terraform."
  value       = google_service_account.service_account.email
}

# This key is only used during initial manual bootstrapping
# output "private_key" {
#   description = "The private key for the service account. Handle with care as it's sensitive."
#   value       = google_service_account_key.account_key.private_key
#   sensitive   = true
# }

output "org_seed_project" {
  description = "The seeded organization project module. All properties"
  value       = module.org_seed_project
}

output "org_cicd_project" {
  description = "The organization's CI/CD project module. All properties"
  value       = module.cicd
}

output "shared_vpc_project" {
  description = "The shared VPC host project module. All properties"
  value       = module.shared_vpc_host_project
}

output "owner_projects" {
  description = "A merged map of all owner projects: projecta, curated, and trans projects. All properties"
  value = merge(
    module.owner_projecta_projects,
    module.owner_curated_projects,
    module.owner_trans_projects
  )
}

output "owner_project_groups" {
  description = "The GCP groups associated with each owner project."
  value       = module.project_groups
}

output "vpcconn-preprod" {
  description = "The VPC access connector for the pre-production environment."
  value       = google_vpc_access_connector.vpcconn-preprod
}

output "vpcconn-prod" {
  description = "The VPC access connector for the production environment."
  value       = google_vpc_access_connector.vpcconn-prod
}

output "preprod_vpc_shared_vpc_host" {
  description = "The shared VPC for the pre-production environment. All properties"
  value       = module.preprod_vpc_shared_vpc_host
}

output "prod_vpc_shared_vpc_host" {
  description = "The shared VPC for the production environment. All properties"
  value       = module.prod_vpc_shared_vpc_host
}
