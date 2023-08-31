import hcl
import sys
from graphviz import Digraph
import os
import argparse

def generate_file_name(file_path, format):
    base_name = os.path.basename(file_path).replace(".tf", "")
    if format == 'mermaid':
        return f"{base_name}.mmd"
    elif format == 'graphviz':
        return f"{base_name}.dot"

def process_terraform_file(file_path, format, output_path):
    folder_structure = {}
    external_parent_ids = {}

    with open(file_path, 'r') as file:
        terraform_code = hcl.load(file)

        for module_name, module_details in terraform_code['module'].items():
            for folder_name, folder_details in module_details['folders'].items():
                parent_key = folder_details.get('parent_entry_key')
                external_parent_id = folder_details.get('external_parent_id')

                if parent_key:
                    parent_name = next((name for name, details in module_details['folders'].items() if name.endswith(parent_key)), parent_key)
                    folder_structure[folder_name] = parent_name
                elif external_parent_id:
                    external_parent_ids[folder_name] = external_parent_id

    output_file_name = generate_file_name(file_path, format)
    output_file = os.path.join(output_path, output_file_name)

    if format == 'graphviz':
        # Initialize Graphviz object
        graph = Digraph('G', node_attr={'style': 'filled', 'shape': 'folder'})

        for i, (folder, parent) in enumerate(folder_structure.items()):
            graph.node(parent)
            graph.node(folder)
            graph.edge(parent, folder)

        for i, (folder, parent_id) in enumerate(external_parent_ids.items()):
            graph.node(parent_id, shape='house')
            graph.node(folder)
            graph.edge(parent_id, folder)

        graph.attr(rankdir='TB', size='10,10')
        graph.render(output_file, view=False, format='png')

    elif format == 'mermaid':
        with open(output_file, 'w') as f:
            f.write("graph BT;\n")
            for parent, folder in folder_structure.items():
                f.write(f"    {parent} --> {folder};\n")
            for parent_id, folder in external_parent_ids.items():
                f.write(f"    {parent_id} --> {folder};\n")

def main():
    parser = argparse.ArgumentParser(description='Generate dependency graphs from Terraform files.')
    parser.add_argument('input_file', type=str, help='Input Terraform file')
    parser.add_argument('output_path', type=str, help='Output directory for the graph file')
    parser.add_argument('--format', type=str, choices=['mermaid', 'graphviz'], default='mermaid', help='Output format')

    args = parser.parse_args()

    process_terraform_file(args.input_file, args.format, args.output_path)

if __name__ == "__main__":
    main()
