# Guía Paso a Paso: Google Cloud Console

## Para qué sirve

Google Cloud es donde creás la "base de datos" del CRM. Usamos:
- **Google Sheets** → Base de datos de reservas, huéspedes, facturas
- **Google Calendar** → Agenda de check-ins, check-outs, turnos de limpieza

## Por qué es frustrante

Google Cloud tiene una interfaz compleja con muchos menús. Esta guía te dice exactamente qué hacer, paso a paso, sin vueltas.

---

## PASO 1: Crear un Proyecto

1. Abrí tu navegador y entrá a **console.cloud.google.com**
2. Iniciá sesión con tu cuenta de Google (la que usás para Gmail)
3. Arriba a la izquierda, hacé clic en el selector de proyecto (dice "Seleccionar proyecto" o muestra el nombre del último proyecto)
4. Hacé clic en **"Nuevo proyecto"**
5. Ponle un nombre (ej: "CRM Hotelero")
6. Hacé clic en **"Crear"**
7. Esperá a que aparezca el proyecto

**¿Dónde veo el número de proyecto?**
En la pantalla principal del proyecto, verás "Número de proyecto: 123456789". Anotalo.

---

## PASO 2: Habilitar las APIs

1. En el menú lateral izquierdo, andá a **"APIs y servicios"** → **"Habilitar APIs y servicios"**
2. En la barra de búsqueda, escribí **"Google Sheets API"**
3. Hacé clic en ella y presioná **"Habilitar"**
4. Volvé a buscar y escribí **"Google Calendar API"**
5. Hacé clic en ella y presioná **"Habilitar"**

**¿Listo?** Ya tenés las APIs activas.

---

## PASO 3: Crear una Cuenta de Servicio

Una Cuenta de Servicio es como un "usuario robot" de Google. Puede leer y escribir en hojas de cálculo sin que tengas que hacer clic en "Permitir" cada vez.

1. En el menú lateral, andá a **"IAM y administración"** → **"Cuentas de servicio"**
2. Hacé clic en **"Crear cuenta de servicio"**
3. Ponle un nombre (ej: "agente-crm")
4. Hacé clic en **"Crear y continuar"**
5. En "Asignar roles", podés dejarlo en blanco (lo configurás después)
6. Hacé clic en **"Continuar"** y luego **"Listo"**

Ahora tenés que crear la "llave" (el archivo credentials.json):

1. Hacé clic en la cuenta de servicio que acabás de crear
2. Andá a la pestaña **"Claves"**
3. Hacé clic en **"Agregar clave"** → **"Crear clave nueva"**
4. Seleccioná **"JSON"** como tipo
5. Hacé clic en **"Crear"**
6. Se descargará un archivo JSON largo con un nombre raro

**Renombrá** ese archivo como `credentials.json` y copialo a la **raíz de tu proyecto** (junto a .env).

---

## PASO 4: Crear la Hoja de Cálculo

1. Andá a **sheets.google.com**
2. Creá una hoja nueva (botón "+" o "Blank spreadsheet")
3. Ponle un nombre (ej: "CRM Hotelero")
4. Copiá el **ID de la hoja** de la URL:
   - La URL se ve así: `https://docs.google.com/spreadsheets/d/ABC123XYZ/edit`
   - El ID es la parte entre `/d/` y `/edit`: `ABC123XYZ`
5. Pegalo en tu `.env` como `GOOGLE_SPREADSHEET_ID=ABC123XYZ`

---

## PASO 5: Compartir la Hoja con la Cuenta de Servicio

Este paso es EL QUE MÁS GENTE OLVIDA. Sin esto, la Cuenta de Servicio no puede acceder a la hoja.

1. Abrí tu hoja de cálculo
2. Hacé clic en el botón **"Compartir"** (arriba a la derecha, icono de persona)
3. En el campo "Añadir personas y grupos", pegá el **correo largo** de la Cuenta de Servicio
   - Se ve así: `agente-crm@tu-proyecto.iam.gserviceaccount.com`
   - Lo encontrás en Google Cloud → IAM → Cuentas de servicio
4. Asignale permisos de **"Editor"**
5. Hacé clic en **"Enviar"**

---

## PASO 6: Verificar que Funciona

El agente ejecuta una prueba automática. Si todo está bien, verás:

```
✅ Conexión exitosa con Google Sheets
```

Si ves un error, revisá:
- ¿El `credentials.json` está en la raíz del proyecto?
- ¿El `GOOGLE_SPREADSHEET_ID` en .env es correcto?
- ¿Compartiste la hoja con la Cuenta de Servicio?
- ¿Las APIs están habilitadas?

---

## Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| "Permission denied" | No compartiste la hoja | Compartila con la Cuenta de Servicio |
| "API not enabled" | No habilitaste la API | Andá a APIs y servicios y habilitala |
| "Invalid credentials" | credentials.json mal | Verificá que esté en la raíz y sea el correcto |
| "Spreadsheet not found" | ID incorrecto | Verificá el ID en la URL de la hoja |

---

## Resumen Visual

```
Google Cloud Console
    │
    ├── Crear Proyecto
    │       └── Anotar Número de Proyecto
    │
    ├── Habilitar APIs
    │       ├── Google Sheets API
    │       └── Google Calendar API
    │
    ├── Crear Cuenta de Servicio
    │       ├── Nombre: "agente-crm"
    │       └── Descargar credentials.json
    │
    └── Google Sheets
            ├── Crear hoja
            ├── Copiar ID
            └── Compartir con Cuenta de Servicio
```

---

*Guía del Curso CRM IA Hotelero — oficinabarreal*
