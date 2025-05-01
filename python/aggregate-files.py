#!/usr/bin/env python3
"""
aggregate-files.py

Recursively reads all files from a given project directory and aggregates their
contents into a single text file, preserving file boundaries. Supports optional
output directory and basic .gitignore-style pattern filtering.

Usage:
    python3 aggregate-files.py project-folder [output-folder] --gitignore path/to/.gitignore

Positional arguments:
    project-folder      Path to the root of the project to scan.
    output-folder       Directory to save the summary file. Defaults to the current working directory.

Optional arguments:
    --gitignore         Path to a .gitignore file.
                        Only basic glob patterns are supported (e.g. "*.js", "node_modules/*").
                        Advanced rules like negation (!), directory anchors (/), and recursive wildcards (**) are not supported.
                        Patterns are matched against paths relative to the project root, using forward slashes.

The output file is named <repo-name>_<timestamp>.md and contains each file's
relative path, its contents, and a delimiter.
"""

import os
import sys
import argparse
import fnmatch
from datetime import datetime
from pathlib import Path
from typing import List, Set


def parse_arguments():
    """Parses command-line arguments."""
    parser = argparse.ArgumentParser(description="Aggregate all project files into a single summary file.")
    parser.add_argument("project_folder", help="Path to the project directory.")
    parser.add_argument("output_folder", nargs="?", default=".", help="Directory to save the output summary.")
    parser.add_argument("--gitignore", help="Optional path to a .gitignore file.")
    return parser.parse_args()


def get_repo_name(path: str) -> str:
    """
    Returns the name of the project directory.

    Args:
        path: Path to the project directory.

    Returns:
        The base name of the directory.
    """
    return os.path.basename(os.path.abspath(path))


def load_gitignore_patterns(gitignore_path: str) -> Set[str]:
    """
    Loads basic ignore patterns from a .gitignore file.

    Args:
        gitignore_path: Path to the .gitignore file.

    Returns:
        A set of glob-style ignore patterns.
    """
    patterns = set()
    try:
        with open(gitignore_path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#"):
                    patterns.add(line)
    except Exception as e:
        print(f"Warning: Failed to load .gitignore file: {e}")
    return patterns


def is_ignored(path: str, ignore_patterns: Set[str]) -> bool:
    """
    Checks if a file path should be ignored based on glob-style patterns.

    Args:
        path: Relative path to the file.
        ignore_patterns: Set of glob patterns from .gitignore.

    Returns:
        True if the file should be ignored, False otherwise.
    """
    normalized_path = path.replace(os.sep, "/")
    for pattern in ignore_patterns:
        if fnmatch.fnmatch(normalized_path, pattern):
            return True
    return False


def collect_file_paths(root: str, ignore_patterns: Set[str]) -> List[str]:
    """
    Walks through the directory and collects file paths, skipping ignored files.

    Args:
        root: Project root directory.
        ignore_patterns: Set of glob-style patterns.

    Returns:
        List of relative file paths.
    """
    file_paths = []
    for dirpath, _, files in os.walk(root):
        for file in files:
            if file.startswith("."):
                continue
            full_path = os.path.join(dirpath, file)
            rel_path = os.path.relpath(full_path, root)
            if not is_ignored(rel_path, ignore_patterns):
                file_paths.append(rel_path)
    return file_paths


def write_summary(output_path: str, root: str, file_paths: List[str]):
    """
    Writes the contents of all specified files into a single summary file.

    Args:
        output_path: Path to the output file.
        root: Root directory of the project.
        file_paths: List of file paths relative to the root.
    """
    with open(output_path, "w", encoding="utf-8") as out:
        for rel_path in file_paths:
            full_path = os.path.join(root, rel_path)
            ext = Path(rel_path).suffix.lstrip(".") or ""
            out.write(f"{rel_path}\n")
            out.write(f"```{ext}\n")
            try:
                with open(full_path, "r", encoding="utf-8") as f:
                    out.write(f.read())
            except UnicodeDecodeError:
                out.write("[Skipped binary or non-UTF-8 file]")
            except Exception as e:
                out.write(f"[Error reading file: {e}]")
            out.write("\n```\n\n")
    print(f"Summary written to: {output_path}")


def main():
    args = parse_arguments()

    project_root = os.path.abspath(args.project_folder)
    output_dir = os.path.abspath(args.output_folder)
    gitignore_path = args.gitignore

    if not os.path.isdir(project_root):
        print(f"Error: {project_root} is not a valid directory.")
        sys.exit(1)

    if not os.path.isdir(output_dir):
        print(f"Error: {output_dir} is not a valid output directory.")
        sys.exit(1)

    repo_name = get_repo_name(project_root)
    timestamp = datetime.now().strftime("%Y-%m-%d_%H%M")
    output_filename = f"{repo_name}_{timestamp}.md"
    output_path = os.path.join(output_dir, output_filename)

    ignore_patterns = load_gitignore_patterns(gitignore_path) if gitignore_path else set()
    file_paths = collect_file_paths(project_root, ignore_patterns)
    write_summary(output_path, project_root, file_paths)


if __name__ == "__main__":
    main()
