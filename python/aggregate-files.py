#!/usr/bin/env python3

import argparse
import subprocess
import sys
import re
from datetime import datetime
from pathlib import Path
from typing import List, Set


def parse_arguments():
    parser = argparse.ArgumentParser(description="Aggregate all project files into a single Markdown summary.")
    parser.add_argument("project_folder", help="Path to the root of the project to scan.")
    parser.add_argument("output_folder", nargs="?", default=".", help="Directory to save the output summary.")
    parser.add_argument("--gitignore", help="Optional path to a .gitignore-style file for additional ignores.")
    parser.add_argument("--exclude-regex", help="Optional regex to exclude files by path.")
    parser.add_argument("--debug", action="store_true", help="Show detailed file read errors.")
    return parser.parse_args()


def get_repo_name(path: Path) -> str:
    return path.name


def load_extra_gitignore_patterns(gitignore_path: Path) -> Set[str]:
    patterns = set()
    try:
        with gitignore_path.open("r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and not line.startswith("!"):
                    patterns.add(line)
    except Exception as e:
        print(f"Warning: Failed to load extra .gitignore file: {e}")
    return patterns


def run_git_ls_files(repo_path: Path) -> List[str]:
    try:
        result = subprocess.run(
            ["git", "-C", str(repo_path), "ls-files", "--cached", "--others", "--exclude-standard"],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip().splitlines()
    except subprocess.CalledProcessError as e:
        print(f"Error: Failed to run git ls-files: {e}")
        sys.exit(1)


def apply_manual_filters(paths: List[str], repo_path: Path, extra_patterns: Set[str], regex: str | None) -> List[str]:
    filtered = []
    for path in paths:
        abs_path = repo_path / path
        if not abs_path.is_file():
            continue
        if any(Path(path).match(p) for p in extra_patterns):
            continue
        if regex and re.search(regex, path):
            continue
        filtered.append(path)
    return filtered


def write_summary(output_path: Path, root: Path, file_paths: List[str], debug: bool) -> tuple[int, int, List[str]]:
    total_lines = 0
    errors = []

    with output_path.open("w", encoding="utf-8") as out:
        for rel_path in file_paths:
            full_path = root / rel_path
            ext = full_path.suffix.lstrip(".")
            out.write(f"{rel_path}\n")
            out.write(f"```{ext}\n")
            try:
                with full_path.open("r", encoding="utf-8") as f:
                    for line in f:
                        out.write(line)
                        total_lines += 1
            except UnicodeDecodeError:
                msg = f"{rel_path} [Skipped: non-UTF-8]"
                errors.append(msg)
                out.write("[Skipped binary or non-UTF-8 file]\n")
            except Exception as e:
                msg = f"{rel_path} [Error: {e}]"
                errors.append(msg)
                out.write(f"[Error reading file: {e}]\n")
            out.write("```\n\n")

    return len(file_paths), total_lines, errors


def human_readable_size(filepath: Path) -> str:
    size_bytes = filepath.stat().st_size
    for unit in ["B", "KB", "MB", "GB"]:
        if size_bytes < 1024:
            return f"{size_bytes:.1f} {unit}"
        size_bytes /= 1024
    return f"{size_bytes:.1f} TB"


def main():
    args = parse_arguments()

    project_root = Path(args.project_folder).resolve()
    output_dir = Path(args.output_folder).resolve()

    if not project_root.is_dir():
        print(f"Error: {project_root} is not a valid directory.")
        sys.exit(1)

    if not (project_root / ".git").exists():
        print(f"Error: {project_root} is not a Git repository.")
        sys.exit(1)

    if not output_dir.is_dir():
        print(f"Error: {output_dir} is not a valid output directory.")
        sys.exit(1)

    repo_name = get_repo_name(project_root)
    timestamp = datetime.now().strftime("%Y-%m-%d_%H%M%S")
    output_filename = f"{repo_name}_{timestamp}.md"
    output_path = output_dir / output_filename

    print(f"🔍 Scanning: {project_root}")

    base_files = run_git_ls_files(project_root)
    extra_patterns = load_extra_gitignore_patterns(Path(args.gitignore)) if args.gitignore else set()
    filtered_files = apply_manual_filters(base_files, project_root, extra_patterns, args.exclude_regex)
    filtered_files.sort()

    file_count, total_lines, errors = write_summary(output_path, project_root, filtered_files, args.debug)
    file_size = human_readable_size(output_path)

    print(f"\n✅ Processed {file_count} files from {project_root}")
    print(f"📄 Aggregated output has {total_lines:,} lines")
    print(f"📦 Total size: {file_size}")
    print(f"📁 Saved to: {output_path}")

    if errors:
        print(f"⚠️ Encountered {len(errors)} file read errors.")
        if args.debug:
            print("\n--- Error Log ---")
            for err in errors:
                print(err)


if __name__ == "__main__":
    main()
