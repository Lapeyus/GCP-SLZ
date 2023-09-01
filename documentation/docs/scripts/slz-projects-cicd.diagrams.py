import os
from diagrams import Cluster, Diagram
from diagrams.custom import Custom

proj_icon_path = "../img/icons/project.png"
apis_icon_path = "../img/icons/cloud_apis.png"
os.chdir('../img')
graph_attr = {
    "fontsize": "50",
    "bgcolor": "transparent",
}

node_attr = {}
edge_attr = {}
with Diagram("CICD project", show=False, filename="slz-projects-cicd", outformat=["png",], direction="TB", graph_attr={"bgcolor": "transparent"}):
    with Cluster("CICD Project"):
        prj = Custom("", proj_icon_path)
        apis = Custom("Cloud APIs", apis_icon_path)

    prj  >> apis

