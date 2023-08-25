## Role Assignments for Administrative Groups in Secure Landing Zone

In a GCP organization, the secure management of resources requires clear delineation of responsibilities among different administrative roles. This code snippet defines the IAM role bindings for various administrative groups within the organization, ensuring alignment with the SLZ's security principles.

By carefully attaching the appropriate roles to administrative groups, this code maintains a secure and effective governance structure. The implementation follows the SLZ principles, ensuring that access controls are applied precisely where needed and aligning with the organization's broader security strategy.


### Role Bindings

#### 1. **GCP Admins**

This module attaches the following roles to the `gcp_admins` group:

- **Organization Admin**: Full control over the organization's resources.
- **IAM Security Admin**: Manages security settings.
- **Billing Admin**: Manages billing configuration.

```hcl
module "gcp-admins" {}
```

#### 2. **Security Admins**

Assigns the **IAM Security Admin** role for managing security settings within the "Security" folder.

```hcl
module "security-admins" {}
```

#### 3. **Network Admins**

Responsible for network management within the "Network" folder, the group is assigned the following roles:

- **Compute Network Admin**: Manages network resources.
- **VPC Access Admin**: Administers VPC access controls.

```hcl
module "network-admins" {}
```

#### 4. **Audit Admins**

Within the "Logging-Monitoring" folder, this group is assigned roles for security review and log viewing:

- **IAM Security Reviewer**: Access to review security settings.
- **Logging Viewer**: Access to view logs.

```hcl
module "audit-admins" {}
```

#### 5. **Project Admins**

This module assigns various roles within the "Altus" and "Shared" folders, providing comprehensive permissions to manage projects:

- **Editor**: General editing capabilities.
- **IAM Service Account Admin**: Manages service accounts.
- **IAM Service Account Token Creator**: Creates service account tokens.
- **Artifact Registry Admin**: Full control over Artifact Registry resources.
- **Artifact Registry Repo Admin**: Manages Artifact Registry repositories.

```hcl
module "project-admins" {}
```
