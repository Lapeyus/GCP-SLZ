# Altus-Cor Shared VPC and Networks Configuration

This Terraform module is designed to set up the Shared VPC host project and network configuration for the Altus-Cor environment, aligned with the Service Landing Zone (SLZ) concept.

## Modules

### 1. Shared VPC Host Project

This module creates the host project for the Shared VPC, using the Terraform Google Project Factory module.

```hcl
module "shared_vpc_host_project" {
  ...
}
```

### 2. Preprod VPC

This module defines the Preprod Virtual Private Cloud (VPC) along with subnets, secondary ranges, routes, and other resources.

```hcl
module "preprod_vpc_shared_vpc_host" {
  ...
}
```

### 3. Private Service Access for Preprod VPC

The following resources create a Private Service Access Subnet for the preprod VPC and configure route import/export.

```hcl
resource "google_compute_global_address" "preprod_psa_address" { ... }
resource "google_service_networking_connection" "preprod_psa_connection" { ... }
resource "google_compute_network_peering_routes_config" "preprod_psa_route_export" { ... }
```

### 4. VPC Connector for Preprod VPC

```hcl
resource "google_vpc_access_connector" "vpcconn-preprod" { ... }
```

### 5. Cloud NAT for Preprod VPC

```hcl
module "cloud-nat" {
  ...
}
```

### 6. Production VPC

This module sets up the Production Virtual Private Cloud (VPC), including subnets, secondary IP ranges, and routes.

```hcl
module "prod_vpc_shared_vpc_host" {
  ...
}
```

## Usage

To utilize these modules, simply include them in your Terraform project, providing the necessary variables as outlined in each module's documentation.

## SLZ Considerations

This module aligns with the principles of the Service Landing Zone (SLZ) to provide a secure and scalable network infrastructure, ensuring the separation of preproduction and production environments, while maintaining accessibility for managed services like VertexAI, CloudSQL, CloudBuild, etc.



# Code

{% include 'slz-projects-sharedvpc.code' %}
