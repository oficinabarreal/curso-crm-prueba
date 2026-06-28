#!/data/data/com.termux/files/usr/bin/bash

# ╔══════════════════════════════════════════════════╗
# ║  CRM IA HOTELERO — INSTALACIÓN AUTOMATIZADA     ║
# ║  Un solo comando para tener todo funcionando     ║
# ╚══════════════════════════════════════════════════╝

set -e

# Colores
R='\033[0;31m'  # Rojo
G='\033[0;32m'  # Verde
Y='\033[1;33m'  # Amarillo
B='\033[0;34m'  # Azul
C='\033[0;36m'  # Cian
M='\033[0;35m'  # Magenta
W='\033[1;37m'  # Blanco
NC='\033[0m'    # Sin color

# Directorio del proyecto (donde está install.sh)
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
HERMES_HOME="$HOME/.hermes"
ZIRA_HOME="$PROJECT_DIR"

# Banner
echo ""
echo -e "${C}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${C}║${W}  🏔️  CRM IA HOTELERO — Instalador Automático   ${C}║${NC}"
echo -e "${C}║${Y}  Tu posada se administra sola desde un celular  ${C}║${NC}"
echo -e "${C}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${W}Este script instala todo lo que necesitás:${NC}"
echo -e "  ${G}✓${NC} Termux (si no lo tenés)"
echo -e "  ${G}✓${NC} Python + dependencias"
echo -e "  ${G}✓${NC} Node.js + npm"
echo -e "  ${G}✓${NC} Hermes Agent (asistente IA)"
echo -e "  ${G}✓${NC} Zira CRM Bot (personalidad pre-configurada)"
echo -e "  ${G}✓${NC} Código del CRM"
echo -e "  ${G}✓${NC} Motor de contenido Instagram"
echo -e "  ${G}✓${NC} Revista digital local"
echo ""
echo -e "${Y}⏱  Tiempo estimado: 5-10 minutos${NC}"
echo -e "${Y}📱 Necesitás: conexión a internet${NC}"
echo ""

# ─── PASO 1: Permisos de almacenamiento ───
echo -e "${B}━━━ Paso 1/7: Permisos de almacenamiento ━━━${NC}"
if [ ! -d "$HOME/storage" ]; then
    echo -e "${Y}→ Solicitando acceso al almacenamiento...${NC}"
    termux-setup-storage 2>/dev/null || true
    echo -e "${G}✓ Permisos configurados${NC}"
else
    echo -e "${G}✓ Almacenamiento ya configurado${NC}"
fi
echo ""

# ─── PASO 2: Actualizar Termux ───
echo -e "${B}━━━ Paso 2/7: Actualizando Termux ━━━${NC}"
pkg update -y 2>/dev/null | tail -1
pkg upgrade -y 2>/dev/null | tail -1
echo -e "${G}✓ Termux actualizado${NC}"
echo ""

# ─── PASO 3: Instalar dependencias del sistema ───
echo -e "${B}━━━ Paso 3/7: Instalando dependencias del sistema ━━━${NC}"
DEPS="python nodejs git openssh curl wget build-essential libffi libssl"
for dep in $DEPS; do
    if pkg list-installed 2>/dev/null | grep -q "^${dep} "; then
        echo -e "  ${G}✓${NC} $dep ya instalado"
    else
        echo -e "  ${Y}→${NC} Instalando $dep..."
        pkg install -y "$dep" 2>/dev/null | tail -1
    fi
done
echo -e "${G}✓ Dependencias del sistema instaladas${NC}"
echo ""

# ─── PASO 4: Instalar dependencias Python ───
echo -e "${B}━━━ Paso 4/7: Instalando librerías Python ━━━${NC}"
pip install --upgrade pip 2>/dev/null | tail -1
PYDEPS="numpy scipy requests beautifulsoup4 google-api-python-client google-auth-httplib2 google-auth-oauthlib python-telegram-bot flask schedule"
for dep in $PYDEPS; do
    echo -e "  ${Y}→${NC} pip install $dep..."
    pip install "$dep" 2>/dev/null | tail -1
done
echo -e "${G}✓ Librerías Python instaladas${NC}"
echo ""

# ─── PASO 5: Instalar Hermes Agent ───
echo -e "${B}━━━ Paso 5/7: Instalando Hermes Agent (asistente IA) ━━━${NC}"
if command -v hermes &> /dev/null; then
    echo -e "  ${G}✓${NC} Hermes ya instalado ($(hermes --version 2>/dev/null))"
else
    echo -e "  ${Y}→${NC} Instalando Hermes Agent..."
    npm install -g hermes-agent 2>/dev/null | tail -3
    echo -e "  ${G}✓${NC} Hermes Agent instalado"
fi
echo ""

# ─── PASO 6: Configurar Zira CRM Bot ───
echo -e "${B}━━━ Paso 6/7: Configurando Zira CRM Bot ━━━${NC}"

# Crear directorio de Hermes si no existe
mkdir -p "$HERMES_HOME"

# 1. Crear SOUL.md de Zira
echo -e "  ${Y}→${NC} Creando personalidad de Zira..."
cat > "$HERMES_HOME/SOUL.md" << 'ZIRA_SOUL'
# SOUL.md — Zira, Asistente Virtual de Rancho Raíz

Sos **Zira**, la asistente virtual del CRM IA Hotelero. Tu misión es ayudar al
usuario a configurar y usar su sistema de gestión hotelera.

## Tu personalidad
- Sos amable, directa y paciente
- Explicás las cosas como si le hablaras a alguien que nunca usó una terminal
- Usás lenguaje cotidiano, sin jerga técnica
- Si no sabés algo, lo decís honestamente
- Celebrás los logros del usuario ("¡Perfecto, ya quedó!")

## Tu rol
1. **Guiar** al usuario en la instalación y configuración
2. **Explicar** cada paso sin asumir conocimientos previos
3. **Resolver** dudas sobre el CRM
4. **Sugerir** mejoras y siguientes pasos

## Reglas
- NUNCA uses comandos sin explicar qué hacen
- Si el usuario se confunde, repetí el paso de otra forma
- Si algo falla, sugerí la solución más probable
- Mantené las respuestas cortas y accionables
- Al final de cada interacción, preguntá si necesita algo más

## Contexto del proyecto
- El usuario compró el CRM IA Hotelero
- Está en su primer día de configuración
- Necesita configurar APIs (Google, WhatsApp, Instagram)
- Todo debe sentirse fácil y seguro
ZIRA_SOUL

# 2. Crear AGENTS.md de Zira
echo -e "  ${Y}→${NC} Creando instrucciones de Zira..."
cat > "$HERMES_HOME/project_context.md" << 'ZIRA_CONTEXT'
# PROJECT_CONTEXT.md — CRM IA Hotelero

## Estado del proyecto
El usuario tiene el CRM IA Hotelero instalado. Está en fase de configuración.

## Archivos del proyecto
- `index.html` — Curso interactivo (abrir en navegador)
- `install.sh` — Este instalador
- `.env.example` — Plantilla de credenciales
- `core-crm/` — Código del CRM
- `docs/` — Guías detalladas

## Próximos pasos para el usuario
1. Configurar Google Cloud (guía en docs/google-cloud-guia.md)
2. Configurar Meta Developers (guía en docs/meta-developers-guia.md)
3. Crear plantilla de WhatsApp
4. Configurar Webhook

## Notas importantes
- El usuario NO sabe programar — explicar todo en lenguaje simple
- Usar analogías cotidianas para conceptos técnicos
- Si el usuario pregunta por algo del curso, referenciar el módulo correspondiente
ZIRA_CONTEXT

# 3. Crear memoria inicial de Zira
echo -e "  ${Y}→${NC} Creando memoria inicial..."
mkdir -p "$HERMES_HOME/memories"
cat > "$HERMES_HOME/memories/zira-crm.md" << 'ZIRA_MEM'
# Memoria de Zira — CRM IA Hotelero

## Sobre el usuario
- Compró el CRM IA Hotelero
- Probablemente no tiene experiencia técnica
- Necesita paciencia y explicaciones claras

## Sobre el proyecto
- CRM para posadas/hoteles pequeños
- Corre en Android con Termux
- Usa Google Sheets como base de datos
- Se conecta por WhatsApp e Instagram
- Incluye motor de contenido y revista digital

## Configuración pendiente
- [ ] Google Cloud (Sheets + Calendar)
- [ ] Meta Developers (WhatsApp + Instagram)
- [ ] Webhook (túnel localhost)
- [ ] GitHub (respaldo)
ZIRA_MEM

echo -e "  ${G}✓${NC} Zira CRM Bot configurado"
echo ""

# ─── PASO 7: Configurar el proyecto ───
echo -e "${B}━━━ Paso 7/7: Configurando el proyecto ━━━${NC}"

# Copiar .env.example como .env si no existe
if [ ! -f "$PROJECT_DIR/.env" ]; then
    cp "$PROJECT_DIR/.env.example" "$PROJECT_DIR/.env"
    echo -e "  ${G}✓${NC} Archivo .env creado (copiado de .env.example)"
fi

# Crear estructura de carpetas
mkdir -p "$PROJECT_DIR/core-crm"
mkdir -p "$PROJECT_DIR/zira-bot"
mkdir -p "$PROJECT_DIR/revista-digital"
mkdir -p "$PROJECT_DIR/docs"
echo -e "  ${G}✓${NC} Estructura de carpetas creada"

# ─── INSTALACIÓN COMPLETADA ───
echo ""
echo -e "${C}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${C}║${W}  🎉 ¡INSTALACIÓN COMPLETADA!                   ${C}║${NC}"
echo -e "${C}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${W}Zira ya está lista para ayudarte.${NC}"
echo ""
echo -e "${Y}Para iniciar Zira, escribí:${NC}"
echo -e "  ${G}hermes${NC}"
echo ""
echo -e "${Y}Ella te guiará en la configuración de:${NC}"
echo -e "  ${C}1.${NC} Google Cloud (base de datos)"
echo -e "  ${C}2.${NC} WhatsApp Business (mensajes)"
echo -e "  ${C}3.${NC} Instagram (captación de clientes)"
echo -e "  ${C}4.${NC} GitHub (respaldo automático)"
echo ""
echo -e "${M}💡 Tip: Si te perdés en algún paso, escribile a Zira:${NC}"
echo -e "  ${G}hermes${NC}  →  ${W}\"Zira, ¿qué hago ahora?\"${NC}"
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${W}📧  Dudas? Escribinos: soporte@oficinabarreal.com${NC}"
echo -e "${W}🌐  Documentación: Abrí index.html en tu navegador${NC}"
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
