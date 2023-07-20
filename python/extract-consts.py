import os
import re
import sys

"""
Search a given directory and all subdirectories for specified file types, extract all SCREAMING_SNAKE_CASE
constants along with their values, and print them alphabetically.

Usage:
    python script_name.py <root_directory> <file_extensions>

Arguments:
    - root_directory: The root directory to search.
    - file_extensions: Comma-separated list of file extensions to check, e.g. ".py,.js,.jsx".

Functions:
    - find_constants(file_path): Extract constants and their values from the specified file.
    - main(directory, extensions): Search for constants in all specified file types within the given directory and print them.
"""
def find_constants(file_path):
    """Extract all SCREAMING_SNAKE_CASE constants from a file."""
    with open(file_path, 'r') as f:
        content = f.read()
        pattern = r'\b([A-Z][A-Z0-9_]{2,})\s*=\s*(.*)'
        matches = re.findall(pattern, content)
        return set(matches)

def main(directory, extensions):
    all_constants = set()

    # Convert extensions to a set for faster lookup
    ext_set = set(extensions.split(","))

    # Get a list of all files with specified extensions in the directory
    files = [os.path.join(root, f) for root, _, files in os.walk(directory) for f in files if f.endswith(tuple(ext_set))]

    total_files = len(files)

    for idx, file_path in enumerate(files, 1):
        constants = find_constants(file_path)
        all_constants.update(constants)

        progress = (idx / total_files) * 100
        sys.stdout.write(f'\rProgress: {progress:.2f}%')
        sys.stdout.flush()

    print("\nFound constants:")
    for const, value in sorted(all_constants):
        print(f'{const} = {value}')

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python script_name.py <root_directory> <file_extensions>")
        sys.exit(1)

    directory = sys.argv[1]
    extensions = sys.argv[2]
    main(directory, extensions)

