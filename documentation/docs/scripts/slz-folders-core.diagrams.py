import os
from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom

folder_icon_path = "../img/icons/google-folder.png"
org_icon_path = "../img/icons/administration.png"


os.chdir('../img')
graph_attr = {
    "fontsize": "60",
    "bgcolor": "transparent"
}

graph_attr2 = {
    "bgcolor": "gray",
}

node_attr = {}
edge_attr = {}

with Diagram("Secure Landing Zone Folder Hierarchy", filename="slz-folders-core", show=False, direction="TB", 
             outformat="png", graph_attr=graph_attr):
    with Cluster("Google Cloud Platform"):
        org = Custom("GCP Organization", org_icon_path)
    with Cluster("Secure Landing Zone Core"):
        core = Custom("Core", folder_icon_path)
        org >>  Edge(color="Black", style="bold") >> core
        core >> Custom("Billing", folder_icon_path)
        core >> Custom("Logging & Monitoring", folder_icon_path)
        core >> Custom("Security", folder_icon_path)
        core >> Custom("Network", folder_icon_path)

    with Cluster("Shared Resources"):
        shared = Custom("Shared", folder_icon_path)
        org >> Edge(color="Black", style="bold") >> shared
        shared >> Custom("CICD", folder_icon_path)
        shared >> Custom("Shared-Prod", folder_icon_path)
        shared >> Custom("Shared-Non-Prod", folder_icon_path)

    with Cluster("Attachment Point"):
        business_units = Custom("Bussiness Units", folder_icon_path)
        org >> Edge(color="Black", style="bold") >>  business_units
        
    with Cluster("Bu. A", graph_attr=graph_attr2):
        business_units_project = Custom("Bussiness Unit A", folder_icon_path)
        dev = Custom("Project A", folder_icon_path)
        prod = Custom("Project B", folder_icon_path)
        business_units >> business_units_project
        business_units_project >> dev
        business_units_project >> prod 
        