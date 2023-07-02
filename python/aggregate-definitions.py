import os
import sys
import glob

def combine_files(target_dir, output_file):
    """
    Combine and format JavaScript and TypeScript files from a specified directory.

    This function reads all .ts, .tsx, .js, .jsx files in the given target directory, 
    excluding lines starting with 'import'. It formats the content by enclosing it 
    within markdown code blocks, preceded by the filename. The formatted content is 
    written to the specified output file. 

    Parameters:
    target_dir (str): The directory to search for files.
    output_file (str): The output file path (defaults: 'combined.md').

    Example usage:
    python3 combine-files.py target_directory output_file
    """
    types = ('**/*.ts', '**/*.tsx', '**/*.js', '**/*.jsx') 
    files_grabbed = []
    for files in types:
        files_grabbed.extend(glob.glob(target_dir + files, recursive=True))

    with open(output_file, 'w') as outfile:
        for fname in files_grabbed:
            outfile.write(f'{os.path.basename(fname)}\n```tsx\n')
            with open(fname) as infile:
                lines = infile.readlines()
                # Strip leading and trailing newlines
                lines = [line for line in lines if line.strip()]
                for line in lines:
                    if not line.strip().startswith('import'):
                        outfile.write(line)
            outfile.write('```\n\n')

if __name__ == "__main__":
    target_dir = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else os.getcwd() + '/combined.md'
    combine_files(target_dir, output_file)