#!/usr/bin/env python3

import argparse
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from typing import List, Optional
import pathspec


def parse_arguments():
    parser = argparse.ArgumentParser(description="Aggregate project files into a single Markdown file.")
    parser.add_argument("project_folder", help="Path to the root of the Git project.")
    parser.add_argument("output_folder", nargs="?", default=".", help="Directory to save the output file.")
    parser.add_argument("--gitignore", help="Path to a .gitignore-style file (like .llmignore).")
    parser.add_argument("--debug", action="store_true", help="Show detailed output and read errors.")
    return parser.parse_args()


def run_git_ls_files(repo_path: Path) -> List[str]:
    try:
        result = subprocess.run(
            ["git", "-C", str(repo_path), "ls-files", "--cached", "--others", "--exclude-standard"],
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout.strip().splitlines()
    except subprocess.CalledProcessError as e:
        print(f"❌ Error: git ls-files failed:\n{e.stderr}")
        sys.exit(1)


def load_pathspec(gitignore_path: Optional[Path], debug: bool) -> Optional[pathspec.PathSpec]:
    if not gitignore_path or not gitignore_path.is_file():
        if debug:
            print("❌ .llmignore path is invalid or missing")
        return None

    with gitignore_path.open("r", encoding="utf-8") as f:
        raw_lines = [line.strip() for line in f if line.strip() and not line.strip().startswith("#")]

    processed = []
    for line in raw_lines:
        if "/" not in line and not line.startswith("**/"):
            processed.append(f"**/{line}")
        else:
            processed.append(line)

    if debug:
        print(f"✅ Loaded {len(processed)} processed patterns from {gitignore_path}")
        for pat in processed:
            print(f"   - {pat}")

    return pathspec.PathSpec.from_lines("gitwildmatch", processed)


def filter_with_pathspec(files: List[str], spec: Optional[pathspec.PathSpec], debug: bool) -> List[str]:
    if not spec:
        if debug:
            print("⚠️  No extra ignore patterns provided.")
        return files

    kept = []
    for f in files:
        if spec.match_file(f):
            if debug:
                print(f"❌ Excluded by .llmignore: {f}")
        else:
            kept.append(f)

    if debug:
        print(f"✅ Kept {len(kept)} / {len(files)} files after filtering.")
    return kept


def human_readable_size(path: Path) -> str:
    size = path.stat().st_size
    for unit in ["B", "KB", "MB", "GB"]:
        if size < 1024:
            return f"{size:.1f} {unit}"
        size /= 1024
    return f"{size:.1f} TB"


def write_aggregate_markdown(
    repo_root: Path, output_path: Path, files: List[str], debug: bool
) -> tuple[int, int, list[str]]:
    total_lines = 0
    errors = []

    with output_path.open("w", encoding="utf-8") as out:
        for rel_path in files:
            full_path = repo_root / rel_path
            ext = full_path.suffix.lstrip(".")
            out.write(f"{rel_path}\n")
            out.write(f"```{ext}\n")
            try:
                with full_path.open("r", encoding="utf-8") as f:
                    for line in f:
                        out.write(line)
                        total_lines += 1
            except UnicodeDecodeError:
                errors.append(f"{rel_path} [non-UTF-8]")
                out.write("[Skipped non-UTF-8 file]\n")
            except Exception as e:
                errors.append(f"{rel_path} [Error: {e}]")
                out.write(f"[Error reading file: {e}]\n")
            out.write("```\n\n")

    return len(files), total_lines, errors


def main():
    args = parse_arguments()
    project_root = Path(args.project_folder).resolve()
    output_dir = Path(args.output_folder).resolve()

    if not (project_root / ".git").is_dir():
        print(f"❌ Error: {project_root} is not a Git repository.")
        sys.exit(1)

    output_dir.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now().strftime("%Y-%m-%d_%H%M%S")
    output_path = output_dir / f"{project_root.name}_{timestamp}.md"

    if args.debug:
        print(f"🔍 Scanning Git repo: {project_root}")

    all_git_files = run_git_ls_files(project_root)
    spec = load_pathspec(Path(args.gitignore), args.debug) if args.gitignore else None
    final_files = filter_with_pathspec(all_git_files, spec, args.debug)
    final_files.sort()

    if args.debug:
        print("\n🔎 Final included files:")
        for f in final_files:
            full_path = project_root / f
            size_kb = full_path.stat().st_size / 1024
            print(f"  {f} — {size_kb:.1f} KB")

    file_count, line_count, errors = write_aggregate_markdown(project_root, output_path, final_files, args.debug)
    size_str = human_readable_size(output_path)

    print(f"\n✅ Processed {file_count} files from {project_root}")
    print(f"📄 Total lines: {line_count:,}")
    print(f"📦 File size: {size_str}")
    print(f"📁 Output: {output_path}")

    if errors:
        print(f"⚠️  Encountered {len(errors)} read errors")
        if args.debug:
            print("\n--- Read Errors ---")
            for err in errors:
                print(err)


if __name__ == "__main__":
    main()
