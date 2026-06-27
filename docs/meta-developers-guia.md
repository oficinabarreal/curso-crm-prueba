# Guía Paso a Paso: Meta Developers (WhatsApp + Instagram)

## Para qué sirve

Meta Developers es donde configurás los canales de comunicación:
- **WhatsApp Business API** → Recebir y enviar mensajes de WhatsApp
- **Instagram Graph API** → Responder comentarios y enviar DMs

## Por qué es frustrante

Meta tiene muchas capas de verificación y burocracia. Esta guía te dice exactamente qué hacer y qué NO hacer para no perder horas.

---

## PARTE A: WHATSAPP BUSINESS API

### PASO 1: Crear una App en Meta Developers

1. Entrá a **developers.facebook.com** con tu cuenta de Facebook
2. Hacé clic en **"Mis apps"** (arriba a la derecha)
3. Hacé clic en **"Crear app"**
4. Seleccioná tipo **"Negocio"**
5. Dale un nombre (ej: "CRM Hotelero WhatsApp")
6. Hacé clic en **"Crear app"**

### PASO 2: Agregar WhatsApp al proyecto

1. En el panel de tu app, andá a **"Agregar productos"**
2. Buscá **"WhatsApp"** y hacé clic en **"Configurar"**
3. Te pedirá seleccionar una **Cuenta de Negocios de Meta** (Business Manager)
   - Si no tenés una, creala en **business.facebook.com**
   - Es gratis y necesitás nombre, dirección y teléfono del negocio

### PASO 3: Obtener el Token

1. En el panel de WhatsApp, andá a **"Configuración de la API"**
2. Verás dos cosas importantes:
   - **ID del teléfono:** Anotalo (ej: `1234567890`)
   - **Token de acceso temporal:** Copialo (expira en 24hs)

**Para producción (token permanente):**

1. Andá a **Business Manager** → **Configuración** → **Usuarios del sistema**
2. Creá un usuario del sistema
3. Asignale el rol **"Administrar WhatsApp"**
4. Generá un **token de usuario del sistema** con permisos:
   - `whatsapp_business_messaging`
   - `whatsapp_business_management`
5. Este token no expira (pero podés revocarlo si se compromete)

Pegá el token en tu `.env` como `WHATSAPP_TOKEN`.

### PASO 4: Verificar el Número de Teléfono

**Este paso es OBLIGATORIO.** Sin verificación, no podés enviar mensajes.

1. En el panel de WhatsApp, andá a **"Configuración de la API"** → **"Números de teléfono"**
2. Hacé clic en **"Agregar número de teléfono"**
3. Ingresá tu número con código de país (ej: `+54 9 264 501-7161`)
4. Elegí recibir el código por **SMS** o **llamada**
5. Ingresá el código de 6 dígitos

**Estado esperado:** "Conectado" ✅

**⚠️ Error común:**
Si ves "NOT_VERIFIED" en la API pero "Conectado" en el panel de Meta:
- El número está registrado en la app de WhatsApp Business
- Pero la API de Cloud necesita verificación separada
- Solución: Verificá el número desde el panel de Meta Developers, NO desde el Business Suite

### PASO 5: Crear Plantillas de Mensaje

Para enviar mensajes **proactivos** (fuera de la ventana de 24h), necesitás una plantilla aprobada por Meta.

**¿Qué es una plantilla?**
Un mensaje pre-aprobado que Meta revisa antes de que puedas usarlo. Lo usás para:
- Bienvenida a nuevos huéspedes
- Recordatorios de reserva
- Promociones

**Cómo crear una plantilla:**

1. En el panel de WhatsApp, andá a **"Plantillas de mensaje"**
2. Hacé clic en **"Crear plantilla"**
3. Completá:
   - **Nombre:** (ej: `zira_bienvenida`) — solo minúsculas, guiones bajos
   - **Idioma:** Spanish (Argentina)
   - **Categoría:** UTILIDAD o MARKETING

4. Escribí el cuerpo del mensaje con variables:
   ```
   Hola {{1}}! Soy Zira, la asistente virtual de Rancho Raíz. ¿En qué puedo ayudarte hoy?
   ```

5. **⚠️ PASO CRÍTICO — El que todos olvidan:**
   En "Muestras de variables", agregá un **ejemplo** para cada variable:
   - Para `{{1}}` → escribí "Diego" (o cualquier nombre de ejemplo)
   - **SIN ESTO, META RECHAZA LA PLANTILLA**

6. Hacé clic en **"Enviar a revisión"**

**Tiempo de revisión:** De minutos a horas. Puedes ver el estado en el panel.

**Errores comunes de rechazo:**

| Rechazo | Causa | Solución |
|---------|-------|----------|
| "Variables sin texto de muestra" | No pusiste ejemplo | Agregá ejemplo en "Muestras de variables" |
| "Contenido que infringe políticas" | Texto promocional agresivo | Suavizá el tono, evitá spam |
| "Categoría incorrecta" | Usaste MARKETING para algo de UTILIDAD | Cambiá la categoría |

### PASO 6: Configurar el Webhook

El Webhook es la dirección donde Meta envía los mensajes que recibís.

**¿Qué es un Webhook?**
Imaginá que tu celular es una casa. El Webhook es la dirección que le das a Meta para que sepa dónde dejar los mensajes.

**Para desarrollo local (desde tu celular):**

Necesitás un "túnel" que exponga tu servidor local a internet:

```bash
# Opción 1: localhost.run (gratis, sin cuenta)
ssh -R 80:localhost:3000 nokey@localhost.run

# Opción 2: ngrok (requiere cuenta gratis)
ngrok http 3000
```

**Configuración en Meta:**

1. Andá a **WhatsApp** → **Configuración de la API** → **Webhooks**
2. Hacé clic en **"Editar"** o **"Configurar"**
3. Pegá la URL del túnel + `/webhook`:
   ```
   https://abc123xy.loca.lt/webhook
   ```
4. Ingresá tu **token de verificación** (el que pusiste en `.env` como `WHATSAPP_VERIFY_TOKEN`)
5. Hacé clic en **"Verificar y guardar"**
6. Suscribite a los eventos: **"messages"** y **"messaging_postbacks"**

**Prueba:**
Enviá un mensaje al número de WhatsApp del CRM. Deberías ver la notificación en la terminal donde corre el servidor.

---

## PARTE B: INSTAGRAM GRAPH API

### PASO 7: Vincular Instagram a Facebook

**Requisito previo:** Tu cuenta de Instagram debe ser **Profesional** (Business o Creator).

1. Abrí Instagram en tu celular
2. Andá a **Configuración** → **Cuenta**
3. Hacé clic en **"Cambiar a cuenta profesional"**
4. Elegí **"Negocio"** o **"Creador"**
5. Vinculá tu cuenta a una **Página de Facebook** existente

### PASO 8: Habilitar Instagram Graph API

1. En Meta Developers, en tu app, andá a **"Agregar productos"**
2. Buscá **"Instagram Graph API"** y habilitala
3. Andá a la configuración de la API
4. Generá un token de acceso con permisos:
   - `instagram_basic`
   - `instagram_manage_messages`
   - `pages_messaging`
   - `pages_show_list`

5. Pegalo en `.env` como `INSTAGRAM_ACCESS_TOKEN`

### PASO 9: Configurar Webhooks de Instagram

1. En Meta Developers, andá a **"Webhooks"**
2. Seleccioná **"Instagram"** como objeto
3. Pegá la misma URL del túnel + `/webhook`
4. Usá el mismo token de verificación
5. Suscribite a: **"comments"**, **"messages"**

---

## VERIFICACIÓN FINAL

Una vez configurado todo, el agente ejecuta una prueba:

```
✅ WhatsApp: Conexión exitosa
✅ WhatsApp: Plantilla "zira_bienvenida" APPROVED
✅ Instagram: Conexión exitosa
✅ Webhook: Mensaje de prueba recibido
```

Si todo funciona, tu CRM está listo para recibir clientes.

---

## TROUBLESHOOTING RÁPIDO

### "El token no funciona"
- ¿Expiró? (tokens temporales duran 24hs)
- ¿Tenés los permisos correctos?
- ¿La app está en modo "Live" (no "Development")?

### "No puedo enviar mensajes"
- ¿El número está verificado?
- ¿Tenés una plantilla aprobada?
- ¿El destinatario te escribió primero? (ventana de 24h)

### "El Webhook no recibe mensajes"
- ¿El túnel está corriendo?
- ¿La URL está correcta (con /webhook al final)?
- ¿El token de verificación coincide con el del .env?

### "Meta rechazó mi plantilla"
- ¿Pusiste ejemplos para todas las variables?
- ¿El texto no viola políticas de spam?
- ¿La categoría es la correcta?

---

## MAPA VISUAL

```
Meta Developers
    │
    ├── Crear App
    │       └── Tipo: Negocio
    │
    ├── WhatsApp Business API
    │       ├── Obtener Token
    │       │     ├── Temporal (24hs) — para pruebas
    │       │     └── Permanente — para producción
    │       │
    │       ├── Verificar Número
    │       │     └── SMS o Llamada
    │       │
    │       ├── Crear Plantillas
    │       │     ├── Nombre: zira_bienvenida
    │       │     ├── Texto con {{1}}
    │       │     └── ⚠️ Agregar ejemplo para cada variable
    │       │
    │       └── Configurar Webhook
    │             ├── URL del túnel + /webhook
    │             └── Token de verificación
    │
    └── Instagram Graph API
            ├── Vincular a Página de Facebook
            ├── Generar Token
            └── Configurar Webhooks
```

---

*Guía del Curso CRM IA Hotelero — oficinabarreal*
