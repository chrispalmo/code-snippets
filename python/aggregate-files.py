import os
import sys
from datetime import datetime

def get_repo_name():
    return os.path.basename(os.getcwd())

def summarize_files(output_dir):
    repo_name = get_repo_name()
    timestamp = datetime.now().strftime("%Y-%m-%d_%H%M")
    output_filename = f"{repo_name}_{timestamp}.txt"
    
    # Ensure output directory is valid and writable
    output_dir = os.path.abspath(output_dir)
    if not os.path.isdir(output_dir):
        print(f"Error: {output_dir} is not a directory.")
        sys.exit(1)
    
    output_path = os.path.join(output_dir, output_filename)
    
    with open(output_path, "w", encoding="utf-8") as out:
        for root, _, files in os.walk(os.getcwd()):
            for file in files:
                if file.startswith("."):
                    continue
                file_path = os.path.join(root, file)
                rel_path = os.path.relpath(file_path, os.getcwd())
                
                out.write(f"{rel_path} >>>\n\n")
                
                try:
                    with open(file_path, "r", encoding="utf-8") as f:
                        out.write(f.read())
                except Exception as e:
                    out.write(f"[Error reading file: {e}]")
                
                out.write("\n\n<<<\n\n")
    
    print(f"Summary written to: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <output_directory>")
        sys.exit(1)
    
    output_arg = sys.argv[1]
    if output_arg == ".":
        output_arg = os.getcwd()
    
    summarize_files(output_arg)

