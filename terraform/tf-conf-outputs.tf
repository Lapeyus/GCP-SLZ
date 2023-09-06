output "terraform_seed_sa" {
  description = "The email address of the service account created for seeding Terraform."
  value       = google_service_account.main.email
}

# This key is only used during initial manual bootstrapping
# output "private_key" {
#   description = "The private key for the service account. Handle with care as it's sensitive."
#   value       = google_service_account_key.main.private_key
#   sensitive   = true
# }

output "seed" {
  description = "The seeded organization project module. All properties"
  value       = module.seed
}

output "cicd" {
  description = "The organization's CI/CD project module. All properties"
  value       = module.cicd
}

output "network" {
  description = "The shared VPC host project module. All properties"
  value       = module.network
}

output "preprod_vpc" {
  description = "The shared VPC for the pre-production environment. All properties"
  value       = module.preprod_vpc
}

output "prod_vpc" {
  description = "The shared VPC for the production environment. All properties"
  value       = module.prod_vpc
}

output "preprod_vpcconn" {
  description = "The VPC access connector for the pre-production environment."
  value       = google_vpc_access_connector.preprod
}

output "prod_vpcconn" {
  description = "The VPC access connector for the production environment."
  value       = google_vpc_access_connector.prod
}


# output "owner_projects" {
#   description = "A merged map of all owner projects: projecta, curated, and trans projects. All properties"
#   value = merge(
#     module.owner_projecta_projects,
#     module.owner_curated_projects,
#     module.owner_trans_projects
#   )
# }

# output "owner_project_groups" {
#   description = "The GCP groups associated with each owner project."
#   value       = module.project_groups
# }
