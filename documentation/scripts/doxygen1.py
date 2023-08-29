import os
import sys
from typing import List, Optional

def capture_code_block(lines: iter, end_line: str, title: str) -> str:
    block_lines = [title.rstrip('\n')]  # Add the first line
    open_braces = title.count('{')
    close_braces = title.count('}')
    
    for line in lines:
        open_braces += line.count('{')
        close_braces += line.count('}')
        block_lines.append(line.rstrip('\n'))  # Add the line
        
        if open_braces == close_braces:
            return "\n```hcl\n" + "\n".join(block_lines) + "\n```\n"

def parse_tf_file_with_resources(lines: List[str]) -> List[str]:
    lines_iter = iter(lines)
    merged_content = []
    comment_block = ""

    for line in lines_iter:
        # Capture comment blocks
        if line.strip().startswith("/*"):
            comment_block = line.strip("/*").strip("*/").strip()
            continue

        # Capture Terraform blocks
        if any(keyword in line for keyword in ["resource ", "module ", "locals ", "data "]):
            code_block = capture_code_block(lines_iter, "}", line)
            if comment_block:
                # Remove /* and */ from comment_block
                comment_block_clean = comment_block.replace("/*", "").replace("*/", "").strip()
                merged_content.append(f"### {comment_block_clean}\n{code_block}")
                comment_block = ""  # Clear comment block for next iteration
            else:
                merged_content.append(code_block)

    return merged_content


def generate_markdown_with_resources(doc_lines: List[str], output_file_path: str) -> None:
    with open(output_file_path, 'w') as f:
        f.write("\n".join(doc_lines))

def main(file_path: str, output_directory: Optional[str] = None) -> None:
    output_file_name = os.path.splitext(os.path.basename(file_path))[0] + '.code'
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
