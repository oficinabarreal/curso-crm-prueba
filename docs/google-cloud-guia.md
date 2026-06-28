# Guía Google Cloud — CRM IA Hotelero

## Resumen
Google Cloud es la base de datos del CRM. Usa Google Sheets como almacenamiento
y Google Calendar para reservas. Es gratis hasta cierto uso.

## Lo que necesitás
- Una cuenta de Gmail
- Navegador web (Chrome funciona bien)

## Paso 1: Crear proyecto en Google Cloud

1. Entrá a **console.cloud.google.com**
2. Arriba a la izquierda, hacé clic en "Seleccionar proyecto" → "Nuevo proyecto"
3. Dale un nombre (ej: "CRM Hotelero") y crealo
4. Anotá el **Número de proyecto** que aparece en la pantalla

## Paso 2: Habilitar APIs

1. En el menú lateral, andá a **"APIs y servicios" → "Habilitar APIs y servicios"**
2. Buscá y activá:
   - **Google Sheets API** (para la base de datos)
   - **Google Calendar API** (para reservas)

## Paso 3: Crear Cuenta de Servicio

La Cuenta de Servicio es como un "usuario robot" de Google.

1. En el menú lateral, andá a **"IAM y administración" → "Cuentas de servicio"**
2. Hacé clic en "Crear cuenta de servicio"
3. Dale un nombre (ej: "agente-crm") y crealo
4. Hacé clic en la cuenta creada → pestaña **"Claves"** → "Agregar clave" → "Crear clave nueva"
5. Seleccioná **JSON** y descargalo
6. Renombrá el archivo como `credentials.json`
7. Colocalo en la raíz del proyecto (junto a .env)

**⚠️ Seguridad:** credentials.json es como la llave maestra. NUNCA lo subas a GitHub.

## Paso 4: Crear hoja de cálculo

1. Abrí **sheets.google.com**
2. Creá una hoja nueva
3. Nomebrala (ej: "CRM Hotelero")
4. Compartila con la Cuenta de Servicio (el correo largo de la cuenta robot)
5. Asignale permisos de **Editor**

## Paso 5: Configurar .env

Editá el archivo `.env` con estos valores:

```bash
# Google Cloud
GOOGLE_PROJECT_ID=tu_numero_de_proyecto
GOOGLE_CREDENTIALS_FILE=credentials.json
GOOGLE_SPREADSHEET_ID=el_id_de_tu_hoja
```

El ID de la hoja está en la URL:
`https://docs.google.com/spreadsheets/d/ **ESTE_ES_EL_ID** /edit`

## Paso 6: Verificar conexión

Ejecutá este comando para verificar que todo funciona:

```bash
python3 -c "
from crm.google_auth import obtener_cliente
from crm.connectors import SheetsConnector
cliente = obtener_cliente()
sheets = SheetsConnector(cliente)
print('Conexión exitosa con Google Sheets')
"
```

Si ves "Conexión exitosa", todo está funcionando.

## Errores comunes

| Error | Solución |
|-------|----------|
| "Permission denied" | No compartiste la hoja con la Cuenta de Servicio |
| "API not enabled" | No habilitaste la API en Google Cloud Console |
| "Invalid credentials" | El archivo credentials.json está mal o no existe |

## Estructura de la hoja

La hoja debe tener estas pestañas:

### Huéspedes
| Nombre | Email | Teléfono | Check-in | Check-out | Estado | Notas |
|--------|-------|----------|----------|-----------|--------|-------|

### Reservas
| ID | Huésped | Habitación | Entrada | Salida | Precio | Estado |
|----|---------|------------|---------|--------|--------|--------|
