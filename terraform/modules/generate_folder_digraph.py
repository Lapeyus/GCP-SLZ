import hcl
from graphviz import Digraph
import sys

# Define an array of paths to Terraform files
terraform_files = sys.argv[1:]

# Initialize dictionaries to store the folder structure and external parent IDs
folder_structure = {}
external_parent_ids = {}

# Iterate through the paths and load each Terraform file
for file_path in terraform_files:
    with open(file_path, 'r') as file:
        terraform_code = hcl.load(file)

        # Iterate through the Terraform code structure
        for module_name, module_details in terraform_code['module'].items():
            for folder_name, folder_details in module_details['folders'].items():
                parent_key = folder_details.get('parent_entry_key')
                external_parent_id = folder_details.get('external_parent_id')

                # Check if the folder has a parent key defined
                if parent_key:
                    parent_name = next((name for name, details in module_details['folders'].items() if name.endswith(parent_key)), parent_key)
                    folder_structure[folder_name] = parent_name
                elif external_parent_id:
                    external_parent_ids[folder_name] = external_parent_id

# Create a Graphviz object with folder styling
graph = Digraph('G', node_attr={'style': 'filled', 'shape': 'folder'})

# Apply some colors and styles
colors = ['mediumaquamarine','lightblue','lightgreen','yellow','lightcoral']
external_colors = ['lightsalmon']

# Add edges and nodes from the folder structure, with nesting colors
for i, (folder, parent) in enumerate(folder_structure.items()):
    color = colors[i % len(colors)]
    graph.node(parent, color=color)
    graph.node(folder, color=color)
    graph.edge(parent, folder)

# Add edges and nodes from the external parent IDs, with distinct colors
for i, (folder, parent_id) in enumerate(external_parent_ids.items()):
    color = external_colors[i % len(external_colors)]
    graph.node(parent_id, color=color, shape='house')  # Using a box shape to differentiate external parents
    graph.node(folder, color=color)
    graph.edge(parent_id, folder)

# Set some global attributes
graph.attr(rankdir='TB', size='10,10')

# Render the graph to a PNG file
graph.render('./documentation/docs/img/slz-folders-core', view=False, format='png')
