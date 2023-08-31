from diagrams import Cluster, Diagram
from diagrams.gcp.security import Iam, ResourceManager
from diagrams.gcp.compute import ComputeEngine
from diagrams.gcp.devtools import SourceRepositories
from diagrams.gcp.storage import Filestore
from diagrams.gcp.network import VirtualPrivateCloud

with Diagram("SLZ groups IAM", show=False):
    with Cluster("Organization"):
        org = ResourceManager("Organization")
        
        with Cluster("GCP Admins"):
            gcp_admins_group = Iam("Group")
            gcp_admins_group - [org] << Iam("Organization Admin")
            gcp_admins_group << Iam("Security Admin")
            gcp_admins_group << Iam("Billing Admin")
            
        with Cluster("Security Admins"):
            security_admins_group = Iam("Group")
            security_admins_group - [org] << Iam("Security Admin")
        
        with Cluster("Network Admins"):
            network_admins_group = Iam("Group")
            network_admins_group << ComputeEngine("Network Admin")
            network_admins_group << VirtualPrivateCloud("VPC Access Admin")
            
        with Cluster("Audit Admins"):
            audit_admins_group = Iam("Group")
            audit_admins_group << Iam("Security Reviewer")
            audit_admins_group << Filestore("Logging Viewer")
        
        with Cluster("Project Admins"):
            project_admins_group = Iam("Group")
            sa = Iam("Service Account")
            project_admins_group - [org, sa] << Iam("Editor")
            project_admins_group << Iam("Service Account Admin")
            project_admins_group << Iam("Service Account Token Creator")
            project_admins_group << SourceRepositories("Artifact Registry Admin")
            project_admins_group << SourceRepositories("Artifact Registry Repo Admin")
