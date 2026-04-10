# Guía: Cómo Adjuntar Documentos Legales

## Métodos de Carga de Documentos

### Método 1: Arrastrar y Soltar (Recomendado)
**Disponible en:** Claude Code Web, Desktop App, VS Code Extension

1. Ten tu documento legal listo (PDF, Word, TXT, etc.)
2. Arrastra el archivo directamente a la ventana de chat
3. El archivo se cargará automáticamente
4. Luego invoca la skill:
   ```
   /unskill-legal-docs Analiza este documento
   ```

**Formatos soportados:**
- PDF (.pdf)
- Word (.docx, .doc)
- Texto (.txt)
- Markdown (.md)
- HTML (.html)

### Método 2: Copiar y Pegar Contenido
**Disponible en:** Todas las plataformas

1. Abre tu documento legal
2. Copia el contenido completo (Ctrl+A, Ctrl+C)
3. Pega en el chat de Claude Code
4. Invoca la skill:
   ```
   /unskill-legal-docs Analiza el documento que acabas de pegar
   ```

**Ventaja:** Funciona con cualquier formato

### Método 3: Compartir Ruta de Archivo (CLI)
**Disponible en:** Terminal/CLI de Claude Code

```bash
claude /unskill-legal-docs @/ruta/al/documento.pdf
```

Reemplaza `/ruta/al/documento.pdf` con la ruta real del archivo.

### Método 4: Múltiples Documentos
Para analizar varios documentos relacionados:

1. **Opción A:** Carga todos de una vez arrastrando múltiples archivos
2. **Opción B:** Cargalos uno por uno y suma al contexto
3. **Opción C:** Usa referencias:
   ```
   /unskill-legal-docs 
   
   Documento 1: [Contenido del primer contrato]
   
   Documento 2: [Contenido del segundo contrato]
   
   Identifica las inconsistencias entre ambos documentos
   ```

## Preparación de Documentos

### Antes de Cargar

**Para PDF:**
- ✅ Asegúrate que sea OCR (texto seleccionable)
- ✅ Si es una imagen escaneada, considera convertir a OCR primero
- ❌ No cargues PDFs protegidos con contraseña

**Para Word/Docx:**
- ✅ Guarda en formato .docx o .pdf
- ✅ El contenido con formato se preserva mejor
- ✅ Las tablas y estructura se mantienen

**Para Documentos Muy Largos:**
- 📄 Si el documento es > 50 páginas, considera dividirlo en secciones
- 📋 Carga por partes o proporciona índice de secciones
- 🔍 Especifica qué secciones son más críticas

### Información Útil a Incluir

Junto con el documento, proporciona:

```
/unskill-legal-docs

CONTEXTO:
- Tipo: Contrato de [servicios/compraventa/etc]
- Partes: [Empresa A] y [Empresa B]
- Jurisdicción: [País/Estado]
- Fecha: [Fecha de documento]
- Urgencia: [Normal/Alta/Crítica]

ENFOQUE PRINCIPAL:
¿Cuáles son los 5 riesgos principales para [Empresa A]?

[DOCUMENTO ADJUNTO O PEGADO]
```

## Casos de Uso Específicos

### Caso 1: Revisar Contrato de Proveedor
```
/unskill-legal-docs

Necesito revisar este contrato ANTES de firmarlo.
Identifica:
1. Términos de terminación
2. Limitaciones de responsabilidad
3. Cláusulas de no competes o confidencialidad
4. Riesgos principales

[CONTRATO PEGADO]
```

### Caso 2: Análisis de Cumplimiento
```
/unskill-legal-docs

¿Este procedimiento cumple con [REGULACIÓN]?
Necesito un reporte de cumplimiento.

Regulación: [Ley específica o norma]
Documento: [Procedimiento actual]

[DOCUMENTO PEGADO]
```

### Caso 3: Comparación de Documentos
```
/unskill-legal-docs

Compara estos dos contratos:

VERSIÓN 1 (Original):
[CONTRATO 1]

VERSIÓN 2 (Modificada):
[CONTRATO 2]

¿Cuáles son los cambios clave y sus implicaciones?
```

### Caso 4: Análisis de Sentencia
```
/unskill-legal-docs

Analiza esta sentencia y explica su impacto en [contexto].

[SENTENCIA PEGADA]

Contexto de aplicación: [Tu situación específica]
```

## Consejos para Mejor Análisis

### 1. **Completa la Información**
   - Incluye anexos y apéndices
   - No dejes partes del documento sin cargar
   - Menciona versiones anteriores si las hay

### 2. **Sé Específico en tu Pregunta**
   ```
   ❌ Malo: "Analiza este contrato"
   ✅ Bueno: "Identifica cláusulas que limiten mi responsabilidad 
              como cliente y sugiere renegociación"
   ```

### 3. **Proporciona Contexto**
   ```
   ❌ Malo: Solo el documento
   ✅ Bueno: Contexto + documento + pregunta específica
   ```

### 4. **Especifica Jurisdicción**
   - Las leyes varían por país/estado
   - Menciona claramente dónde se aplicará el documento
   - Indica si necesitas análisis de múltiples jurisdicciones

## Limitaciones

⚠️ **Documentos que pueden no procesarse bien:**
- PDFs escaneados sin OCR (imágenes)
- Archivos protegidos con contraseña
- Documentos en idiomas no soportados
- Archivos muy grandes (> 100 MB)

📝 **Qué hacer si tienes problemas:**
1. Convierte PDF a texto si es posible
2. Divide documentos muy largos
3. Copia y pega en lugar de arrastrar si el arrastre no funciona
4. Proporciona texto alternativo del documento

## Privacidad y Seguridad

🔒 **Importante:**
- Los documentos que cargues son procesados por Claude
- No se almacenan permanentemente en tu sistema local
- Revisa política de privacidad de Claude Code
- No cargues información extremadamente sensible sin cifrar
- Para documentos altamente confidenciales, considera:
  - Ofuscación de datos sensibles
  - Cambio de nombres de partes
  - Números redactados (excepto donde sea crítico)

## Ejemplos Prácticos

### Ejemplo 1: Documento Completo
```
/unskill-legal-docs

[ARCHIVO: contrato_servicios.pdf - ARRASTRADO Y SOLTADO]

Por favor:
1. Resume los términos principales
2. Identifica los 3 riesgos principales
3. Sugiere 5 puntos a renegociar

Enfoque: Protección del cliente
```

### Ejemplo 2: Múltiples Documentos
```
/unskill-legal-docs

Tengo dos versiones de un contrato:

VERSION ACTUAL:
[CONTRATO 1]

NUEVA PROPUESTA DEL VENDEDOR:
[CONTRATO 2]

¿Qué cambios desfavorables se han introducido?
Prioriza por impacto (alto/medio/bajo).
```

### Ejemplo 3: Análisis Regulatorio
```
/unskill-legal-docs

Nuestra política actual:
[POLITICA ACTUAL]

Regulación aplicable (GDPR):
Artículo 6 - Consentimiento
Artículo 13 - Información a proporcionar
Artículo 17 - Derecho al olvido

¿Cumplimos? Genera un reporte de cumplimiento
con acciones correctivas si es necesario.
```

## Soporte

Si tienes problemas cargando documentos:
1. Verifica el formato del archivo
2. Intenta con un documento de prueba más pequeño
3. Si el arrastre no funciona, usa copiar/pegar
4. Proporciona más contexto en tu pregunta
