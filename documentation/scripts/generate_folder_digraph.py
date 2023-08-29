import hcl
import os
import sys
from typing import List, Optional

def parse_tf_file_with_resources(lines: List[str]) -> List[str]:
    merged_content = []
    doc_lines = []
    hcl_code = []
    capture_doc = False
    capture_code = False

    for line in lines:
        stripped_line = line.strip()

        if "/*" in stripped_line:
            capture_doc = True
            doc_lines = []
            continue

        if "*/" in stripped_line:
            capture_doc = False
            merged_content.append(" ".join(doc_lines).strip())
            doc_lines = []
            continue

        if capture_doc:
            doc_lines.append(stripped_line)
            continue

        hcl_code.append(line)
        
    try:
        hcl_obj = hcl.loads("".join(hcl_code))
        if hcl_obj:
            merged_content.append("```hcl\n" + "".join(hcl_code) + "\n```")
    except Exception as e:
        print(f"Failed to parse HCL: {e}")

    return merged_content

def generate_markdown_with_resources(doc_lines: List[str], output_file_path: str) -> None:
    with open(output_file_path, 'w') as f:
        f.write("\n".join(doc_lines))

def main(file_path: str, output_directory: Optional[str] = None) -> None:
    output_file_name = os.path.splitext(os.path.basename(file_path))[0] + '.md'
    output_file_path = os.path.join(output_directory if output_directory else os.path.dirname(file_path), output_file_name)

    with open(file_path, 'r') as f:
        lines = f.readlines()

    doc_lines_with_resources = parse_tf_file_with_resources(lines)
    generate_markdown_with_resources(doc_lines_with_resources, output_file_path)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <Terraform_file_path> [output_directory]")
        sys.exit(1)

    terraform_file_path = sys.argv[1]
    output_directory = sys.argv[2] if len(sys.argv) > 2 else None
    main(terraform_file_path, output_directory)
