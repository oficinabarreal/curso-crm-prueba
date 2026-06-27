#!/data/data/com.termux/files/usr/bin/bash

# ╔══════════════════════════════════════════════════╗
# ║  CRM IA HOTELERO — INSTALADOR INTERACTIVO       ║
# ║  Guía al cliente en cada paso                    ║
# ╚══════════════════════════════════════════════════╝

set -e

R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'
B='\033[0;34m'; C='\033[0;36m'; M='\033[0;35m'
W='\033[1;37m'; NC='\033[0m'

# ─── BANNER ───
echo ""
echo -e "${C}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${C}║${W}  🏨 CRM IA HOTELERO — Instalador               ${C}║${NC}"
echo -e "${C}║${Y}  Tu hotel se administra solo desde un celular   ${C}║${NC}"
echo -e "${C}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${W}Vamos a instalar todo paso a paso.${NC}"
echo -e "${W}Si te perdés, escribinos:${NC}"
echo -e "  ${C}WhatsApp: wa.me/5492645017161${NC}"
echo ""

# ─── PASO 1: Mover la carpeta a la raíz de Termux ───
echo -e "${B}━━━ Paso 1/9: Preparando la carpeta ━━━${NC}"
INSTALL_DIR="$HOME/curso-crm"
DOWNLOAD_DIR="$HOME/storage/downloads/curso-crm"

if [ -d "$INSTALL_DIR" ] && [ -f "$INSTALL_DIR/install.sh" ]; then
    echo -e "${G}✓ Carpeta ya está en la ubicación correcta${NC}"
else
    if [ -d "$DOWNLOAD_DIR" ]; then
        echo -e "${Y}→ Moviendo la carpeta a la raíz de Termux...${NC}"
        cp -r "$DOWNLOAD_DIR" "$HOME/"
        echo -e "${G}✓ Carpeta copiada a ~/curso-crm${NC}"
    else
        echo -e "${Y}→ Buscando la carpeta del curso...${NC}"
        FOUND=$(find ~/storage/downloads -maxdepth 2 -name "install.sh" -type f 2>/dev/null | head -1)
        if [ -n "$FOUND" ]; then
            FOUND_DIR=$(dirname "$FOUND")
            cp -r "$FOUND_DIR" "$HOME/"
            echo -e "${G}✓ Carpeta copiada a ~/curso-crm${NC}"
        else
            echo -e "${R}✗ No encontré la carpeta del curso.${NC}"
            echo -e "${R}  Asegurate de haber descomprimido el .zip en Descargas.${NC}"
            exit 1
        fi
    fi
fi

PROJECT_DIR="$HOME/curso-crm"
cd "$PROJECT_DIR"
echo -e "${G}✓ Trabajando en: $(pwd)${NC}"
echo ""

# ─── PASO 2: Permisos ───
echo -e "${B}━━━ Paso 2/9: Permisos de almacenamiento ━━━${NC}"
if [ ! -d "$HOME/storage" ]; then
    echo -e "${Y}→ Dando permisos de almacenamiento...${NC}"
    termux-setup-storage 2>/dev/null || true
    echo -e "${G}✓ Permisos configurados${NC}"
else
    echo -e "${G}✓ Almacenamiento ya configurado${NC}"
fi
echo ""

# ─── PASO 3: Actualizar ───
echo -e "${B}━━━ Paso 3/9: Actualizando Termux ━━━${NC}"
pkg update -y 2>/dev/null | tail -1
pkg upgrade -y 2>/dev/null | tail -1
echo -e "${G}✓ Termux actualizado${NC}"
echo ""

# ─── PASO 4: Dependencias ───
echo -e "${B}━━━ Paso 4/9: Instalando dependencias ━━━${NC}"
DEPS="python nodejs git openssh curl wget build-essential libffi libssl"
for dep in $DEPS; do
    if pkg list-installed 2>/dev/null | grep -q "^${dep} "; then
        echo -e "  ${G}✓${NC} $dep"
    else
        echo -e "  ${Y}→${NC} Instalando $dep..."
        pkg install -y "$dep" 2>/dev/null | tail -1
    fi
done
echo -e "${G}✓ Dependencias instaladas${NC}"
echo ""

# ─── PASO 5: Python ───
echo -e "${B}━━━ Paso 5/9: Instalando librerías Python ━━━${NC}"
pip install --upgrade pip 2>/dev/null | tail -1
for dep in numpy scipy requests beautifulsoup4 google-api-python-client google-auth-httplib2 google-auth-oauthlib flask schedule qrcode pillow; do
    pip install "$dep" 2>/dev/null | tail -1
done
echo -e "${G}✓ Librerías Python instaladas${NC}"
echo ""

# ─── PASO 6: Hermes ───
echo -e "${B}━━━ Paso 6/9: Instalando Hermes Agent ━━━${NC}"
if command -v hermes &> /dev/null; then
    echo -e "  ${G}✓${NC} Hermes ya instalado"
else
    echo -e "  ${Y}→${NC} Instalando Hermes Agent..."
    npm install -g hermes-agent 2>/dev/null | tail -3
    echo -e "  ${G}✓${NC} Hermes instalado"
fi
echo ""

# ─── PASO 7: Configurar proveedor de IA ───
echo -e "${B}━━━ Paso 7/9: Configurar tu asistente IA ━━━${NC}"
echo ""
echo -e "${W}Zira necesita un proveedor de inteligencia artificial.${NC}"
echo -e "${W}Elegí una opción:${NC}"
echo ""
echo -e "  ${C}1${NC}) ${G}OpenCode Zen (RECOMENDADO — gratis, mejor relación calidad/límite)${NC}"
echo -e "  ${C}2${NC}) NVIDIA (gratis)"
echo -e "  ${C}3${NC}) Google AI / Gemini (gratis)"
echo -e "  ${C}4${NC}) OpenRouter (gratis con límites)"
echo -e "  ${C}5${NC}) Ya tengo una API key"
echo -e "  ${C}6${NC}) Configurar después"
echo ""

read -p "Elegí una opción (1-6): " PROVIDER_CHOICE

case $PROVIDER_CHOICE in
    1)
        echo ""
        echo -e "${Y}→ OpenCode Zen — La mejor opción gratuita${NC}"
        echo -e "  Combina un modelo de IA potente con uso generoso."
        echo ""
        echo -e "  1. Abrí tu navegador y entrá a:"
        echo -e "     ${C}https://opencode.ai${NC}"
        echo ""
        echo -e "  2. Creá una cuenta (podés usar Google)"
        echo ""
        echo -e "  3. Andá a Settings → API Keys"
        echo ""
        echo -e "  4. Creá una nueva API Key"
        echo ""
        echo -e "  5. Copiá la clave"
        echo ""
        read -p "  Pegá tu API Key aquí: " API_KEY
        PROVIDER="opencode-zen"
        BASE_URL="https://api.opencode.ai/v1"
        MODEL="mimo-v2.5-free"
        ;;
    2)
        echo ""
        echo -e "${Y}→ NVIDIA${NC}"
        echo -e "  1. Entrá a: ${C}https://build.nvidia.com${NC}"
        echo -e "  2. Creá cuenta (usá Google)"
        echo -e "  3. Andá a: ${C}https://org.ngc.nvidia.com/setup/api-keys${NC}"
        echo -e "  4. Copiá tu API Key (nvapi-...)"
        echo ""
        read -p "  Pegá tu API Key aquí: " API_KEY
        PROVIDER="nvidia"
        BASE_URL="https://integrate.api.nvidia.com/v1"
        MODEL="z-ai/glm-5.1"
        ;;
    3)
        echo ""
        echo -e "${Y}→ Google AI / Gemini${NC}"
        echo -e "  1. Entrá a: ${C}https://aistudio.google.com/apikey${NC}"
        echo -e "  2. Creá cuenta Google"
        echo -e "  3. 'Create API Key'"
        echo -e "  4. Copiá la clave (AIza...)"
        echo ""
        read -p "  Pegá tu API Key aquí: " API_KEY
        PROVIDER="google"
        BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai"
        MODEL="gemini-2.5-flash"
        ;;
    4)
        echo ""
        echo -e "${Y}→ OpenRouter${NC}"
        echo -e "  1. Entrá a: ${C}https://openrouter.ai${NC}"
        echo -e "  2. Creá cuenta"
        echo -e "  3. Keys → Create Key"
        echo -e "  4. Copiá (sk-...)"
        echo ""
        read -p "  Pegá tu API Key aquí: " API_KEY
        PROVIDER="openrouter"
        BASE_URL="https://openrouter.ai/api/v1"
        MODEL="google/gemini-2.5-flash"
        ;;
    5)
        echo ""
        echo -e "  ${C}a${NC}) NVIDIA"
        echo -e "  ${C}b${NC}) Google AI"
        echo -e "  ${C}c${NC}) OpenRouter"
        echo -e "  ${C}d${NC}) Otro"
        echo ""
        read -p "  Proveedor: " SUB
        read -p "  API Key: " API_KEY
        case $SUB in
            a) PROVIDER="nvidia"; BASE_URL="https://integrate.api.nvidia.com/v1"; MODEL="z-ai/glm-5.1" ;;
            b) PROVIDER="google"; BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai"; MODEL="gemini-2.5-flash" ;;
            c) PROVIDER="openrouter"; BASE_URL="https://openrouter.ai/api/v1"; MODEL="google/gemini-2.5-flash" ;;
            d) read -p "  Base URL: " BASE_URL; read -p "  Modelo: " MODEL; PROVIDER="custom"; MODEL=${MODEL:-gpt-4o-mini} ;;
        esac
        ;;
    6)
        echo ""
        echo -e "${Y}→ Configurar después: ${C}hermes setup model${NC}"
        API_KEY=""
        PROVIDER=""
        ;;
esac

# Guardar configuración
HERMES_HOME="$HOME/.hermes"
if [ -n "$API_KEY" ]; then
    mkdir -p "$HERMES_HOME"
    cat > "$HERMES_HOME/config.yaml" << HERMES_CONFIG
model:
  provider: ${PROVIDER}
  api_key: ${API_KEY}
  base_url: ${BASE_URL}
  default: ${MODEL}
HERMES_CONFIG
    echo ""
    echo -e "${G}✓ Proveedor configurado: ${PROVIDER}${NC}"
    echo -e "${G}  Modelo: ${MODEL}${NC}"
else
    echo ""
    echo -e "${Y}⚠️  Sin proveedor — configurá después con: hermes setup model${NC}"
fi
echo ""

# ─── PASO 8: Configurar Zira ───
echo -e "${B}━━━ Paso 8/9: Configurando Zira CRM Bot ━━━${NC}"

cat > "$HERMES_HOME/SOUL.md" << 'ZIRA_SOUL'
# SOUL.md — Zira, Asistente Virtual del CRM IA Hotelero

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
ZIRA_SOUL

cat > "$HERMES_HOME/project_context.md" << 'ZIRA_CONTEXT'
# PROJECT_CONTEXT.md — CRM IA Hotelero

## Estado
El usuario tiene el CRM instalado. Está en fase de configuración.

## Archivos
- `1_PASOS_AQUI.html` — Guía inicial
- `install.sh` — Este instalador
- `core-crm/` — Código del CRM
- `docs/` — Guías detalladas

## Próximos pasos
1. Configurar Google Cloud
2. Configurar WhatsApp (con QR o API)
3. Configurar Instagram
4. Configurar GitHub
ZIRA_CONTEXT

mkdir -p "$HERMES_HOME/memories"
cat > "$HERMES_HOME/memories/zira-crm.md" << 'ZIRA_MEM'
# Memoria de Zira

## Sobre el usuario
- Compró el CRM IA Hotelero
- No tiene experiencia técnica
- Necesita paciencia

## Pendiente
- [ ] Google Cloud
- [ ] WhatsApp
- [ ] Instagram
- [ ] GitHub
ZIRA_MEM

echo -e "  ${G}✓${NC} Zira configurada"
echo ""

# ─── PASO 9: Configurar WhatsApp QR ───
echo -e "${B}━━━ Paso 9/9: Configurando WhatsApp ━━━${NC}"
echo ""
echo -e "${W}¿Cómo querés conectar WhatsApp?${NC}"
echo ""
echo -e "  ${C}1${NC}) ${G}QR Code (RECOMENDADO — más fácil)${NC}"
echo -e "      Escaneás un código QR con tu WhatsApp"
echo -e "      No necesitás开发者 cuenta en Meta"
echo ""
echo -e "  ${C}2${NC}) WhatsApp Business API (avanzado)"
echo -e "      Necesitás cuenta verificada en Meta"
echo -e "      Más profesional, más complex"
echo ""
echo -e "  ${C}3${NC}) Configurar después"
echo ""

read -p "Elegí (1-3): " WA_CHOICE

case $WA_CHOICE in
    1)
        echo ""
        echo -e "${Y}→ WhatsApp por QR — Configuración:${NC}"
        echo ""
        echo -e "  Instalando dependencias..."
        pip install websocket-client 2>/dev/null | tail -1
        
        # Crear script de WhatsApp QR
        cat > "$PROJECT_DIR/zira-bot/whatsapp_qr.py" << 'WA_QR'
#!/usr/bin/env python3
"""
WhatsApp QR Connector para CRM Hotelero
Escaneá el código QR con tu WhatsApp para conectar.
"""
import subprocess
import sys

try:
    from webwhatsapi import WhatsAPIDriver
except ImportError:
    print("Instalando dependencias...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "webwhatsapi", "-q"])
    from webwhatsapi import WhatsAPIDriver

print("🔄 Iniciando WhatsApp QR Connector...")
print("📱 Se mostrará un código QR. Escanealo con tu WhatsApp:")
print("   WhatsApp → ⋮ → Dispositivos vinculados → Vincular dispositivo")
print()

driver = WhatsAPIDriver(client="cli", browser_profile="/tmp/wa_profile")
driver.start()

print("✅ WhatsApp conectado!")
print("   Cerrá esta ventana para desconectar.")
input("   Presioná Enter para salir...")
WA_QR
        chmod +x "$PROJECT_DIR/zira-bot/whatsapp_qr.py"
        echo -e "  ${G}✓${NC} WhatsApp QR configurado"
        echo -e "  ${Y}Para usarlo después: python3 zira-bot/whatsapp_qr.py${NC}"
        ;;
    2)
        echo ""
        echo -e "${Y}→ WhatsApp Business API — Configurar después con Zira${NC}"
        ;;
    3)
        echo ""
        echo -e "${Y}→ Configurar después${NC}"
        ;;
esac
echo ""

# ─── LISTO ───
echo -e "${C}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${C}║${W}  🎉 ¡INSTALACIÓN COMPLETADA!                   ${C}║${NC}"
echo -e "${C}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${W}Tu hotel ahora tiene:${NC}"
echo -e "  ${G}✓${NC} CRM de reservas"
echo -e "  ${G}✓${NC} Zira (asistente IA)"
echo -e "  ${G}✓${NC} WhatsApp configurado"
echo ""
echo -e "${W}Para iniciar a Zira, escribí:${NC}"
echo -e "  ${G}hermes${NC}"
echo ""
echo -e "${W}Ella te guiará en:${NC}"
echo -e "  ${C}1.${NC} Google Cloud (base de datos)"
echo -e "  ${C}2.${NC} Instagram (captación)"
echo -e "  ${C}3.${NC} GitHub (respaldo)"
echo ""
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${W}📧  Dudas? WhatsApp: wa.me/5492645017161${NC}"
echo -e "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
