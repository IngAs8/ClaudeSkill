# Mapa de Autoría por Sección

Objetivo: dejar explícito, antes de escribir, qué partes son aporte intelectual del estudiante (deben redactarse por él/ella) y cuáles puede redactar el asistente como apoyo técnico/descriptivo.

## Regla general

Si la sección expresa una **postura, interpretación, juicio de valor o conclusión propia**, la redacta el estudiante. Si la sección es **descriptiva, técnica o de síntesis de lo que otros dijeron/hicieron**, el asistente puede redactar un borrador que el estudiante revisa y ajusta.

## Tabla de clasificación

| Sección | Quién redacta | Razón | Rol del asistente |
|---|---|---|---|
| Planteamiento del problema | Estudiante (con apoyo) | Requiere juicio sobre qué es relevante e importante | Ayudar a estructurar y afinar redacción |
| Justificación | Estudiante | Es un argumento de valor personal/institucional | Sugerir estructura, verificar coherencia |
| Objetivos e hipótesis | Estudiante (con apoyo) | Definen el foco intelectual del trabajo | Revisar que sean medibles/coherentes |
| Marco teórico / Estado del arte | Asistente (borrador) | Síntesis de literatura existente, verificable por cita | Redactar borrador citado; estudiante revisa énfasis |
| Metodología | Mixto | Diseño = decisión del estudiante; redacción técnica = asistente | Redactar la descripción una vez el estudiante define decisiones clave |
| Presentación de resultados (texto descriptivo) | Asistente (borrador) | Describe datos objetivamente | Redactar descripción de tablas/figuras |
| **Discusión / Análisis de resultados** | **Estudiante** | Es la interpretación crítica, el aporte central de la tesis | Solo preguntas guía y corrección, nunca sustituir el argumento |
| **Conclusiones** | **Estudiante** | Síntesis del aporte propio | Revisar coherencia con objetivos, no redactar el contenido de fondo |
| Recomendaciones / trabajo futuro | Estudiante (con apoyo) | Proyección propia sobre el campo | Sugerir categorías, el contenido lo decide el estudiante |
| Resumen/Abstract | Asistente (borrador final) | Síntesis mecánica de lo ya escrito por el estudiante | Redactar a partir del contenido ya aprobado |

## Marcadores de placeholder

Al generar el esqueleto de un capítulo (ver `scripts/outline_generator.py`), insertar comentarios explícitos en las secciones de autoría del estudiante:

```
<!-- REDACCIÓN DEL ESTUDIANTE (Discusión): ¿qué explican estos resultados sobre tu hipótesis?
     ¿en qué se parecen o difieren de los antecedentes del Cap. 2?
     Escribe tu propio análisis aquí; no lo dejes vacío ni lo reemplaces con texto genérico. -->
```

Reglas para el asistente frente a estos marcadores:
- No completarlos con un párrafo "de relleno" que el estudiante pueda simplemente dejar como está.
- Se puede ofrecer 2-3 preguntas guía adicionales si el estudiante está bloqueado, pero no un argumento ya armado.
- Una vez el estudiante escribe su versión, el asistente pasa a modo corrección (ver `review_rubric.md`), no de redacción.
