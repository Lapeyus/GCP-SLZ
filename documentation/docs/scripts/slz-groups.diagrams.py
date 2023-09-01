import os
from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom

groups_icon_path = "../img/icons/google-groups.png"
org_icon_path = "../img/icons/administration.png"


os.chdir('../img')
graph_attr = {
    "fontsize": "60",
    "bgcolor": "transparent"
}

node_attr = {}
edge_attr = {}

with Diagram("Secure Landing Zone Groups", filename="slz-groups", show=False, direction="TB", 
             outformat="png", graph_attr=graph_attr):
    with Cluster("Google Cloud Platform"):
        org = Custom("GCP Organization", org_icon_path)
    with Cluster("Secure Landing Zone groups"):
        org >> Custom("GCP Admins", groups_icon_path)
        org >> Custom("Security Admins", groups_icon_path)
        org >> Custom("Network Admins", groups_icon_path)
        org >> Custom("Audit Admins", groups_icon_path)
        org >> Custom("Project Admins", groups_icon_path)
