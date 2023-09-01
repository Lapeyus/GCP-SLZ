import os
from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.gcp.network import VPC

# Icon paths
apis_icon_path = "../img/icons/cloud_apis.png"
global_address_path = "../img/icons/cloud_external_ip_addresses.png"
peering_routes = "../img/icons/cloud_routes.png"
vpc_connector_icon_path = "../img/icons/vpc-connector.png"

# Change directory to where your output imgs are stored
os.chdir('../img')

with Diagram("Shared VPC host project", show=False, filename="slz-projects-sharedvpc"):
    apis = Custom("servicenetworking.googleapis.com", apis_icon_path)
    psa_address = Custom("psaconnect-ip", global_address_path)

    with Cluster("Networks"):
        with Cluster("Prod"):
            vpc = VPC("Shared VPC Host")
            psa_route_export = Custom("routes", peering_routes)
            with Cluster("Subnets"):
                subnet1 = Custom("VPC Connector", vpc_connector_icon_path)
                subnet2 = Custom("10.0.0.1/24", "../img/icons/cloud_network.png")
                subnet3 = Custom("10.0.0.2/24", "../img/icons/cloud_network.png")
                with Cluster("Secondary Ranges"):
                    pod_range = Custom("192.168.32.1/24", "../img/icons/cloud_network.png")
                    svc_range = Custom("192.168.32.2/24", "../img/icons/cloud_network.png")
                    subnet3 >> [pod_range, svc_range]
            psa_route_export >> Edge(label="Exports Routes") >> psa_address
            vpc >> Edge(label="Includes") >> [psa_route_export]
            vpc >> Edge(label="Has") >> [subnet1, subnet2, subnet3]
            vpc >> Edge(label="Uses") >> apis

        with Cluster("Pre Prod"):
            vpcb = VPC("Same as prod")
            # preprod_psa_address = Custom("preprod_psa_address", global_address_path)
            # preprod_psa_connection = Custom("preprod_psa_connection", apis_icon_path)
            # preprod_psa_route_export = Custom("preprod_psa_route_export", peering_routes)
            
            # vpcb >> Edge(label="Exports Routes") >> preprod_psa_address
            # vpcb >> Edge(label="Includes") >> [preprod_psa_route_export]
            # vpcb >> Edge(label="Uses") >> preprod_psa_connection
