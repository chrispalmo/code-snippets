import argparse
import ast
import os
from pathlib import Path

def extract_summary_from_file(filepath, include_docstrings=True):
    with open(filepath, "r", encoding="utf-8") as f:
        source = f.read()

    try:
        tree = ast.parse(source, filename=filepath)
    except SyntaxError:
        return f"# Skipped {filepath} due to syntax error"

    lines = []
    rel_path = str(filepath)
    lines.append(f"{rel_path}>>>")

    # Collect import statements
    for node in tree.body:
        if isinstance(node, (ast.Import, ast.ImportFrom)):
            lines.append(source.splitlines()[node.lineno - 1])

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

    def summarize_function(node, prefix="def"):
        sig = f"{prefix} {node.name}({format_args(node.args)})"
        if node.returns:
            sig += f" -> {ast.unparse(node.returns)}"
        sig += ":"
        lines.append(sig)
        if include_docstrings and (doc := ast.get_docstring(node)):
            lines.append(f'    """{doc}"""')

    for node in tree.body:
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            summarize_function(node, prefix="async def" if isinstance(node, ast.AsyncFunctionDef) else "def")

        elif isinstance(node, ast.ClassDef):
            lines.append(f"class {node.name}:")
            if include_docstrings and (doc := ast.get_docstring(node)):
                lines.append(f'    """{doc}"""')
            for item in node.body:
                if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    summarize_function(item, prefix="    async def" if isinstance(item, ast.AsyncFunctionDef) else "    def")

    lines.append("<<<\n")
    return "\n".join(lines)

def main():
    parser = argparse.ArgumentParser(description="Summarize Python source files for LLM context.")
    parser.add_argument("project_dir", help="Path to the project directory")
    parser.add_argument("--no-docstrings", action="store_true", help="Exclude docstrings from output")
    args = parser.parse_args()

    project_path = Path(args.project_dir)
    include_docstrings = not args.no_docstrings

    all_output = []

    for filepath in project_path.rglob("*.py"):
        if filepath.is_file():
            summary = extract_summary_from_file(filepath, include_docstrings)
            all_output.append(summary)

    print("\n".join(all_output))

if __name__ == "__main__":
    main()

