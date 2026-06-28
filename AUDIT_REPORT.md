# AUDITORÍA — rancho-raiz-zira (Fase 1)

Fecha: 26 jun 2026
Repo: oficinabarreal/rancho-raiz-zira (PUBLIC)
Archivos: 792 (sin .git)

## HALLAZGOS CRÍTICOS

### 🔴 SEGURIDAD
1. **CREDENCIALES.md expuesto** — Contiene:
   - Google OAuth Client Secret real
   - Número de proyecto GCP
   - Client ID OAuth
   - Phone IDs de WhatsApp
   - Estado de tokens
   
   → ACCIÓN: Eliminar este archivo del repo público. Mover a .gitignore.

2. **team/chats/** — Contiene archivos .vcf y .txt con datos personales
   de contactos reales (Andrés Chouhy, Pozos Andrés, Tomás Scala, etc.)
   
   → ACCIÓN: Eliminar del repo público.

### 🟡 ESTRUCTURA
3. **Mezcla de responsabilidades** — El repo contiene:
   - CRM core (crm/)
   - Generación de contenido (pipeline/, assets/)
   - Analytics (analytics/)
   - Simulaciones (simulators/)
   - Asistente IA (asistente/)
   - Admin panel (admin/)
   - Mensajería (mensajeria/)
   
   → Para el curso: separar en módulos claros

4. **792 archivos** — Muchos son assets (imágenes, reels, frames)
   que no necesitan ir en el repo del curso.

### 🟢 BIEN
5. **config.example.json** — Usa variables de entorno, no datos reales
6. **.gitignore** — Excluye .env, credentials.json, crm_state/
7. **README.md** — Profesional y claro
8. **GitHub Actions** — 7 workflows funcionando

## ARCHIVOS CLAVE PARA EL CURSO

### Code reutilizable (genérico)
- crm/config.example.json → Plantilla de configuración
- crm/connectors.py → Conectores Google/Meta (35KB, completo)
- crm/orchestrator.py → Orquestador principal
- crm/models.py → Modelos de datos
- crm/google_auth.py → Autenticación Google
- crm/store.py → Almacenamiento local

### Documentación
- README.md → Estructura del proyecto
- crm/AGENT.md → Instrucciones para el agente
- ROADMAP.md → Hoja de ruta

## PLAN DE LIMPIEZA

1. Eliminar CREDENCIALES.md (reemplazar con .env.example)
2. Eliminar team/chats/ (datos personales)
3. Copiar código CRM genérico a curso-crm/core-crm/
4. Documentar estructura para el curso
5. Crear .env.example completo basado en config.example.json
