#!/usr/bin/env python3
"""Scan thesis chapter Markdown files for pending student-authorship sections.

Looks for the placeholder marker inserted by outline_generator.py
("REDACCION DEL ESTUDIANTE") and reports, per file: whether each marked
section still contains the placeholder (pending) or has been replaced with
actual content, plus a word count per file to track drafting progress.

Usage:
    python section_scanner.py --dir ./tesis
    python section_scanner.py --demo
"""

from __future__ import annotations

import argparse
import re
import sys
import tempfile
from pathlib import Path

PLACEHOLDER_RE = re.compile(r"REDACCION DEL ESTUDIANTE \(([^)]*)\)")
HEADING_RE = re.compile(r"^##\s+(.+)$", re.MULTILINE)


def word_count(text: str) -> int:
    return len(re.findall(r"\S+", text))


def scan_file(path: Path) -> dict:
    text = path.read_text(encoding="utf-8")
    placeholders = PLACEHOLDER_RE.findall(text)
    return {
        "file": str(path),
        "words": word_count(text),
        "pending_sections": placeholders,
    }


def scan_dir(directory: Path) -> list[dict]:
    results = []
    for path in sorted(directory.glob("*.md")):
        if path.name in {"plan_maestro.md", "fuentes.md"}:
            continue
        results.append(scan_file(path))
    return results


def print_report(results: list[dict]) -> None:
    total_pending = 0
    for r in results:
        status = "OK" if not r["pending_sections"] else f"{len(r['pending_sections'])} pendiente(s)"
        print(f"{r['file']}: {r['words']} palabras — {status}")
        for section in r["pending_sections"]:
            print(f"    - Falta redacción del estudiante: {section}")
            total_pending += 1
    print()
    if total_pending:
        print(f"Total de secciones pendientes de redacción del estudiante: {total_pending}")
    else:
        print("No quedan placeholders de redacción del estudiante sin completar.")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dir", default="./tesis", help="Directorio con los capítulos en Markdown")
    parser.add_argument("--demo", action="store_true", help="Ejecuta un ejemplo con archivos temporales")
    args = parser.parse_args()

    if args.demo:
        with tempfile.TemporaryDirectory() as tmp:
            tmp_dir = Path(tmp)
            (tmp_dir / "05_discusion.md").write_text(
                "# Capítulo 5. Discusión\n\n"
                "## Análisis e interpretación de los resultados\n\n"
                "<!-- REDACCION DEL ESTUDIANTE (Análisis e interpretación de los resultados): "
                "escribe aqui tu propio analisis. -->\n",
                encoding="utf-8",
            )
            (tmp_dir / "02_marco_teorico.md").write_text(
                "# Capítulo 2. Marco Teórico\n\nTexto ya redactado por el asistente y revisado.\n",
                encoding="utf-8",
            )
            results = scan_dir(tmp_dir)
            print("Demo:")
            print_report(results)
        return

    directory = Path(args.dir)
    if not directory.exists():
        print(f"No existe el directorio: {directory}", file=sys.stderr)
        sys.exit(1)

    results = scan_dir(directory)
    if not results:
        print(f"No se encontraron capítulos .md en {directory}")
        return
    print_report(results)


if __name__ == "__main__":
    sys.exit(main() or 0)
