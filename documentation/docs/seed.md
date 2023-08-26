## GCP Terraform Seed

### Overview

This Terraform code is designed to provision the foundational setup for Google Cloud Platform (GCP) project, services, and service accounts required for Terraform. It also handles the roles and permissions for the Terraform service account.


## Seed Project Concept

### What is a Seed Project?
A seed project is essentially a starting point for your infrastructure. It sets up the basic resources and permissions you need to build out your environments. This includes setting up IAM roles and Federation to run code.

### Why is it Important?
The seed project is crucial because it lays the foundation for all your future projects and configurations. It ensures that you have a secure, scalable, and maintainable infrastructure.

### Key Components
- **IAM Roles**
- **Service Accounts**
- **State**
 
### Usage

1. **Initialization**: An admin user needs to login using the CLI or manually apply the code.
2. **State Migration**: After the initial implementation, the state for the code is stored in a cloud storage bucket.

### Requisites

- A Google Cloud Platform account with sufficient permissions.
- Terraform installed in the local machine.

### Order of Execution

1. **Activation of APIs**: Flatten and set the required APIs.
2. **Project Creation**: Setup a GCP project using the "terraform-google-modules/project-factory/google" module.
3. **Service Account Creation**: Define a service account used by Terraform.
4. **Roles Assignment**: Set up the roles for the Terraform service account on the organization and project levels.
5. **Workload Identity Federation**: Setup Workload Identity Federation for GitHub actions.
6. **Workload Identity Binding**: Apply the identity binding.
7. **State Files Setup**: Create a storage bucket for Terraform seed state files.

### Logic

- The `locals` block defines the APIs to be activated.
- The `module "org_seed_project"` sets up the project.
- The `resource "google_service_account"` creates the service account.
- IAM roles are managed through modules `"terraform_sa_organization_iam_bindings"` and `"terraform_sa_project_iam_bindings"`.
- Workload Identity Federation and binding are handled with specific resources.
- The Terraform state is managed through `module "tf_state"`.

### Pros

- Automation of Project and Service Account creation.
- Easy management of IAM roles and permissions.
- Workload Identity Federation integration.

### Cons

- Manual initialization required for the first run.
- Specific configuration might be required based on the use case.

### Notes

- Make sure to uncomment the key block if needed for initial manual bootstrapping.
- The repository paths and roles can be adjusted as needed.
