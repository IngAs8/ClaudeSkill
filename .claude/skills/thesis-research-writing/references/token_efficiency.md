# Optimización de Tokens en Proyectos de Tesis Largos

Una tesis puede superar fácilmente el contexto disponible si se maneja como un solo documento monolítico en el chat. Prácticas recomendadas:

## 1. Un capítulo a la vez
Trabajar y revisar un capítulo por sesión/tema. No pegar ni releer los demás capítulos salvo que la tarea actual dependa de ellos (p. ej., revisar coherencia de la Discusión con el Marco teórico).

## 2. `plan_maestro.md` como única fuente de verdad
Mantener un archivo corto (basado en `plan_template.md`) con el estado del proyecto: qué capítulo está en qué fase, pendientes, decisiones clave ya tomadas. Consultarlo y actualizarlo en vez de reconstruir el contexto completo en cada turno.

## 3. Síntesis de fuentes, no texto completo
Guardar en `fuentes.md` un resumen de 2-4 líneas por fuente (idea clave + dónde se usa), no el PDF/artículo completo. Releer la fuente completa solo si hace falta una cita textual exacta.

## 4. Lectura parcial de archivos largos
Al revisar un capítulo ya extenso, leer solo el rango de líneas/sección relevante (p. ej., la sección de Discusión) en lugar de todo el archivo.

## 5. Diffs en vez de reescritura completa
Al aplicar correcciones, editar los fragmentos puntuales señalados por la rúbrica (`review_rubric.md`) en vez de regenerar el capítulo entero.

## 6. Plantillas y checklists reutilizables
Usar las plantillas de `references/` (plan, autoría, rúbrica, diseño) en vez de redactar instrucciones nuevas cada vez que se retoma el proyecto.

## 7. Delegar tareas mecánicas a scripts
Usar `scripts/outline_generator.py` y `scripts/section_scanner.py` para generar esqueletos y detectar secciones pendientes automáticamente, en vez de describir manualmente el estado de cada capítulo.

## 8. Consolidar solo al final
Ensamblar el documento completo (portada, índice, capítulos, referencias) recién en la fase de formato final (`document_design.md`), no en cada iteración de redacción.
