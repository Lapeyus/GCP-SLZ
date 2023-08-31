from diagrams import Cluster, Diagram
from diagrams.gcp.security import Iam
from diagrams.gcp.compute import ComputeEngine
from diagrams.gcp.devtools import SourceRepositories
from diagrams.gcp.storage import Filestore
from diagrams.gcp.network import VirtualPrivateCloud

with Diagram("GCP Architecture", show=False):
    with Cluster("Project: shared_vpc_host_project"):
        iam = Iam("IAM")
        vpc = VirtualPrivateCloud("preprod-vpc")
        
        with Cluster("Subnets"):
            subnet1 = VirtualPrivateCloud("owner-trans-dev-us-east4")
            subnet2 = VirtualPrivateCloud("owner-projecta-dev-us-east4")
            subnet3 = VirtualPrivateCloud("owner-cur-dev-us-east4")

        with Cluster("Secondary Ranges"):
            secondary_range1 = VirtualPrivateCloud("trans-dev-pod")
            secondary_range2 = VirtualPrivateCloud("trans-dev-svc")
        
        with Cluster("Firewall Rules"):
            fw1 = VirtualPrivateCloud("FW Rule 1")
            fw2 = VirtualPrivateCloud("FW Rule 2")
        
        with Cluster("Compute Engine"):
            instance1 = ComputeEngine("Instance 1")
            instance2 = ComputeEngine("Instance 2")
        
        with Cluster("Storage"):
            bucket = Filestore("Bucket")
        
        iam >> vpc
        vpc >> subnet1
        vpc >> subnet2
        vpc >> subnet3
        subnet3 >> secondary_range1
        subnet3 >> secondary_range2
        subnet1 >> fw1
        subnet2 >> fw2
        fw1 >> instance1
        fw2 >> instance2
        instance1 >> bucket
        instance2 >> bucket
