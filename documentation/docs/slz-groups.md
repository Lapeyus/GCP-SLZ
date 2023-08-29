## Documentation for Secure Landing Zone Administrative Groups
These group configurations form an essential part of the Secure Landing Zone, ensuring a well-structured and secure access control hierarchy. By segregating permissions and adhering to the principle of least privilege, the implementation promotes an organized and robust security posture within the GCP environment.

### Introduction

This part of the SLZ implementation defines different groups within your GCP organization. By adhering to the principle of least privilege, we ensure that users and services have the minimum levels of access required to perform their duties.

!!! danger    
          In order to mantain this implementation as an effective and secure landing zone on GCP, you should consider the principle of least privilege,
          where you should grant only the necessary access to users, groups and services to perform their tasks.
          

### Groups Overview

The following are the key administrative groups designed to manage various aspects of the organization:

#### 1. **GCP Admins**

This group has broad permissions across the entire organization and should contain a limited number of members.

```hcl
module "gcp_admins" {
  source       = "terraform-google-modules/group/google"
  version      = "0.4.0"
  id           = "admins@${data.google_organization.org.domain}"
  display_name = "GCP Admins"
  description  = "Group for GCP Administrators"
  domain       = data.google_organization.org.domain
  managers     = []
  members      = ["joseph.villarreal@66degrees.com"]
  owners       = []
}
```

#### 2. **Security Admins**

Responsible for security settings, such as configuring IAM and organization policies.

```hcl
module "security_admins" {
  // Code here...
}
```

#### 3. **Network Admins**

Manages network resources like VPCs, subnets, and firewall rules.

```hcl
module "network_admins" {
  // Code here...
}
```

#### 4. **Audit Admins**

Has permissions to view all resources and settings for auditing and compliance.

```hcl
module "audit_admins" {
  // Code here...
}
```

#### 5. **Project Admins**

A global grant to manage all projects in the organization. Individual project management is delegated to dedicated groups (see `alt-groups.tf`).

```hcl
module "project_admins" {
  // Code here...
}
```

# Code

{% include 'slz-groups.code' %}
