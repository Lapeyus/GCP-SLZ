from diagrams import Cluster, Diagram
from diagrams.gcp.compute import AppEngine
from diagrams.gcp.devtools import Code
from diagrams.gcp.analytics import BigQuery
from diagrams.gcp.security import Iam

with Diagram("seed project", show=False, filename="seed", outformat=["png",], direction="LR", graph_attr={"bgcolor": "transparent"}):
    with Cluster("Organization Level"):
        org_seed = Code("Seed Project")
    
    with Cluster("APIs"):
        apis = BigQuery("Activated APIs")
    
    with Cluster("Project Level Resources"):
        gcp_project = AppEngine("GCP Project")
    
    with Cluster("Service Account"):
        svc_acc = Iam("Terraform SA") 
        svc_key = Iam("Service Account Key") 
    
    with Cluster("IAM Roles"):
        org_roles = Iam("Org Bindings") 
        proj_roles = Iam("Project Bindings") 
    
    with Cluster("Workload Identity"):
        id_pool = Iam("Identity Pool") 
        id_provider = Iam("Pool Provider") 
    
    with Cluster("Service Account IAM Binding"):
        iam_binding = Iam("Workload Identity Binding") 
        
    org_seed >> apis
    org_seed >> gcp_project
    gcp_project >> svc_acc
    svc_acc >> svc_key
    svc_acc >> org_roles
    svc_acc >> proj_roles
    gcp_project >> id_pool
    id_pool >> id_provider
    id_provider >> iam_binding
    svc_acc >> iam_binding
