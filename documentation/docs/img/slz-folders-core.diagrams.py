from diagrams import Cluster, Diagram
from diagrams.gcp.storage import Filestore

with Diagram("GCP Folders", show=False, direction="TB", outformat="png", graph_attr={"bgcolor": "transparent"}):
    with Cluster("Organization"):
        org = Filestore("organizations/${var.org_id}")

    with Cluster("Core"):
        core = Filestore("Core")
        org >> core
        core >> Filestore("Billing")
        core >> Filestore("Logging-Monitoring")
        core >> Filestore("Security")
        core >> Filestore("Network")

    with Cluster("Shared"):
        shared = Filestore("Shared")
        org >> shared
        shared >> Filestore("Shared-Prod")
        shared >> Filestore("Shared-NonProd")

    with Cluster("BussinesUnits"):
        business_units = Filestore("BussinesUnits")
        org >> business_units
