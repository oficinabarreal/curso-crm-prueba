# Secuencia de Emails — Curso CRM IA Hotelero

## FLUJO GENERAL

```
Compra → Email bienvenida → Onboarding (3 días) → Upsell V2 (día 7)
         → Check-in (día 14) → Testimonial (día 21) → Upsell VIP (día 30)
```

---

## EMAIL 1: BIENVENIDA (se envía al comprar)

**Asunto:** ¡Bienvenido al CRM IA Hotelero! Tu posada va a cambiar

**Cuerpo:**

Hola {{nombre}},

¡Gracias por confiar en nosotros!

Tu compra está confirmada. Acá te dejo todo lo que necesitás para arrancar:

📦 **Descargá tu curso aquí:** [LINK_DESCARGA]

📝 **Cómo empezar:**
1. Descomprimí el .zip
2. Abrí `index.html` en tu navegador
3. Seguí los pasos del Módulo 1 (Termux)

⏱️ **Tiempo estimado:** 4 horas para tener todo funcionando

💡 **Tip importante:** No te saltes los pasos de Google Cloud y Meta Developers. Son la parte más burocrática, pero una vez que los superás, todo el resto es automático.

Si tenés alguna duda, respondé a este email o escribime por WhatsApp: [NUMERO_WHATSAPP]

¡Éxitos!
Diego — oficinabarreal

P.D.: Guardá este email. Ahí tenés el link de descarga por si lo necesitás después.

---

## EMAIL 2: ONBOARDING DÍA 1 (24h después de la compra)

**Asunto:** ¿Ya instalaste Termux? Tu servidor está esperando

**Cuerpo:**

Hola {{nombre}},

¿Cómo va todo? Hoy es el día para dar el primer paso grande: instalar Termux.

📱 **Descargá Termux desde F-Droid** (NO de Play Store):
https://f-droid.org/packages/com.termux/

Una vez instalado, abrilo y ejecutá:

```
termux-setup-storage
chmod +x install.sh
./install.sh
```

El script detecta automáticamente si compraste V1 o V2.

🔑 **Recordá:** Después necesitás crear tu proyecto en Google Cloud. Es la parte más lenta pero más importante.

¿Necesitás ayuda? Respondé este email.

Diego

---

## EMAIL 3: ONBOARDING DÍA 2 (48h después)

**Asunto:** Google Cloud: La parte que nadie quiere hacer (pero es fácil)

**Cuerpo:**

Hola {{nombre}},

Sé que Google Cloud parece un monstruo. Pero es más fácil de lo que parece.

📊 **Resumen rápido:**
1. Crear proyecto en console.cloud.google.com
2. Habilitar Sheets API y Calendar API
3. Crear Cuenta de Servicio
4. Descargar credentials.json
5. Compartir tu hoja con la Cuenta de Servicio

📖 **Guía completa:** Abrí `docs/google-cloud-guia.md` en tu carpeta del curso.

⏱️ **Tiempo:** 20-30 minutos si seguís los pasos al pie de la letra.

⚠️ **El error más común:** Olvidar compartir la hoja con la Cuenta de Servicio. Si ves "Permission denied", es eso.

Diego

---

## EMAIL 4: ONBOARDING DÍA 3 (72h después)

**Asunto:** WhatsApp e Instagram: El laberinto de Meta (que tiene solución)

**Cuerpo:**

Hola {{nombre}},

Llegaste al paso más complejo: configurar Meta Developers.

♾️ **Resumen rápido:**
1. Crear App en developers.facebook.com
2. Agregar WhatsApp Business
3. Verificar tu número (SMS o llamada)
4. Crear plantilla de mensaje
5. Configurar Webhook

📖 **Guía completa:** Abrí `docs/meta-developers-guia.md` en tu carpeta del curso.

⚠️ **El error más común:** Si Meta rechaza tu plantilla, es porque no pusiste ejemplos para las variables. Mirá la guía — está explicado paso a paso.

💡 **Consejo:** Si te trabás en un paso, dejalo para mañana. No es una carrera.

Diego

---

## EMAIL 5: CHECK-IN DÍA 14

**Asunto:** ¿Cómo va tu CRM? Cuéntame cómo te fue

**Cuerpo:**

Hola {{nombre}},

Ya pasaron dos semanas desde tu compra. ¿Cómo te fue?

Me encantaría saber:

1. ¿Lograste instalar todo?
2. ¿Qué parte fue más difícil?
3. ¿Ya está funcionando tu CRM?

Respondé a este email con tu experiencia. Si algo no funcionó, ayudame a mejorarlo.

🎁 **Bonus:** Si tu CRM ya está funcionando, te regalo una sesión de 15 minutos para optimizar tu configuración. Escribime por WhatsApp: [NUMERO_WHATSAPP]

Diego

---

## EMAIL 6: TESTIMONIAL DÍA 21

**Asunto:** Tu opinión nos ayuda (y te da visibilidad)

**Cuerpo:**

Hola {{nombre}},

¿Te animás a dejar un comentario sobre tu experiencia con el curso?

Tu testimonio ayuda a otros posaderos a decidirse. Y si querés, puedo publicarlo en nuestra página con tu nombre y la posada.

📝 **Dejá tu testimonio aquí:** [LINK_FORMULARIO]

O simplemente respondé este email con unas palabras.

Gracias por confiar en nosotros.

Diego

---

## EMAIL 7: UPSELL V2 DÍA 7

**Asunto:** ¿Querés que Zira también cuide tu Instagram?

**Cuerpo:**

Hola {{nombre}},

¿Ya tenés tu CRM funcionando? Genial.

Ahora te cuento algo: con V1 tenés la base. Pero con **V2 — Combo 360°**, tu posada se vuelve autónoma:

🤖 **Zira Bot** → Publica en Instagram automáticamente, captando huéspedes orgánicos
📰 **Revista Digital** → Página web turística que atrae visitas a tu zona

**Precio especial para vos:** $249 USD (ahorrás $168 vs comprar por separado)

[COMPRAR V2 — $249 USD]

Si ya tenés V2, ignorá este email 😊

Diego

---

## EMAIL 8: UPSELL VIP DÍA 30

**Asunto:** ¿Querés que te configure el CRM personalmente?

**Cuerpo:**

Hola {{nombre}},

Ya tenés el conocimiento. Pero si preferís que alguien lo haga por vos, tengo una opción VIP:

👑 **VIP — Consultoría Personalizada ($499 USD)**

Incluye:
- Sesión 1-a-1 de 2 horas
- Configuración completa de tu CRM
- Integración con tu sistema actual
- Soporte prioritario por 6 meses

[COMPRAR VIP — $499 USD]

O si preferís hacerlo vos mismo, seguí con el curso. Estoy acá para ayudarte.

Diego

---

## NOTAS TÉCNICAS

- **Proveedor de email:** Usar SendGrid, Mailgun o Amazon SES
- **Segmentación:** Separar compradores V1 vs V2 para upsells relevantes
- **Variables:** `{{nombre}}`, `{{fecha_compra}}`, `{{version}}`
- **Unsubscribe:** Agregar link de baja en cada email (obligatorio por ley)
- **Tracking:** Medir open rate y click rate para optimizar

---

*Secuencia de Emails — Curso CRM IA Hotelero — oficinabarreal*
