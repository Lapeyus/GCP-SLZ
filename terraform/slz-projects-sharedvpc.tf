/**/
module "shared_vpc_host_project" {
  source                         = "terraform-google-modules/project-factory/google"
  version                        = "14.2.0"
  name                           = "owner-cor-shared-vpc-host"
  random_project_id              = true
  random_project_id_length       = 3
  org_id                         = var.org_id
  billing_account                = var.billing_account
  folder_id                      = module.folders.id["Network"]
  enable_shared_vpc_host_project = true
  default_service_account        = "disable"
  activate_apis                  = var.activate_apis["Network"]

  labels = {
    terraform_managed = true
    network_host      = true
  }
}

/*
This Module creates a GCP VPC and assigns subnets and routes to the range. You can also use this module to create secondary IP ranges, and firewall rules
*/
module "preprod_vpc_shared_vpc_host" {
  source                                 = "terraform-google-modules/network/google"
  version                                = "6.0.1"
  project_id                             = module.shared_vpc_host_project.project_id
  network_name                           = "preprod-vpc"
  routing_mode                           = "GLOBAL"
  delete_default_internet_gateway_routes = true
  subnets = [
    {
      subnet_name           = "owner-trans-dev-us-east4"
      subnet_ip             = "192.168.32.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Develop Data Transformation Subnet"
    },
    {
      subnet_name           = "owner-projecta-dev-us-east4"
      subnet_ip             = "192.168.33.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Develop Data projectaion Subnet"
    },
    {
      subnet_name           = "owner-cur-dev-us-east4"
      subnet_ip             = "192.168.34.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Develop Data Curated Subnet"
    },
    {
      subnet_name           = "owner-trans-qa-us-east4"
      subnet_ip             = "192.168.35.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "QA Data Transformation Subnet"
    },
    {
      subnet_name           = "owner-projecta-qa-us-east4"
      subnet_ip             = "192.168.36.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "QA Data projectaion Subnet"
    },
    {
      subnet_name           = "owner-cur-qa-us-east4"
      subnet_ip             = "192.168.37.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "QA Data Curated Subnet"
    },
    {
      subnet_name           = "owner-trans-staging-us-east4"
      subnet_ip             = "192.168.38.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Staging Data Transformation Subnet"
    },
    {
      subnet_name           = "owner-projecta-staging-us-east4"
      subnet_ip             = "192.168.39.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Staging Data projectaion Subnet"
    },
    {
      subnet_name           = "owner-cur-staging-us-east4"
      subnet_ip             = "192.168.40.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Staging Data Curated Subnet"
    },
    {
      subnet_name           = "owner-trans-prodfix-us-east4"
      subnet_ip             = "192.168.41.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Production fixes Data Transformation Subnet"
    },
    {
      subnet_name           = "owner-projecta-prodfix-us-east4"
      subnet_ip             = "192.168.42.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Production fixes Data projectaion Subnet"
    },
    {
      subnet_name           = "owner-cur-prodfix-us-east4"
      subnet_ip             = "192.168.43.0/24"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Production fixes Data Curated Subnet"
    },
    {
      subnet_name           = "nonprod-vpc-con-us-east4"
      subnet_ip             = "192.168.44.0/28"
      subnet_region         = "us-east4"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Dedicated non prod VPC Connector Subnet"
    }
  ]

  secondary_ranges = {
    owner-trans-dev-us-east4 = [
      {
        range_name    = "trans-dev-pod"
        ip_cidr_range = "10.0.0.0/23"
      },
      {
        range_name    = "trans-dev-svc"
        ip_cidr_range = "10.0.2.0/23"
      },

    ]
    owner-trans-qa-us-east4 = [
      {
        range_name    = "trans-qa-pod"
        ip_cidr_range = "10.0.4.0/23"
      },
      {
        range_name    = "trans-qa-svc"
        ip_cidr_range = "10.0.6.0/23"
      },
    ]

    owner-trans-staging-us-east4 = [
      {
        range_name    = "trans-staging-pod"
        ip_cidr_range = "10.0.8.0/23"
      },
      {
        range_name    = "trans-staging-svc"
        ip_cidr_range = "10.0.10.0/23"
      },
    ]

    owner-trans-prodfix-us-east4 = [
      {
        range_name    = "trans-prodfix-pod"
        ip_cidr_range = "10.0.12.0/23"
      },
      {
        range_name    = "trans-prodfix-svc"
        ip_cidr_range = "10.0.14.0/23"
      },
    ]
  }

  routes = [
    {
      name              = "egress-igw-preprod"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    }
  ]
}
/*
The next 3 resources ceate a Private Service Access Subnet for preprod VPC and configures route import/export" 
Private Service Access is what allows managed services like VertexAI, CloudSQL, Cloudbuild, etc, to have IP addresses 
*/

resource "google_compute_global_address" "preprod_psa_address" {
  name          = "preprod-psconnect-ips"
  project       = module.shared_vpc_host_project.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  network       = module.preprod_vpc_shared_vpc_host.network_id
  address       = "192.168.88.0"
  prefix_length = "21"
}

resource "google_service_networking_connection" "preprod_psa_connection" {
  network                 = module.preprod_vpc_shared_vpc_host.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.preprod_psa_address.name]
}

resource "google_compute_network_peering_routes_config" "preprod_psa_route_export" {
  project              = module.shared_vpc_host_project.project_id
  peering              = google_service_networking_connection.preprod_psa_connection.peering
  network              = module.preprod_vpc_shared_vpc_host.network_name
  import_custom_routes = true
  export_custom_routes = true
}

/*
VPC CONNECTOR FOR PREPROD VPC 
*/
resource "google_vpc_access_connector" "vpcconn-preprod" {
  name    = "vpcconn-preprod"
  project = module.shared_vpc_host_project.project_id
  region  = "us-east4"
  subnet {
    name = "nonprod-vpc-con-us-east4"
  }
}
/*
Cloud NAT for preprod VPC us-east4 
*/
module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "4.0.0"
  project_id    = module.shared_vpc_host_project.project_id
  create_router = true
  network       = module.preprod_vpc_shared_vpc_host.network_id
  region        = "us-east4"
  router        = "cloud-router-us-east4"
  name          = "preprod-cloud-nat-us-east4"
}

/*PRODUCTION VPC  */
module "prod_vpc_shared_vpc_host" {
  source                                 = "terraform-google-modules/network/google"
  version                                = "7.3.0"
  project_id                             = module.shared_vpc_host_project.project_id
  network_name                           = "production-vpc"
  routing_mode                           = "GLOBAL"
  delete_default_internet_gateway_routes = true
  subnets = [
    {
      subnet_name           = "owner-trans-prod-us-east5"
      subnet_ip             = "192.168.0.0/24"
      subnet_region         = "us-east5"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Prod Transformation Subnet"
    },
    {
      subnet_name           = "owner-projecta-prod-us-east5"
      subnet_ip             = "192.168.1.0/24"
      subnet_region         = "us-east5"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Prod projectaion Subnet"
    },
    {
      subnet_name           = "owner-cur-prod-us-east5"
      subnet_ip             = "192.168.3.0/24"
      subnet_region         = "us-east5"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Prod Curated Subnet"
    },
    {
      subnet_name           = "owner-trans-dr-us-west1"
      subnet_ip             = "192.168.4.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Disaster Recovery Transformation Subnet"
    },
    {
      subnet_name           = "owner-projecta-dr-us-west1"
      subnet_ip             = "192.168.5.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Disaster Recovery projectaion Subnet"
    },
    {
      subnet_name           = "owner-cur-dr-us-west1"
      subnet_ip             = "192.168.6.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Disaster Recovery Curated Subnet"
    },
    {
      subnet_name           = "prod-vpc-con-us-east5"
      subnet_ip             = "192.168.2.0/28"
      subnet_region         = "us-east5"
      subnet_private_access = true
      subnet_flow_logs      = false
      description           = "Dedicated prod VPC Connector Subnet"
    }
  ]
  secondary_ranges = {
    owner-trans-prod-us-east5 = [
      {
        range_name    = "trans-prod-pod"
        ip_cidr_range = "10.0.0.0/23"
      },
      {
        range_name    = "trans-prod-svc"
        ip_cidr_range = "10.0.2.0/23"
      },
    ]
    owner-dr-us-west1 = [
      {
        range_name    = "trans-dr-pod"
        ip_cidr_range = "10.0.4.0/23"
      },
      {
        range_name    = "trans-dr-svc"
        ip_cidr_range = "10.0.6.0/23"
      },
    ]
  }

  routes = [
    {
      name              = "egress-igw-prod"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    }
  ]
}
/*
The next 3 resources ceate a Private Service Access Subnet for Production VPC and configures route import/export" 
Private Service Access is what allows managed services like VertexAI, CloudSQL, Cloudbuild, etc, to have IP addressed 
*/

resource "google_compute_global_address" "prod_psa_address" {
  name          = "prod-psconnect-ips"
  project       = module.shared_vpc_host_project.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  network       = module.prod_vpc_shared_vpc_host.network_id
  address       = "192.168.88.0"
  prefix_length = "21"
}
/**/
resource "google_service_networking_connection" "prod_psa_connection" {
  network                 = module.prod_vpc_shared_vpc_host.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.prod_psa_address.name]
}
/**/
resource "google_compute_network_peering_routes_config" "prod_psa_route_export" {
  project              = module.shared_vpc_host_project.project_id
  peering              = google_service_networking_connection.prod_psa_connection.peering
  network              = module.prod_vpc_shared_vpc_host.network_name
  import_custom_routes = true
  export_custom_routes = true
}

/*
VPC CONNECTOR FOR PROD VPC 
*/
resource "google_vpc_access_connector" "vpcconn-prod" {
  name    = "vpcconn-prod"
  project = module.shared_vpc_host_project.project_id
  region  = "us-east5"
  subnet {
    name = "prod-vpc-con-us-east5"
  }
}

/*
Cloud NAT for prod VPC us-east5 
*/
module "cloud-nat-prod" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "4.0.0"
  project_id    = module.shared_vpc_host_project.project_id
  create_router = true
  network       = module.prod_vpc_shared_vpc_host.network_id
  region        = "us-east5"
  router        = "cloud-router-us-east5"
  name          = "prod-cloud-nat-us-east5"
}

/* 
FIREWALL POLICIES 
*/
module "firewall_policy" {
  source      = "../modules/network-firewall-policy"
  project_id  = module.shared_vpc_host_project.project_id
  policy_name = "owner-fw-policy"
  description = "owner firewall policy"
  target_vpcs = [module.preprod_vpc_shared_vpc_host.network_id, module.prod_vpc_shared_vpc_host.network_id]

  rules = [
    {
      priority       = "800"
      direction      = "INGRESS"
      action         = "allow"
      rule_name      = "allow-ingress-owner-ips"
      description    = "Allow traffic into the VPC from owner primary and secondary IPs"
      enable_logging = true
      match = {
        # current IPS for ["owner_primary_ip", "owner_secondary_ip"]
        src_ip_ranges = ["47.19.146.114", "75.127.173.50"]
      }
    },
    {
      priority       = "700"
      direction      = "EGRESS"
      action         = "allow"
      rule_name      = "allow-egress-cloud-run-jobs"
      description    = "Allow egress traffic for Cloud Run jobs scraping websites"
      enable_logging = true
      match = {
        # current IPS for [mis.nyiso.com,   api.misoenergy.org, www.ercot.com]
        dest_ip_ranges = ["204.152.47.69/32", "52.176.6.37/32", "45.60.45.66"]
      }
    }
  ]
}
