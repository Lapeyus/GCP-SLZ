### How to add a new folder to the SLZ core folders module

Adding a new folder to the `folders` module with Terraform is straightforward. You can simply add a new key-value pair inside the `folders` map, following the existing structure. this would only be necesary to add a folder to the SLZ, all projects are nested inside the ${var.owner} Folder from alt-folders.tf

Here's an example of how you could add a new folder named "MYCHILDFOLDER" as a child of the Shared Folder:

```hcl
module "folders" {
  source = "../modules/google_folder"

  folders = {
    "Core"               = { external_parent_id = "organizations/${var.org_id}" },
    "Billing"            = { parent_entry_key = "Core" },
    "Logging-Monitoring" = { parent_entry_key = "Core" },
    "Security"           = { parent_entry_key = "Core" },
    "Network"            = { parent_entry_key = "Core" },
    "Shared"             = { external_parent_id = "organizations/${var.org_id}" },
    "Shared-Prod"        = { parent_entry_key = "Shared" },
    "Shared-NonProd"     = { parent_entry_key = "Shared" },
    "${var.owner}" = {
      name               = "${var.owner}"
      external_parent_id = "organizations/${var.org_id}"
    },
    "MYROOTFOLDER"        = { "organizations/${var.org_id}" } // New root folder added here
    "MYCHILDFOLDER"        = { parent_entry_key = "Shared" } // New child folder added here
  }
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}
```

In this example, the new "MYCHILDFOLDER" folder is set as a child of the "Shared" folder by referencing the `parent_entry_key`. You can customize the parent and other attributes according to your needs.

In this example, the new "MYROOTFOLDER" folder is set as a child of the ORG folder by referencing the `organizations/${var.org_id}`. You can customize the parent and other attributes according to your needs.

### How Do I Modify or Add SLZ Groups?

Modifying or adding SLZ groups can be achieved by modifying or adding a new module definition for the desired group. Here's an example to add a new group named "GCP Custom Admins":

```hcl
module "custom_admins" {
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "custom-admins@${data.google_organization.org.domain}"
  display_name = "GCP Custom Admins"
  description  = "Group for GCP Custom Administrators"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = ["john.doe@yourdomain.com"]
  owners       = []
}
```

### How Do I Modify or Add SLZ Groups Members?

You can add or modify members by updating the `members` attribute within the desired group's module. Here's an example to add a new member to the "GCP Admins" group:

```hcl
module "gcp_admins" {
  ...
  members      = ["joseph.villarreal@66degrees.com", "john.doe@yourdomain.com"] // Added new member here
  ...
}
```

### How Do I Modify or Add SLZ Groups Members Roles?

Modifying or adding roles can be done by updating or adding the `bindings` attribute within the corresponding IAM module. Here's an example to add a new role to the "GCP Admins" group:

```hcl
module "gcp-admins" {
  ...
  bindings = {
    "roles/resourcemanager.organizationAdmin" = [
      "group:${module.gcp_admins.id}",
    ]
    "roles/iam.securityAdmin" = [
      "group:${module.gcp_admins.id}",
    ]
    "roles/billing.admin" = [
      "group:${module.gcp_admins.id}",
    ]
    "roles/custom.admin" = [ // Added new role here
      "group:${module.gcp_admins.id}",
    ]
  }
}
```

Remember to replace `"roles/custom.admin"` with the actual role that you want to add or modify.

### Modifying Organization Policies

**Enable/Disable Policies**: You can enable or disable a specific organization policy by modifying the `enforcement` attribute within the module definition. Set it to `true` to enable and `false` to disable. Here's an example:

```hcl
module "restrict_vpc_peering" {
  // ...
  rules = [{
    enforcement = false // Setting this to true will enable the policy
    // ...
  }]
  // ...
}
```

**Modify Policy Rules**: You can add or modify rules by editing the `rules` attribute. Here's an example of how you can modify an existing policy:

```hcl
module "restrict_public_ip_cloudsql" {
  // ...
  rules = [{
    enforcement = true
    allow       = ["allowed_value1", "allowed_value2"]
    deny        = ["denied_value1", "denied_value2"]
    conditions  = [] // You can define conditions here
  }]
  // ...
}
```

### Adding Organization Policies

To add a new organization policy, you can create a new module using the existing pattern. Here's an example for a hypothetical policy:

```hcl
module "new_policy" {
  source = "../modules/org-policy"

  policy_root    = "organization"
  policy_root_id = var.org_id
  rules = [{
    enforcement = true
    allow       = []
    deny        = []
    conditions  = []
  }]
  constraint  = "constraints/your.newConstraint"
  policy_type = "boolean" // or "list" depending on the policy type
}
```

### How to Modify Existing Budgets

To modify an existing budget, you can make changes to the existing module definition for the budget you wish to alter. Here's how you can update the amount and alerts for the production budget:

```markdown
module "budget_prod_projects" {
// ...
amount = "2000" // Updating the budget amount
alert_spent_percents = [0.4, 0.6, 0.8, 1.0] // Updating the alert percentages
// ...
}
```

You can also modify other attributes like `display_name`, `credit_types_treatment`, `alert_pubsub_topic`, etc., based on your requirements.

### How to Add New Budgets

To add a new budget, you can replicate the pattern used for existing budgets and define a new module for the budget. Here's an example for adding a new development budget:

```markdown
# Development budget topic

resource "google_pubsub_topic" "dev_budget" {
name = "${var.owner}-dev-budget-topic-${random_string.suffix.result}"
project = module.billing_project.project_id
}

module "budget_dev_projects" {
source = "terraform-google-modules/project-factory/google//modules/budget"
billing_account = var.billing_account
projects = [module.billing_project.project_id]
amount = "500"
display_name = "Budget for ${module.billing_project.project_id} (Development)"
  alert_spent_percents   = [0.5, 0.8, 1.0]
  credit_types_treatment = "INCLUDE_ALL_CREDITS"
  alert_pubsub_topic     = "projects/${module.billing_project.project_id}/topics/${google_pubsub_topic.dev_budget.name}"
labels = {
"env" : "dev"
}
}
```

### Creating New CI/CD Cloud Build Pipelines and Triggers in the CICD Project for a Project in the Org

To create a new Cloud Build pipeline, you will need to create a build trigger and define the build steps. Here's an example of how you can do that:

```markdown
resource "google_cloudbuild_trigger" "my_trigger" {
project = module.cicd.project_id
name = "my-trigger-name"
description = "My build trigger"

github {
owner = "my-org"
name = "my-repo"
push {
branch = "^master$"
}
}

filename = "cloudbuild.yaml"
}

resource "google_cloudbuild_build" "my_build" {
project_id = module.cicd.project_id
timeout = "1800s"

source {
repo_source {
project_id = "my-project-id"
repo_name = "my-repo"
branch_name = "master"
}
}

steps {
name = "gcr.io/cloud-builders/docker"
args = ["build", "--tag=gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA", "."]
}

images = ["gcr.io/$PROJECT_ID/$REPO_NAME:$SHORT_SHA"]
}
```

This code snippet sets up a build trigger that will start a Cloud Build pipeline when changes are pushed to the master branch of the specified GitHub repository.

### Using the CICD Project Shared Artifact Registry from a Project

To use the shared Artifact Registry from a project, you can refer to the Artifact Registry repository that you have created in the CICD project. The IAM bindings module you've defined already gives write permissions to the specified service accounts.

Here's how you can push a Docker image to the shared Artifact Registry:

```markdown
resource "google_cloudbuild_build" "push_to_artifact_registry" {
project_id = module.cicd.project_id
timeout = "1800s"

source {
repo_source {
project_id = "my-project-id"
repo_name = "my-repo"
branch_name = "master"
}
}

steps {
name = "gcr.io/cloud-builders/docker"
args = ["build", "--tag=us-central1-docker.pkg.dev/${module.cicd.project_id}/${var.owner}-docker/my-image:$SHORT_SHA", "."]
args = ["push", "us-central1-docker.pkg.dev/${module.cicd.project_id}/${var.owner}-docker/my-image:$SHORT_SHA"]
}
}
```

This code snippet pushes a Docker image to the shared Artifact Registry that you created in the CICD project.

### What does the `shared_vpc_host_project` module do?

The `shared_vpc_host_project` module creates a new Google Cloud Project configured to act as a Shared VPC host project. It sets up specific properties such as project name, organization ID, billing account, and folder ID, and enables the shared VPC host project feature. Labels such as `terraform_managed` and `network_host` are applied to identify the project easily.

### How is the pre-production VPC configured?

The pre-production VPC is configured through the `preprod_vpc_shared_vpc_host` module. It specifies the network name, routing mode, and includes a detailed configuration of subnets, secondary IP ranges, and routes. The subnets are tailored for various MYCHILDFOLDER, QA, staging, and production fixes. Secondary IP ranges are specified for specific subnets, and a route is created for egress through the internet gateway.

### How is Private Service Access configured for the pre-production VPC?

Private Service Access for the pre-production VPC is configured through three resources:

1. `google_compute_global_address`: Defines the global address for VPC peering with a specific IP range.
2. `google_service_networking_connection`: Creates a connection to the Google Service Networking API and sets up the VPC peering.
3. `google_compute_network_peering_routes_config`: Configures the route import/export for the peering connection.

This setup allows managed services like VertexAI, CloudSQL, Cloudbuild, etc., to have IP addresses within the VPC.

### What is the purpose of the `google_vpc_access_connector` resource?

The `google_vpc_access_connector` resource creates a VPC access connector in the specified region, which enables connections between your VPC network and the product that requires VPC connector, such as Cloud Functions, App Engine, and Cloud Run. In this code, it's named "vpcconn-preprod" and is configured for the "nonprod-vpc-con-us-east4" subnet.

### How is the Cloud NAT configured for the pre-production VPC?

The Cloud NAT for the pre-production VPC is configured using the `cloud-nat` module. It includes the project ID, network, and region, and specifies the router and name for the Cloud NAT. Cloud NAT allows virtual machine instances in the VPC network to send outbound packets to the internet and receive any corresponding established inbound response packets.

### How is the production VPC configured?

The production VPC is configured through the `prod_vpc_shared_vpc_host` module. Similar to the pre-production VPC, it specifies the network name, routing mode, subnets, secondary IP ranges, and routes. The subnets are tailored for production and disaster recovery, with dedicated subnets for VPC connectors. Routes are created for egress through the internet gateway.

### Modifying a VPC

You can modify a VPC by adjusting the parameters within the existing VPC module. For instance, to change the routing mode of the `preprod-vpc`, update the `routing_mode` field:

```hcl
module "preprod_vpc_shared_vpc_host" {
  ...
  routing_mode = "REGIONAL" # Change from GLOBAL to REGIONAL
  ...
}
```

### Adding a VPC

To add a new VPC, you can create a new instance of the VPC module:

```hcl
module "new_vpc" {
  source                                 = "terraform-google-modules/network/google"
  project_id                             = module.network.project_id
  network_name                           = "new-vpc"
  routing_mode                           = "GLOBAL"
  ...
}
```

### Modifying a Subnet

To modify a subnet, you can edit the corresponding subnet details inside the VPC module. For example, to change the IP range of a specific subnet:

```hcl
module "preprod_vpc_shared_vpc_host" {
  ...
  subnets = [
    {
      subnet_name = "${var.owner}-trans-dev-us-east4"
      subnet_ip   = "192.168.100.0/24" # Change the IP range
      ...
    },
  ]
  ...
}
```

### Adding a Subnet

To add a subnet, you can simply append a new subnet entry within the `subnets` list inside the VPC module:

```hcl
module "preprod_vpc_shared_vpc_host" {
  ...
  subnets = [
    ...
    {
      subnet_name           = "new-subnet"
      subnet_ip             = "192.168.50.0/24"
      subnet_region         = "us-east4"
      ...
    },
  ]
  ...
}
```

### Modifying a Firewall Rule

To modify a firewall rule, you would define or modify a firewall resource. However, the provided code snippet doesn't include a firewall rule, so here's a general way to modify one:

```hcl
resource "google_compute_firewall" "my_firewall" {
  ...
  allow {
    protocol = "tcp"
    ports    = ["80", "443"] # Modify the allowed ports
  }
  ...
}
```

### Adding a Firewall Rule

To add a firewall rule, you can define a new firewall resource:

```hcl
resource "google_compute_firewall" "new_firewall" {
  name    = "new-firewall-rule"
  network = module.prod_vpc_shared_vpc_host.network_name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
```

Make sure to carefully review and apply these changes to suit your specific requirements, and run `terraform plan` and `terraform apply` to apply the changes.
