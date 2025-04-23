import argparse
import ast
from pathlib import Path

def extract_signatures(filepath, include_docstrings=True):
    """
    Extract function and class signatures (with optional docstrings) from a Python file.
    Returns content wrapped in Markdown code block format.
    """
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            source = f.read()
        tree = ast.parse(source, filename=filepath)
    except Exception as e:
        return f"{filepath}\n```python\n# Skipped: {e}\n```\n"

    lines = []

    def format_args(args_node):
        args = []
        for arg in args_node.args:
            arg_str = arg.arg
            if arg.annotation:
                arg_str += f": {ast.unparse(arg.annotation)}"
            args.append(arg_str)
        if args_node.vararg:
            args.append(f"*{args_node.vararg.arg}")
        for kwarg in args_node.kwonlyargs:
            arg_str = kwarg.arg
            if kwarg.annotation:
                arg_str += f": {ast.unparse(kwarg.annotation)}"
            args.append(arg_str)
        if args_node.kwarg:
            args.append(f"**{args_node.kwarg.arg}")
        return ", ".join(args)

    def summarize_function(node, indent=""):
        prefix = "async def" if isinstance(node, ast.AsyncFunctionDef) else "def"
        sig = f"{indent}{prefix} {node.name}({format_args(node.args)})"
        if node.returns:
            sig += f" -> {ast.unparse(node.returns)}"
        sig += ":"
        lines.append(sig)
        if include_docstrings and (doc := ast.get_docstring(node)):
            lines.append(f'{indent}    """{doc}"""')

    for node in tree.body:
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            summarize_function(node)
        elif isinstance(node, ast.ClassDef):
            lines.append(f"class {node.name}:")
            if include_docstrings and (doc := ast.get_docstring(node)):
                lines.append(f'    """{doc}"""')
            for item in node.body:
                if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    summarize_function(item, indent="    ")

    return f"{filepath}\n```python\n" + "\n".join(lines) + "\n```\n"

def dump_file_contents(filepath):
    """
    Return entire file contents wrapped in Markdown code block format.
    """
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
        return f"{filepath}\n```python\n{content.rstrip()}\n```\n"
    except Exception as e:
        return f"{filepath}\n```python\n# Error reading file: {e}\n```\n"

def main():
    """
    CLI entry point. Use:
        python summarize-python-project.py <project_dir> <output_file> [--signatures-only] [--no-docstrings]
    """
    parser = argparse.ArgumentParser(description="Summarize or dump Python files in a directory.")
    parser.add_argument("project_dir", help="Directory to scan recursively for .py files")
    parser.add_argument("output_file", help="Path to output file where results will be written")
    parser.add_argument("--no-docstrings", action="store_true", help="Exclude docstrings from summary output")
    parser.add_argument("--signatures-only", action="store_true", help="Only output function/class signatures and imports")
    args = parser.parse_args()

    include_docstrings = not args.no_docstrings
    project_path = Path(args.project_dir)
    output_path = Path(args.output_file)

    all_output = []

    for filepath in project_path.rglob("*.py"):
        if filepath.is_file():
            if args.signatures_only:
                summary = extract_signatures(filepath, include_docstrings)
            else:
                summary = dump_file_contents(filepath)
            all_output.append(summary)

    output_path.write_text("".join(all_output), encoding="utf-8")

if __name__ == "__main__":
    main()
