import sys
import os
import re
import logging
import argparse

logging.basicConfig(level=logging.INFO)

def is_valid_hcl_block(lines):
    """Check if a given list of lines forms a valid HCL block."""
    # You can add more sophisticated checks here if needed
    return True

def add_hcl_code_tags(lines):
    """Wrap a list of lines with HCL code tags if it's a valid HCL block."""
    if is_valid_hcl_block(lines):
        return ["```hcl"] + lines + ["```"]
    return lines

def remove_inline_comments(line):
    """Remove /* and */ inline comments from a line."""
    return re.sub(r'\/\*|\*\/', '', line)

def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(description='Process a Terraform (.tf) file.')
    parser.add_argument('input_file', help='Path to the input .tf file')
    parser.add_argument('output_folder', help='Folder where the output .code file will be saved')
    return parser.parse_args()

def main():
    args = parse_args()
    input_file = args.input_file
    output_folder = args.output_folder
    
    try:
        # Read the content from the input file
        with open(input_file, 'r') as f:
            lines = f.readlines()

        # Remove inline comments and prepare for HCL tagging
        cleaned_lines = [remove_inline_comments(line).rstrip() for line in lines]
        output_lines = []
        hcl_block = []
        in_hcl_block = False

        for line in cleaned_lines:
            if line.endswith('{'):
                in_hcl_block = True
                hcl_block.append(line)
            elif line == '}':
                hcl_block.append(line)
                output_lines.extend(add_hcl_code_tags(hcl_block))
                hcl_block = []
                in_hcl_block = False
            elif in_hcl_block:
                hcl_block.append(line)
            else:
                output_lines.append(line)

        # Prepare the output file name
        base_name = os.path.basename(input_file)
        file_name_without_extension = os.path.splitext(base_name)[0]
        output_file = os.path.join(output_folder, f"{file_name_without_extension}.code")

        # Write the cleaned content to the output file
        with open(output_file, 'w') as f:
            f.write('\n'.join(output_lines))

        logging.info(f"Successfully modified {input_file} and saved to {output_file}")
        
    except FileNotFoundError:
        logging.error(f"File {input_file} not found.")
    except PermissionError:
        logging.error(f"Permission denied for reading/writing files.")
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    main()
