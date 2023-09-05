<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.58.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.78.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.58.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit-admins"></a> [audit-admins](#module\_audit-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_audit_admins"></a> [audit\_admins](#module\_audit\_admins) | terraform-google-modules/group/google | 0.4.0 |
| <a name="module_billing_project"></a> [billing\_project](#module\_billing\_project) | terraform-google-modules/project-factory/google | 14.2.0 |
| <a name="module_budget_preprod_projects"></a> [budget\_preprod\_projects](#module\_budget\_preprod\_projects) | terraform-google-modules/project-factory/google//modules/budget | 14.3.0 |
| <a name="module_budget_prod_projects"></a> [budget\_prod\_projects](#module\_budget\_prod\_projects) | terraform-google-modules/project-factory/google//modules/budget | 14.3.0 |
| <a name="module_cicd"></a> [cicd](#module\_cicd) | terraform-google-modules/project-factory/google | 14.2.0 |
| <a name="module_cicd_tf_state"></a> [cicd\_tf\_state](#module\_cicd\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 4.0 |
| <a name="module_cloud-nat"></a> [cloud-nat](#module\_cloud-nat) | terraform-google-modules/cloud-nat/google | 4.0.0 |
| <a name="module_cloud-nat-prod"></a> [cloud-nat-prod](#module\_cloud-nat-prod) | terraform-google-modules/cloud-nat/google | 4.0.0 |
| <a name="module_disable_guest_attributes"></a> [disable\_guest\_attributes](#module\_disable\_guest\_attributes) | ../modules/org-policy | n/a |
| <a name="module_disable_service_account_key_creation"></a> [disable\_service\_account\_key\_creation](#module\_disable\_service\_account\_key\_creation) | ../modules/org-policy | n/a |
| <a name="module_disable_service_account_key_upload"></a> [disable\_service\_account\_key\_upload](#module\_disable\_service\_account\_key\_upload) | ../modules/org-policy | n/a |
| <a name="module_disable_vm_nested_virtualization"></a> [disable\_vm\_nested\_virtualization](#module\_disable\_vm\_nested\_virtualization) | ../modules/org-policy | n/a |
| <a name="module_disable_vm_serial_ports"></a> [disable\_vm\_serial\_ports](#module\_disable\_vm\_serial\_ports) | ../modules/org-policy | n/a |
| <a name="module_domain_restricted_sharing"></a> [domain\_restricted\_sharing](#module\_domain\_restricted\_sharing) | ../modules/org-policy | n/a |
| <a name="module_enforce_bucket_public_access_prevention"></a> [enforce\_bucket\_public\_access\_prevention](#module\_enforce\_bucket\_public\_access\_prevention) | ../modules/org-policy | n/a |
| <a name="module_firewall_policy"></a> [firewall\_policy](#module\_firewall\_policy) | ../modules/network-firewall-policy | n/a |
| <a name="module_folders"></a> [folders](#module\_folders) | ../modules/google_folder | n/a |
| <a name="module_gcp-admins"></a> [gcp-admins](#module\_gcp-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_gcp_admins"></a> [gcp\_admins](#module\_gcp\_admins) | terraform-google-modules/group/google | 0.4.0 |
| <a name="module_log_export_to_storage"></a> [log\_export\_to\_storage](#module\_log\_export\_to\_storage) | terraform-google-modules/log-export/google | ~> 7.3.0 |
| <a name="module_network-admins"></a> [network-admins](#module\_network-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_network_admins"></a> [network\_admins](#module\_network\_admins) | terraform-google-modules/group/google | 0.4.0 |
| <a name="module_org_monitoring_project"></a> [org\_monitoring\_project](#module\_org\_monitoring\_project) | terraform-google-modules/project-factory/google | 14.2.0 |
| <a name="module_org_seed_project"></a> [org\_seed\_project](#module\_org\_seed\_project) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_owner_projecta_projects"></a> [owner\_projecta\_projects](#module\_owner\_projecta\_projects) | terraform-google-modules/project-factory/google | 14.2.0 |
| <a name="module_owner_projecta_projects_tf_state"></a> [owner\_projecta\_projects\_tf\_state](#module\_owner\_projecta\_projects\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 4.0 |
| <a name="module_owner_projectb_projects_tf_state"></a> [owner\_projectb\_projects\_tf\_state](#module\_owner\_projectb\_projects\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 4.0 |
| <a name="module_owner_projectbated_projects"></a> [owner\_projectbated\_projects](#module\_owner\_projectbated\_projects) | terraform-google-modules/project-factory/google | 14.2.0 |
| <a name="module_owner_projectc_projects"></a> [owner\_projectc\_projects](#module\_owner\_projectc\_projects) | terraform-google-modules/project-factory/google | 14.2.0 |
| <a name="module_owner_projectc_projects_tf_state"></a> [owner\_projectc\_projects\_tf\_state](#module\_owner\_projectc\_projects\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 4.0 |
| <a name="module_preprod_vpc_shared_vpc_host"></a> [preprod\_vpc\_shared\_vpc\_host](#module\_preprod\_vpc\_shared\_vpc\_host) | terraform-google-modules/network/google | 6.0.1 |
| <a name="module_prod_vpc_shared_vpc_host"></a> [prod\_vpc\_shared\_vpc\_host](#module\_prod\_vpc\_shared\_vpc\_host) | terraform-google-modules/network/google | 7.3.0 |
| <a name="module_project-admins"></a> [project-admins](#module\_project-admins) | terraform-google-modules/iam/google//modules/folders_iam | 7.6.0 |
| <a name="module_project_admins"></a> [project\_admins](#module\_project\_admins) | terraform-google-modules/group/google | 0.4.0 |
| <a name="module_project_groups"></a> [project\_groups](#module\_project\_groups) | terraform-google-modules/group/google | 0.4.0 |
| <a name="module_projecta_folders"></a> [projecta\_folders](#module\_projecta\_folders) | ../modules/google_folder | n/a |
| <a name="module_projectb_folders"></a> [projectb\_folders](#module\_projectb\_folders) | ../modules/google_folder | n/a |
| <a name="module_projectc_folders"></a> [projectc\_folders](#module\_projectc\_folders) | ../modules/google_folder | n/a |
| <a name="module_require_os_login"></a> [require\_os\_login](#module\_require\_os\_login) | ../modules/org-policy | n/a |
| <a name="module_restrict_public_ip_cloudsql"></a> [restrict\_public\_ip\_cloudsql](#module\_restrict\_public\_ip\_cloudsql) | ../modules/org-policy | n/a |
| <a name="module_restrict_shared_vpc_project_lien"></a> [restrict\_shared\_vpc\_project\_lien](#module\_restrict\_shared\_vpc\_project\_lien) | ../modules/org-policy | n/a |
| <a name="module_restrict_vm_external_ip"></a> [restrict\_vm\_external\_ip](#module\_restrict\_vm\_external\_ip) | ../modules/org-policy | n/a |
| <a name="module_restrict_vpc_host_projects"></a> [restrict\_vpc\_host\_projects](#module\_restrict\_vpc\_host\_projects) | ../modules/org-policy | n/a |
| <a name="module_restrict_vpc_peering"></a> [restrict\_vpc\_peering](#module\_restrict\_vpc\_peering) | ../modules/org-policy | n/a |
| <a name="module_security-admins"></a> [security-admins](#module\_security-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_security_admins"></a> [security\_admins](#module\_security\_admins) | terraform-google-modules/group/google | 0.4.0 |
| <a name="module_shared_vpc_host_project"></a> [shared\_vpc\_host\_project](#module\_shared\_vpc\_host\_project) | terraform-google-modules/project-factory/google | 14.2.0 |
| <a name="module_skip_default_network"></a> [skip\_default\_network](#module\_skip\_default\_network) | ../modules/org-policy | n/a |
| <a name="module_storage_destination"></a> [storage\_destination](#module\_storage\_destination) | terraform-google-modules/log-export/google//modules/storage | ~> 7.3.0 |
| <a name="module_tf_seed_organization_iam_bindings"></a> [tf\_seed\_organization\_iam\_bindings](#module\_tf\_seed\_organization\_iam\_bindings) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_tf_seed_project_iam_bindings"></a> [tf\_seed\_project\_iam\_bindings](#module\_tf\_seed\_project\_iam\_bindings) | terraform-google-modules/iam/google//modules/projects_iam | 7.6.0 |
| <a name="module_tf_state"></a> [tf\_state](#module\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 4.0 |
| <a name="module_uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#module\_uniform\_bucket\_level\_access) | ../modules/org-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.preprod_psa_address](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/compute_global_address) | resource |
| [google_compute_global_address.prod_psa_address](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/compute_global_address) | resource |
| [google_compute_network_peering_routes_config.preprod_psa_route_export](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/compute_network_peering_routes_config) | resource |
| [google_compute_network_peering_routes_config.prod_psa_route_export](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/compute_network_peering_routes_config) | resource |
| [google_iam_workload_identity_pool.cicd_terraformer](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.github](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_monitoring_dashboard.logging_dashboards](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/monitoring_dashboard) | resource |
| [google_monitoring_monitored_project.primary](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/monitoring_monitored_project) | resource |
| [google_pubsub_topic.preprod_budget](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic.prod_budget](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/pubsub_topic) | resource |
| [google_service_account.tf_seed](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.workload_identity](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_key.tf_seed](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/service_account_key) | resource |
| [google_service_networking_connection.preprod_psa_connection](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/service_networking_connection) | resource |
| [google_service_networking_connection.prod_psa_connection](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/service_networking_connection) | resource |
| [google_vpc_access_connector.vpcconn-preprod](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/vpc_access_connector) | resource |
| [google_vpc_access_connector.vpcconn-prod](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/resources/vpc_access_connector) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [google_folders.prj_folders](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/data-sources/folders) | data source |
| [google_organization.org](https://registry.terraform.io/providers/hashicorp/google/4.58.0/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activate_apis"></a> [activate\_apis](#input\_activate\_apis) | n/a | `map(list(string))` | <pre>{<br>  "Billing": [<br>    "compute.googleapis.com",<br>    "cloudresourcemanager.googleapis.com",<br>    "pubsub.googleapis.com",<br>    "billingbudgets.googleapis.com"<br>  ],<br>  "CICD": [<br>    "cloudbuild.googleapis.com",<br>    "artifactregistry.googleapis.com"<br>  ],<br>  "Network": [<br>    "servicenetworking.googleapis.com",<br>    "compute.googleapis.com",<br>    "vpcaccess.googleapis.com",<br>    "container.googleapis.com"<br>  ],<br>  "projecta": [<br>    "compute.googleapis.com",<br>    "run.googleapis.com"<br>  ],<br>  "projectb": [<br>    "compute.googleapis.com",<br>    "bigquery.googleapis.com"<br>  ],<br>  "projectc": [<br>    "compute.googleapis.com",<br>    "bigquery.googleapis.com",<br>    "composer.googleapis.com",<br>    "container.googleapis.com",<br>    "secretmanager.googleapis.com",<br>    "dataform.googleapis.com"<br>  ],<br>  "seed": [<br>    "cloudidentity.googleapis.com",<br>    "orgpolicy.googleapis.com",<br>    "servicenetworking.googleapis.com",<br>    "cloudbilling.googleapis.com",<br>    "cloudresourcemanager.googleapis.com",<br>    "serviceusage.googleapis.com",<br>    "iam.googleapis.com",<br>    "iamcredentials.googleapis.com",<br>    "seprojectbitycenter.googleapis.com",<br>    "billingbudgets.googleapis.com",<br>    "pubsub.googleapis.com",<br>    "vpcaccess.googleapis.com",<br>    "compute.googleapis.com"<br>  ]<br>}</pre> | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | n/a | `string` | `"012X00-93XXX2-44XXX0"` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | n/a | `string` | `"12312312234345"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | `"client-name"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_org_cicd_project"></a> [org\_cicd\_project](#output\_org\_cicd\_project) | The organization's CI/CD project module. All properties |
| <a name="output_org_seed_project"></a> [org\_seed\_project](#output\_org\_seed\_project) | The seeded organization project module. All properties |
| <a name="output_owner_project_groups"></a> [owner\_project\_groups](#output\_owner\_project\_groups) | The GCP groups associated with each owner project. |
| <a name="output_owner_projects"></a> [owner\_projects](#output\_owner\_projects) | A merged map of all owner projects: projecta, curated, and trans projects. All properties |
| <a name="output_preprod_vpc_shared_vpc_host"></a> [preprod\_vpc\_shared\_vpc\_host](#output\_preprod\_vpc\_shared\_vpc\_host) | The shared VPC for the pre-production environment. All properties |
| <a name="output_prod_vpc_shared_vpc_host"></a> [prod\_vpc\_shared\_vpc\_host](#output\_prod\_vpc\_shared\_vpc\_host) | The shared VPC for the production environment. All properties |
| <a name="output_shared_vpc_project"></a> [shared\_vpc\_project](#output\_shared\_vpc\_project) | The shared VPC host project module. All properties |
| <a name="output_terraform-seed-sa"></a> [terraform-seed-sa](#output\_terraform-seed-sa) | The email address of the service account created for seeding Terraform. |
| <a name="output_vpcconn-preprod"></a> [vpcconn-preprod](#output\_vpcconn-preprod) | The VPC access connector for the pre-production environment. |
| <a name="output_vpcconn-prod"></a> [vpcconn-prod](#output\_vpcconn-prod) | The VPC access connector for the production environment. |
<!-- END_TF_DOCS -->