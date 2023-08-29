import os
import sys
from typing import List, Optional

def capture_comment_block(lines: iter, start_line: str, end_line: str) -> str:
    block_lines = []
    for line in lines:
        stripped_line = line.strip()
        if end_line in stripped_line:
            return "\n".join(block_lines).strip()
        block_lines.append(stripped_line)

def capture_code_block(lines: iter, end_line: str, title: str) -> str:
    block_lines = []
    title_stripped = title.strip('"')
    title_str = f'title="{title_stripped}"'
    include_first_line = True  # Flag to include the first line
    
    for line in lines:
        stripped_line = line.strip()
        
        if include_first_line:
            block_lines.append(stripped_line)  # Include the first line
            include_first_line = False  # Reset the flag
        elif stripped_line == end_line:
            block_lines.append(stripped_line)  # Include the last line
            return f"```hcl {title_str}\n{''.join(block_lines)}\n```"
        else:
            block_lines.append(line)




def parse_tf_file_with_resources(lines: List[str]) -> List[str]:
    lines_iter = iter(lines)
    merged_content = []

    for line in lines_iter:
        stripped_line = line.strip()

        if "/*" in stripped_line:
            comment_block = capture_comment_block(lines_iter, stripped_line, "*/")
            merged_content.append(comment_block)
            continue

        if any(keyword in stripped_line for keyword in ["resource", "module", "data"]):
            title = stripped_line.split(" ")[1]
            code_block = capture_code_block(lines_iter, "}", title)
            merged_content.append(code_block)
            continue

        if "locals" in stripped_line:
            title = "Local Variables"
            code_block = capture_code_block(lines_iter, "}", title)
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
    if len(sys.argv) < 2:
        print("Usage: python script.py <Terraform_file_path> [output_directory]")
        sys.exit(1)

    terraform_file_path = sys.argv[1]
    output_directory = sys.argv[2] if len(sys.argv) > 2 else None
    main(terraform_file_path, output_directory)
