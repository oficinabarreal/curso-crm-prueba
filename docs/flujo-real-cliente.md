# FLUJO REAL DEL CLIENTE — Sin simplificar

## El problema que resolvemos
El cliente compra un .zip. No sabe qué es Termux. No sabe qué es una terminal.
No tiene cuenta de GitHub. No tiene proyecto en Google Cloud. No tiene App en Meta.
Necesita que CADA paso esté explicado.

## Flujo real paso a paso

### FASE 0: El cliente recibe el email
- Abre el email en su celular (Gmail, Outlook, etc.)
- Clickea "Descargar curso"
- Se descarga un .zip
- Android le pregunta dónde guardarlo
- Elige "Descargas" (o donde sea)
- Va a la app "Archivos" de su celular
- Busca el .zip en Descargas
- Toca el .zip → "Extraer" o "Descomprimir"
- Se crea una carpeta curso-crm/

### FASE 1: El cliente abre la carpeta
- Ve varios archivos y carpetas
- NO SABE qué hacer
- NECESITA un archivo que le diga "EMPEZÁ ACÁ"
- Ese archivo debe ser HTML (se abre con el navegador del celular)
- El HTML le muestra: "Descargá Termux desde F-Droid"

### FASE 2: Instalar F-Droid y Termux
- El cliente nunca oyó hablar de F-Droid
- Debe ir a f-droid.org en su navegador
- Descargar el APK de F-Droid
- Instalarlo (Android pregunta "¿Instalar app de origen desconocido?")
- Abrir F-Droid
- Buscar "Termux"
- Instalar Termux
- Abrir Termux

### FASE 3: Primeros comandos en Termux
- El cliente ve una pantalla negra con texto
- Nunca usó una terminal
- Debe escribir comandos uno por uno
- Cada comando debe estar explicado en el HTML

### FASE 4: Instalar el CRM
- ./install.sh
- El script instala dependencias
- LUEGO instala Hermes
- LUEGO necesita configurar el provider de IA
- AQUÍ está el problema: Hermes necesita una API key para funcionar

### FASE 5: Configurar el provider de IA
- El cliente necesita una API key de algún proveedor
- Opciones gratuitas:
  - NVIDIA (nvapi-...) → free tier
  - Google AI Studio (Gemini) → free tier
  - OpenRouter → free tier
- El cliente necesita crear cuenta en el proveedor
- Necesita generar un token
- Necesita copiarlo y pegarlo en la configuración

### FASE 6: Hermes despierta con personalidad de Zira
- Una vez configurado el provider, Hermes puede funcionar
- Zira se despierta y saluda
- Puede guiar al cliente en el resto

## BARRERAS CRÍTICAS
1. Descomprimir el .zip (fácil pero no explicado)
2. Instalar F-Droid (origen desconocido)
3. Escribir comandos en terminal (nunca lo hizo)
4. Crear cuenta en proveedor de IA (tiene que salir de la app)
5. Copiar/pegar API key en la terminal (error prone)

## SOLUCIÓN PROPUESTA
1. 1_PASOS_AQUI.html → Guía visual paso a paso
2. install.sh interactivo → Pregunta todo, no asume nada
3. Wizard de API key → El script crea la cuenta y obtiene el token
4. Zira aparece → Guía el resto
