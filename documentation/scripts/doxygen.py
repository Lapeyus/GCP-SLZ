import os
import sys
import argparse
from typing import List, Iterator, Optional

def capture_block(lines: Iterator[str], end_line: str, include_start: bool, include_end: bool) -> str:
    block_lines = []
    for line in lines:
        stripped_line = line.strip()
        if stripped_line == end_line:
            if include_end:
                block_lines.append(stripped_line)
            return "\n".join(block_lines).strip()
        if include_start or block_lines:
            block_lines.append(stripped_line)

def parse_tf_file_with_resources(lines: List[str]) -> List[str]:
    lines_iter = iter(lines)
    merged_content = []

    for line in lines_iter:
        stripped_line = line.strip()

        if "/*" in stripped_line:
            comment_block = capture_block(lines_iter, "*/", False, False)
            merged_content.append(comment_block)
            continue

        if any(keyword in stripped_line for keyword in ["resource", "module", "locals", "data"]):
            code_block = f"```hcl\n{capture_block(lines_iter, '}', True, True)}\n```"
            merged_content.append(code_block)
            continue

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
    parser = argparse.ArgumentParser(description='Process Terraform files.')
    parser.add_argument('file_path', help='Path to the Terraform file')
    parser.add_argument('--output_directory', help='Directory to save the output', default=None)
    args = parser.parse_args()

    main(args.file_path, args.output_directory)
