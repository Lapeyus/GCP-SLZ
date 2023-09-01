import os
from diagrams import Cluster, Diagram
from diagrams.custom import Custom
from diagrams.gcp.analytics import BigQuery
from diagrams.gcp.security import Iam
from diagrams.gcp.network import VirtualPrivateCloud

wip_icon_path = "../img/icons/workload_identity_pool.png"
proj_icon_path = "../img/icons/project.png"
apis_icon_path = "../img/icons/cloud_apis.png"
buckets_icon_path = "../img/icons/cloud_storage.png"
os.chdir('../img')
graph_attr = {
    "fontsize": "50",
    "bgcolor": "transparent",
}

node_attr = {}
edge_attr = {}
with Diagram("seed project", show=False, filename="seed", outformat=["png",], direction="TB", graph_attr={"bgcolor": "transparent"}):
    with Cluster("Seed Project"):
        prj = Custom("", proj_icon_path)
        buckets = Custom("Terraform Buckets", buckets_icon_path)
        apis = Custom("Cloud APIs", apis_icon_path)
    with Cluster("Terraform Service Account"):
        svc_acc = Iam("")
    with Cluster("Roles & bindings"):
        org_roles = Iam("Org IAM Bindings")
        proj_roles = Iam("Project IAM Bindings")
        iam_binding = Iam("Workload Identity")
    with Cluster("Identity Pool service"):
        wip = Custom("Pool Provider", wip_icon_path)

    svc_acc >> [iam_binding]
    wip >> iam_binding
    proj_roles >> prj  << apis
    prj << buckets

