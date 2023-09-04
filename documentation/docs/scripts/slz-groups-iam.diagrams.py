import os
from diagrams import Cluster, Diagram, Edge
from diagrams.gcp.security import Iam
from diagrams.custom import Custom

groups_icon_path = "../img/icons/google-groups.png"
org_icon_path = "../img/icons/administration.png"


os.chdir('../img')
graph_attr = {
    "fontsize": "60",
    # "bgcolor": "transparent"
}

node_attr = {}
edge_attr = {}

with Diagram("Secure Landing Zone Groups Roles", filename="slz-groups-iam", show=False, direction="LR",
             outformat="png", graph_attr=graph_attr):
    with Cluster("Google Cloud Platform"):
        org = Custom("GCP Organization", org_icon_path)
    with Cluster("Security Admins"):
        ga = Custom("", groups_icon_path)
        sasa = Iam("Security Admin")
        org >> Edge(color="Black", style="bold") >> ga
        ga >> [sasa]
    with Cluster("GCP Admins"):
        ga = Custom("", groups_icon_path)
        gaoa = Iam("Org Admin")
        gasa = Iam("Security Admin")
        gaba = Iam("Billing Admin")
        org >> Edge(color="Black", style="bold") >> ga
        ga >> [gaoa,gasa,gaba]
    with Cluster("Network Admins"):
        ga = Custom("", groups_icon_path)
        nana = Iam("Network Admin")
        nava = Iam("VPC Access Admin")
        org >> Edge(color="Black", style="bold") >> ga
        ga >> [nana,nava]
    with Cluster("Audit Admins"):
        ga = Custom("", groups_icon_path)
        aana = Iam("Security Reviewer")
        aava = Iam("Logging")
        org >> Edge(color="Black", style="bold") >> ga
        ga >> [aana,aava]
    with Cluster("Project Admins"):
        ga = Custom("", groups_icon_path)
        pana = Iam("Editor")
        pasa = Iam("Service Account Admin")
        past = Iam("Service Account Admin Token Creator")
        para = Iam("Artifact Registry Admin")
        parr = Iam("Artifact Registry Repo Admin")
        org >> Edge(color="Black", style="bold") >> ga
        ga >> [pana,pasa,past,para,parr]
