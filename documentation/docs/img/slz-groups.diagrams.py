from diagrams import Cluster, Diagram
from diagrams.gcp.security import Iam

with Diagram("SLZ groups", show=False, direction="TB", outformat="png", graph_attr={"bgcolor": "transparent"}):
    with Cluster("Organization"):
        org = Iam("organizations/${var.org_id}")
    
    with Cluster("SLZ Groups"):
        gcp_admins = Iam("GCP Admins")
        security_admins = Iam("GCP Security Admins")
        network_admins = Iam("GCP Network Admins")
        audit_admins = Iam("GCP Audit Admins")
        project_admins = Iam("GCP Project Admins")
        
        org >> gcp_admins
        org >> security_admins
        org >> network_admins
        org >> audit_admins
        org >> project_admins
