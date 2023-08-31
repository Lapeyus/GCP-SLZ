import sys
import re
import argparse
import os

def extract_depends_on_relations(file_path):
    relations = []
    current_resource = None
    with open(file_path, 'r') as f:
        lines = f.readlines()
    for line in lines:
        line = line.strip()
        if line.startswith("resource") or line.startswith("module"):
            current_resource = re.search(r'"(.*?)"', line).group(1)
        elif "depends_on" in line and current_resource is not None:
            targets = re.search(r'\[(.*?)\]', line).group(1).strip()
            for target in targets.split(","):
                relations.append((current_resource.strip(), target.strip()))
    return relations

def create_mermaid_from_relations(relations, output_file):
    with open(output_file, 'w') as f:
        f.write("graph TD;\n")
        for source, target in relations:
            f.write(f"    {source} --> {target};\n")

def create_graphviz_from_relations(relations, output_file):
    with open(output_file, 'w') as f:
        f.write("digraph G {\n")
        for source, target in relations:
            f.write(f"    {source} -> {target};\n")
        f.write("}\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate dependency graphs from Terraform files.')
    parser.add_argument('input_file', type=str, help='Input Terraform file')
    parser.add_argument('output_path', type=str, help='Output directory for the graph file')
    parser.add_argument('--format', type=str, choices=['mermaid', 'graphviz'], default='mermaid', help='Output format')

    args = parser.parse_args()

    # Get the output file name based on the input file name
    base_name = os.path.basename(args.input_file)
    file_name_without_ext = os.path.splitext(base_name)[0]
    if args.format == 'mermaid':
        output_file = os.path.join(args.output_path, f"{file_name_without_ext}.mmd")
    elif args.format == 'graphviz':
        output_file = os.path.join(args.output_path, f"{file_name_without_ext}.dot")

    # Extract depends_on relationships from the Terraform file
    relations = extract_depends_on_relations(args.input_file)
    
    # Create file from the extracted relations based on the format
    if args.format == 'mermaid':
        create_mermaid_from_relations(relations, output_file)
    elif args.format == 'graphviz':
        create_graphviz_from_relations(relations, output_file)
