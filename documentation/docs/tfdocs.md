<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.81.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.81.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.81.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit-admins"></a> [audit-admins](#module\_audit-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_audit_admins"></a> [audit\_admins](#module\_audit\_admins) | terraform-google-modules/group/google | 0.6.0 |
| <a name="module_billing"></a> [billing](#module\_billing) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_cicd"></a> [cicd](#module\_cicd) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_cicd_tf_state"></a> [cicd\_tf\_state](#module\_cicd\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | 4.0.1 |
| <a name="module_cloud_nat_prod"></a> [cloud\_nat\_prod](#module\_cloud\_nat\_prod) | terraform-google-modules/cloud-nat/google | 4.1.0 |
| <a name="module_disable_guest_attributes"></a> [disable\_guest\_attributes](#module\_disable\_guest\_attributes) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_disable_service_account_key_creation"></a> [disable\_service\_account\_key\_creation](#module\_disable\_service\_account\_key\_creation) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_disable_service_account_key_upload"></a> [disable\_service\_account\_key\_upload](#module\_disable\_service\_account\_key\_upload) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_disable_vm_nested_virtualization"></a> [disable\_vm\_nested\_virtualization](#module\_disable\_vm\_nested\_virtualization) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_disable_vm_serial_ports"></a> [disable\_vm\_serial\_ports](#module\_disable\_vm\_serial\_ports) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_domain_restricted_sharing"></a> [domain\_restricted\_sharing](#module\_domain\_restricted\_sharing) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_enforce_bucket_public_access_prevention"></a> [enforce\_bucket\_public\_access\_prevention](#module\_enforce\_bucket\_public\_access\_prevention) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_firewall_policy"></a> [firewall\_policy](#module\_firewall\_policy) | ./modules/network-firewall-policy | n/a |
| <a name="module_folders"></a> [folders](#module\_folders) | ./modules/google_folder | n/a |
| <a name="module_gcp-admins"></a> [gcp-admins](#module\_gcp-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_gcp_admins"></a> [gcp\_admins](#module\_gcp\_admins) | terraform-google-modules/group/google | 0.6.0 |
| <a name="module_log_export_to_storage"></a> [log\_export\_to\_storage](#module\_log\_export\_to\_storage) | terraform-google-modules/log-export/google | 7.6.0 |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_network"></a> [network](#module\_network) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_network-admins"></a> [network-admins](#module\_network-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_network_admins"></a> [network\_admins](#module\_network\_admins) | terraform-google-modules/group/google | 0.6.0 |
| <a name="module_org_iam_bindings"></a> [org\_iam\_bindings](#module\_org\_iam\_bindings) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_owner_projecta"></a> [owner\_projecta](#module\_owner\_projecta) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_owner_projectc"></a> [owner\_projectc](#module\_owner\_projectc) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_preprod_budget"></a> [preprod\_budget](#module\_preprod\_budget) | terraform-google-modules/project-factory/google//modules/budget | 14.3.0 |
| <a name="module_preprod_cloud_nat"></a> [preprod\_cloud\_nat](#module\_preprod\_cloud\_nat) | terraform-google-modules/cloud-nat/google | 4.1.0 |
| <a name="module_preprod_vpc"></a> [preprod\_vpc](#module\_preprod\_vpc) | terraform-google-modules/network/google | 7.3.0 |
| <a name="module_prod_budget"></a> [prod\_budget](#module\_prod\_budget) | terraform-google-modules/project-factory/google//modules/budget | 14.3.0 |
| <a name="module_prod_vpc"></a> [prod\_vpc](#module\_prod\_vpc) | terraform-google-modules/network/google | 7.3.0 |
| <a name="module_project-admins"></a> [project-admins](#module\_project-admins) | terraform-google-modules/iam/google//modules/folders_iam | 7.6.0 |
| <a name="module_project_admins"></a> [project\_admins](#module\_project\_admins) | terraform-google-modules/group/google | 0.6.0 |
| <a name="module_project_groups"></a> [project\_groups](#module\_project\_groups) | terraform-google-modules/group/google | 0.4.0 |
| <a name="module_project_iam_bindings"></a> [project\_iam\_bindings](#module\_project\_iam\_bindings) | terraform-google-modules/iam/google//modules/projects_iam | 7.6.0 |
| <a name="module_projecta_folders"></a> [projecta\_folders](#module\_projecta\_folders) | ./modules/google_folder | n/a |
| <a name="module_projecta_tf_state"></a> [projecta\_tf\_state](#module\_projecta\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | 4.0.1 |
| <a name="module_projectb"></a> [projectb](#module\_projectb) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_projectb_folders"></a> [projectb\_folders](#module\_projectb\_folders) | ./modules/google_folder | n/a |
| <a name="module_projectb_tf_state"></a> [projectb\_tf\_state](#module\_projectb\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | 4.0.1 |
| <a name="module_projectc_folders"></a> [projectc\_folders](#module\_projectc\_folders) | ./modules/google_folder | n/a |
| <a name="module_projectc_tf_state"></a> [projectc\_tf\_state](#module\_projectc\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | 4.0.1 |
| <a name="module_require_os_login"></a> [require\_os\_login](#module\_require\_os\_login) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_restrict_public_ip_cloudsql"></a> [restrict\_public\_ip\_cloudsql](#module\_restrict\_public\_ip\_cloudsql) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_restrict_shared_vpc_project_lien"></a> [restrict\_shared\_vpc\_project\_lien](#module\_restrict\_shared\_vpc\_project\_lien) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_restrict_vm_external_ip"></a> [restrict\_vm\_external\_ip](#module\_restrict\_vm\_external\_ip) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_restrict_vpc_host_projects"></a> [restrict\_vpc\_host\_projects](#module\_restrict\_vpc\_host\_projects) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_restrict_vpc_peering"></a> [restrict\_vpc\_peering](#module\_restrict\_vpc\_peering) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_security-admins"></a> [security-admins](#module\_security-admins) | terraform-google-modules/iam/google//modules/organizations_iam | 7.6.0 |
| <a name="module_security_admins"></a> [security\_admins](#module\_security\_admins) | terraform-google-modules/group/google | 0.6.0 |
| <a name="module_seed"></a> [seed](#module\_seed) | terraform-google-modules/project-factory/google | 14.3.0 |
| <a name="module_skip_default_network"></a> [skip\_default\_network](#module\_skip\_default\_network) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |
| <a name="module_storage_destination"></a> [storage\_destination](#module\_storage\_destination) | terraform-google-modules/log-export/google//modules/storage | 7.6.0 |
| <a name="module_tf_state"></a> [tf\_state](#module\_tf\_state) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | 4.0.1 |
| <a name="module_uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#module\_uniform\_bucket\_level\_access) | terraform-google-modules/org-policy/google//modules/org_policy_v2 | 5.2.2 |

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.preprod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/compute_global_address) | resource |
| [google_compute_global_address.prod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/compute_global_address) | resource |
| [google_compute_network_peering_routes_config.preprod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/compute_network_peering_routes_config) | resource |
| [google_compute_network_peering_routes_config.prod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/compute_network_peering_routes_config) | resource |
| [google_iam_workload_identity_pool.main](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.github_actions](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_monitoring_dashboard.main](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/monitoring_dashboard) | resource |
| [google_pubsub_topic.preprod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic.prod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/pubsub_topic) | resource |
| [google_service_account.main](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.workload_identity](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_key.main](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/service_account_key) | resource |
| [google_service_networking_connection.preprod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/service_networking_connection) | resource |
| [google_service_networking_connection.prod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/service_networking_connection) | resource |
| [google_vpc_access_connector.preprod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/vpc_access_connector) | resource |
| [google_vpc_access_connector.prod](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/resources/vpc_access_connector) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |
| [google_folders.prj_folders](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/data-sources/folders) | data source |
| [google_organization.org](https://registry.terraform.io/providers/hashicorp/google/4.81.0/docs/data-sources/organization) | data source |

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
| <a name="output_cicd"></a> [cicd](#output\_cicd) | The organization's CI/CD project module. All properties |
| <a name="output_network"></a> [network](#output\_network) | The shared VPC host project module. All properties |
| <a name="output_preprod_vpc"></a> [preprod\_vpc](#output\_preprod\_vpc) | The shared VPC for the pre-production environment. All properties |
| <a name="output_preprod_vpcconn"></a> [preprod\_vpcconn](#output\_preprod\_vpcconn) | The VPC access connector for the pre-production environment. |
| <a name="output_prod_vpc"></a> [prod\_vpc](#output\_prod\_vpc) | The shared VPC for the production environment. All properties |
| <a name="output_prod_vpcconn"></a> [prod\_vpcconn](#output\_prod\_vpcconn) | The VPC access connector for the production environment. |
| <a name="output_seed"></a> [seed](#output\_seed) | The seeded organization project module. All properties |
| <a name="output_terraform_seed_sa"></a> [terraform\_seed\_sa](#output\_terraform\_seed\_sa) | The email address of the service account created for seeding Terraform. |
<!-- END_TF_DOCS -->
