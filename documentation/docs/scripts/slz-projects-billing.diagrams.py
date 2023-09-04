import os
from diagrams import Diagram, Cluster, Edge
from diagrams.custom import Custom
from diagrams.gcp.compute import GCE
from diagrams.gcp.analytics import Pubsub

# Custom Icon paths
budget_icon_path = "../img/icons/budget-alert.png"
proj_icon_path = "../img/icons/project.png"

os.chdir('../img')

with Diagram("Terraform Google Cloud Billing", show=False,filename="slz-projects-billing"):

    with Cluster("Billing_project"):
        billing_project = Custom("Billing Project", proj_icon_path)

        with Cluster("module budget_prod_projects"):
            budget_prod_topic = Pubsub("preprod_projects")
            prod_budget = Custom("prod_budget", budget_icon_path)
            prod_budget >> budget_prod_topic

        with Cluster("module budget_preprod_projects"):
            budget_preprod_topic = Pubsub("preprod_topic")
            preprod_budget = Custom("preprod_budget", budget_icon_path)
            preprod_budget >> budget_preprod_topic

        billing_project >> Edge(label="") >> [preprod_budget,prod_budget]
