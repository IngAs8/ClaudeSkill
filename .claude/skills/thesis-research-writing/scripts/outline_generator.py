#!/usr/bin/env python3
"""Generate a thesis chapter skeleton with explicit student-authorship placeholders.

Creates one Markdown file per chapter under an output directory, using the
standard structure from references/plan_template.md and marking the sections
that must be written by the student per references/authorship_map.md.

Usage:
    python outline_generator.py --title "Mi tesis" --out ./tesis
    python outline_generator.py --demo
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

# (chapter_number, filename, title, student_sections)
CHAPTERS: list[tuple[int, str, str, list[str]]] = [
    (1, "01_introduccion.md", "Introducción",
     ["Planteamiento del problema", "Justificación"]),
    (2, "02_marco_teorico.md", "Marco Teórico / Estado del Arte", []),
    (3, "03_metodologia.md", "Metodología", ["Decisiones metodológicas clave"]),
    (4, "04_resultados.md", "Resultados", []),
    (5, "05_discusion.md", "Discusión",
     ["Análisis e interpretación de los resultados"]),
    (6, "06_conclusiones.md", "Conclusiones y Recomendaciones",
     ["Conclusiones", "Recomendaciones / trabajo futuro"]),
]

STUDENT_PLACEHOLDER = (
    "<!-- REDACCION DEL ESTUDIANTE ({section}): escribe aqui tu propio "
    "analisis/argumento. No lo dejes vacio ni lo sustituyas por texto "
    "generico. Preguntas guia: que significa esto para tu pregunta de "
    "investigacion? en que se parece o difiere de los antecedentes? -->\n"
)


def build_chapter(number: int, title: str, student_sections: list[str]) -> str:
    lines = [f"# Capítulo {number}. {title}\n"]
    if student_sections:
        for section in student_sections:
            lines.append(f"## {section}\n")
            lines.append(STUDENT_PLACEHOLDER.format(section=section))
            lines.append("")
    else:
        lines.append("<!-- Borrador del asistente: revisar y ajustar énfasis. -->\n")
    return "\n".join(lines)


def generate(out_dir: Path, thesis_title: str) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    created = []

    master_plan = out_dir / "plan_maestro.md"
    if not master_plan.exists():
        master_plan.write_text(
            f"# Plan Maestro: {thesis_title}\n\n"
            "Ver references/plan_template.md en la skill para la plantilla completa.\n\n"
            "## Estado de capítulos\n\n"
            "| # | Capítulo | Estado |\n|---|---|---|\n"
            + "\n".join(f"| {n} | {t} | Pendiente |" for n, _, t, _ in CHAPTERS)
            + "\n",
            encoding="utf-8",
        )
        created.append(master_plan)

    sources_file = out_dir / "fuentes.md"
    if not sources_file.exists():
        sources_file.write_text(
            "# Fuentes\n\n| Cita corta | Tipo | Idea clave | Capítulo donde se usa |\n"
            "|---|---|---|---|\n",
            encoding="utf-8",
        )
        created.append(sources_file)

    for number, filename, title, student_sections in CHAPTERS:
        path = out_dir / filename
        if not path.exists():
            path.write_text(build_chapter(number, title, student_sections), encoding="utf-8")
            created.append(path)

    return created


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--title", default="Tesis sin título", help="Título tentativo de la tesis")
    parser.add_argument("--out", default="./tesis", help="Directorio de salida")
    parser.add_argument("--demo", action="store_true", help="Ejecuta un ejemplo en un directorio temporal")
    args = parser.parse_args()

    if args.demo:
        out_dir = Path("./tesis_demo")
        created = generate(out_dir, "Ejemplo de Tesis")
        print(f"Demo: se generaron {len(created)} archivos en {out_dir}/")
        for p in created:
            print(f"  - {p}")
        return

    created = generate(Path(args.out), args.title)
    print(f"Se generaron {len(created)} archivos en {args.out}/")
    for p in created:
        print(f"  - {p}")


if __name__ == "__main__":
    sys.exit(main() or 0)
