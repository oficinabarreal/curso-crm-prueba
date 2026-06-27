# CRM IA Hotelero — Guía del Cliente

## Tu Journey: De la compra a tu primer huésped

```
COMPRA → DESCARGA → INSTALACIÓN → ZIRA TE GUÍA → ¡LISTO!
  0min    1min      5-10min       30-60min       4h total
```

---

## PASO 1: Descargá tu curso

Después de comprar, recibís un email con un link de descarga.

1. Abrí el email en tu celular
2. Hacé clic en "Descargar curso"
3. Se descarga un archivo `.zip`

**¿No encontrás el email?** Revisá la carpeta de spam o escribinos.

---

## PASO 2: Descomprimí el .zip

1. Abrí la app de "Archivos" o "Gestor de archivos" de tu celular
2. Buscá la carpeta "Descargas"
3. Tocá el archivo `.zip` del curso
4. Seleccioná "Extraer" o "Descomprimir"
5. Aceptá la ubicación (generalmente crea una carpeta nueva)

**¿No sabés descomprimir?** En Android, generalmente tocando el .zip aparece la opción "Extraer". Si no, descargá una app gratis como "RAR" o "ZArchiver" desde Play Store.

---

## PASO 3: Instalá Termux

Termux es una app que convierte tu celular en un servidor. Es gratis y segura.

1. Descargá **F-Droid** desde: https://f-droid.org
2. Abrí F-Droid y buscá "Termux"
3. Instalalo

**⚠️ IMPORTANTE:** Descargalo de F-Droid, NO de Play Store. La versión de Play Store está desactualizada.

---

## PASO 4: Instalá todo con un solo comando

1. Abrí Termux
2. Escribí estos comandos (uno por uno, presionando Enter después de cada uno):

```bash
termux-setup-storage
cd ~/storage/downloads/NOMBRE_DE_LA_CARPETA
chmod +x install.sh
./install.sh
```

Reemplazá `NOMBRE_DE_LA_CARPETA` por el nombre de la carpeta que se creó al descomprimir el .zip.

**El script instala todo automáticamente:**
- Python y librerías necesarias
- Node.js
- Hermes Agent (tu asistente IA)
- Zira CRM Bot (configurada para ayudarte)
- Todo el código del CRM

**⏱️ Tiempo:** 5-10 minutos. No cierres Termux durante la instalación.

---

## PASO 5: Conocé a Zira

Una vez que la instalación termine, escribí:

```bash
hermes
```

Zira se despertará y te dará la bienvenida. Ella es tu asistente virtual y te va a guiar en todo.

**Decile:** "Hola Zira, ¿qué hago ahora?"

Ella te explicará cada paso siguiente.

---

## PASO 6: Seguí la guía de Zira

Zira te va a pedir que configures estas cosas (una por una):

### a) Google Cloud (base de datos)
- Crear un proyecto en Google Cloud
- Habilitar Google Sheets y Calendar
- Crear una "Cuenta de Servicio" (un usuario robot de Google)
- Descargar un archivo de credenciales
- Compartir tu hoja de cálculo con ese usuario

**Zira te explica cada paso con detalle.**

### b) WhatsApp Business
- Crear una App en Meta Developers
- Verificar tu número de teléfono
- Crear una plantilla de mensaje
- Configurar el Webhook (para recibir mensajes)

**Zira te dice exactamente qué hacer en cada pantalla.**

### c) Instagram (opcional)
- Vincular tu Instagram a Facebook
- Configurar la API de Instagram
- Automatizar respuestas a comentarios

### d) GitHub (respaldo)
- Crear una cuenta en GitHub
- Configurar el respaldo automático

---

## PASO 7: ¡Tu CRM está listo!

Después de configurar todo, tu sistema puede:

- ✅ Recibir reservas por WhatsApp automáticamente
- ✅ Actualizar precios desde Google Sheets
- ✅ Publicar en Instagram sin que hagas nada
- ✅ Mantener tu página web actualizada
- ✅ Respaldar todo en GitHub

---

## ¿Necesitás ayuda?

- **Zira:** Escribí `hermes` en Termux y preguntale
- **Email:** soporte@oficinabarreal.com
- **WhatsApp:** [NUMERO_WHATSAPP]

---

## Preguntas frecuentes

**¿Necesito saber programar?**
No. Si sabés usar Google Sheets, ya sabés usar el sistema.

**¿Funciona sin internet?**
El servidor corre en tu celular. Para recibir mensajes necesitás internet, pero la base de datos local funciona sin conexión.

**¿Cuánto consume de batería?**
Muy poco. Menos que WhatsApp.

**¿Puedo usarlo con iPhone?**
No. Termux solo funciona en Android.

**¿Qué pasa si se apaga el celular?**
El respaldo en GitHub te protege. Cuando volvás a encender, todo se restaura.

---

*CRM IA Hotelero — oficinabarreal*
