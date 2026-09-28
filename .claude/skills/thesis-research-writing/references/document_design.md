# Diseño del Documento: Tablas, Figuras y Presentación

## Estructura estándar del documento final

1. Portada (institución, título, autor, asesor, fecha)
2. Resumen / Abstract (con palabras clave)
3. Índice / Tabla de contenidos
4. Índice de tablas e índice de figuras
5. Capítulos (según `plan_maestro.md`)
6. Referencias / Bibliografía
7. Anexos

## Tablas

Usar tablas para:
- Comparación de literatura (autor, año, método, hallazgo principal)
- Operacionalización de variables (variable, definición, indicador, instrumento)
- Cronograma
- Presentación de resultados cuantitativos (medias, desviaciones, valores p, etc.)

Convenciones:
- Numerar y titular cada tabla (`Tabla 4.1. Estadísticos descriptivos de la muestra`).
- Fuente de la tabla al pie si los datos no son de elaboración propia.
- Para datos extensos o cálculos, usar la skill `xlsx` y enlazar o exportar la tabla resumida al documento en vez de pegar filas y filas en el texto.

## Figuras y diagramas

- Marco conceptual / modelo teórico: diagrama de relaciones entre variables.
- Diagrama de metodología: flujo de recolección/análisis de datos.
- Gráficos de resultados: usar la skill `dataviz` para elegir el tipo de gráfico correcto (barra, dispersión, línea) y una paleta de color consistente y accesible.
- Diagramas de proceso o de sistema: usar la skill `artifact-diagramming` cuando el diagrama se construya como artifact (SVG/HTML) antes de incrustarlo en el documento final.
- Numerar y titular cada figura (`Figura 2.1. Marco conceptual de la investigación`), con fuente si aplica.

## Documento final (Word/PDF)

Usar la skill `docx` (o `pdf` si el formato de entrega lo requiere) para:
- Aplicar estilos de encabezado consistentes con el índice automático.
- Numeración de páginas, tablas y figuras.
- Insertar la lista de referencias generada según el estilo de cita del proyecto.

No pegar el documento completo en el chat para "revisarlo de una pasada" — trabajar capítulo por capítulo y consolidar al final (ver `token_efficiency.md`).

## Presentación de defensa

Usar la skill `pptx` para generar la presentación a partir de los capítulos ya aprobados:

- Estructura sugerida: Portada → Problema y objetivos → Marco teórico (síntesis) → Metodología → Resultados (con las mismas figuras/tablas clave del documento) → Discusión y conclusiones → Preguntas.
- Máximo 6-8 líneas por diapositiva; las tablas de resultados se simplifican a lo esencial (no copiar la tabla completa del documento si tiene muchas filas/columnas).
- Reutilizar las figuras ya generadas para el documento (misma paleta y estilo) en vez de crear versiones nuevas — ahorra tiempo y mantiene consistencia visual.
