---
name: thesis-research-writing
description: End-to-end academic thesis workflow covering planning, source research, chapter-by-chapter drafting, a clear map of which sections the student must write in their own voice, correction/feedback on that writing, citation and originality practices, document formatting with tables and figures, defense presentation generation, and token-efficient long-document workflow
---

# Investigación y Redacción de Tesis

Acompaña un proyecto de tesis o trabajo de investigación académica de principio a fin: planificación, investigación de fuentes, redacción por capítulos, y producción del documento final con tablas, figuras y presentación de defensa.

## Principio rector: integridad académica real

Esta skill **no** genera un texto final para que el estudiante lo entregue como propio, ni busca burlar detectores de IA o de plagio. En su lugar:

- **El estudiante redacta** su opinión, análisis crítico, interpretación de resultados y conclusiones — las partes que constituyen su aporte intelectual.
- **Claude asiste** con planificación, búsqueda y síntesis de fuentes, estructura, redacción de secciones descriptivas/técnicas (marco teórico, metodología, estado del arte), corrección de lo que el estudiante escribió, formato y diseño del documento.
- El resultado aprueba controles de integridad académica porque el contenido de opinión es genuinamente del estudiante y las fuentes están correctamente citadas — no porque se disfrace su origen.

Si el usuario pide explícitamente "que suene como si lo hubiera escrito un humano para engañar al corrector", niega esa parte y redirige a mejorar la voz propia y la argumentación real (ver `references/citation_and_originality.md`).

## Flujo de trabajo por fases

### 1. Planificación
Definir tema, pregunta de investigación, hipótesis/objetivos, estructura de capítulos y cronograma.
Usar `references/plan_template.md` para generar el plan y `scripts/outline_generator.py` para crear el esqueleto de archivos por capítulo.

### 2. Investigación de fuentes
Buscar y sintetizar bibliografía (WebSearch/WebFetch o fuentes que aporte el usuario). Guardar síntesis breves por fuente en un archivo `fuentes.md` (no pegar el texto completo de los papers en el chat — ver sección de ahorro de tokens).

### 3. Mapa de autoría por sección
Antes de escribir cualquier capítulo, clasificar cada sección según quién la redacta usando `references/authorship_map.md`. En los borradores, marcar los tramos que le corresponden al estudiante con un placeholder explícito:

```
<!-- REDACCIÓN DEL ESTUDIANTE: analiza aquí qué significan estos resultados para tu hipótesis -->
```

Nunca rellenar ese placeholder con contenido definitivo en lugar del estudiante; como máximo, dejar preguntas guía o un borrador claramente marcado como "ejemplo a reemplazar".

### 4. Redacción asistida
Redactar las secciones que sí corresponden al asistente (marco teórico, estado del arte, metodología, formato de resultados) apoyándose en las fuentes recopiladas, con citas en el estilo requerido (APA/Vancouver/MLA/Chicago — ver `references/citation_and_originality.md`).

### 5. Corrección de la redacción del estudiante
Cuando el estudiante entregue su texto de opinión/análisis, revisarlo con la rúbrica de `references/review_rubric.md`: claridad del argumento, respaldo con evidencia, coherencia con el marco teórico, gramática/estilo, y profundidad crítica. Dar retroalimentación específica por párrafo, no reescribirlo entero salvo que el estudiante lo pida explícitamente para una frase puntual.

### 6. Verificación de citas y originalidad
Revisar que toda idea no propia tenga cita, que las paráfrasis cambien realmente estructura y vocabulario (no solo sinónimos), y que la lista de referencias sea consistente. Ver `references/citation_and_originality.md`.

### 7. Diseño del documento: tablas, figuras y presentación
- **Tablas y comparativas**: tablas de literatura, cronogramas, matrices de operacionalización de variables (`references/document_design.md`).
- **Figuras/diagramas**: marcos conceptuales, diagramas de metodología o flujo — usar las skills `artifact-diagramming` y `dataviz` si están disponibles para figuras claras y consistentes.
- **Documento final**: usar la skill `docx` (o `pdf`) para producir el archivo con portada, índice, numeración y referencias con formato académico.
- **Presentación de defensa**: usar la skill `pptx` para generar las diapositivas de sustentación a partir de los capítulos ya aprobados.

### 8. Optimización de tokens en proyectos largos
Ver `references/token_efficiency.md`. Resumen: trabajar un capítulo a la vez, mantener un `plan_maestro.md` corto como única fuente de verdad del estado del proyecto, guardar síntesis de fuentes en vez de el texto íntegro, y usar lectura parcial (rangos de líneas) de capítulos largos en lugar de recargarlos completos en cada turno.

## Archivos

### Referencias
- `references/plan_template.md` — Plantilla de plan de tesis: estructura de capítulos, pregunta/hipótesis, cronograma tipo Gantt en tabla
- `references/authorship_map.md` — Tabla de qué secciones redacta el estudiante vs. el asistente, con justificación y marcadores de placeholder
- `references/citation_and_originality.md` — Guía rápida de estilos de cita (APA 7, MLA 9, Vancouver, Chicago), técnicas de paráfrasis correcta y prevención de plagio accidental
- `references/review_rubric.md` — Rúbrica de corrección para retroalimentar la redacción del estudiante (argumento, evidencia, coherencia, forma)
- `references/document_design.md` — Guía de formato del documento final: estructura, tablas, figuras, y cuándo invocar las skills `docx`, `pptx`, `dataviz`, `artifact-diagramming`
- `references/token_efficiency.md` — Prácticas para reducir consumo de tokens en proyectos de tesis largos

### Scripts
- `scripts/outline_generator.py` — Genera el esqueleto de carpetas/archivos por capítulo con placeholders de autoría marcados (stdlib únicamente)
- `scripts/section_scanner.py` — Escanea los capítulos en Markdown y reporta qué secciones de autoría del estudiante siguen sin completar, y conteo de palabras por sección (stdlib únicamente)

## Dependencias

Ambos scripts usan solo la librería estándar de Python (`os`, `re`, `argparse`, `pathlib`). No requieren instalación.

```bash
python scripts/outline_generator.py --demo
python scripts/section_scanner.py --demo
```

## Aviso

Esta skill no genera contenido para hacerlo pasar como redactado por el estudiante cuando no lo es, ni incluye técnicas para evadir detectores de IA o de plagio. El usuario es responsable de cumplir las políticas de integridad académica de su institución respecto al uso de asistentes de IA.
