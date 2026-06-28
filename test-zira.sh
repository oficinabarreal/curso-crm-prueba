#!/data/data/com.termux/files/usr/bin/bash

# ╔══════════════════════════════════════════════════╗
# ║  PRUEBA ZIRA — Perfil aislado (sin riesgo)      ║
# ╚══════════════════════════════════════════════════╝

R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'
C='\033[0;36m'; M='\033[0;35m'; W='\033[1;37m'; NC='\033[0m'

echo ""
echo -e "${C}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${C}║${W}  🧪 Prueba de Zira — Perfil Aislado             ${C}║${NC}"
echo -e "${C}║${Y}  NO toca tu configuración de big-pickle         ${C}║${NC}"
echo -e "${C}╚══════════════════════════════════════════════════╝${NC}"
echo ""

PROFILE_DIR="$HOME/.hermes/profiles/zira-test"

# Verificar que el perfil existe
if [ ! -d "$PROFILE_DIR" ]; then
    echo -e "${Y}→ Creando perfil zira-test...${NC}"
    hermes profile create zira-test --description "Prueba de Zira CRM" 2>&1
fi

# Verificar que Zira tiene su personalidad
if [ ! -f "$PROFILE_DIR/SOUL.md" ]; then
    echo -e "${Y}→ Configurando personalidad de Zira...${NC}"
    mkdir -p "$PROFILE_DIR/memories"
    
    cat > "$PROFILE_DIR/SOUL.md" << 'ZIRA'
# SOUL.md — Zira, Asistente Virtual del CRM IA Hotelero

Sos **Zira**, la asistente virtual del CRM IA Hotelero.

## Tu personalidad
- Sos amable, directa y paciente
- Explicás las cosas como si le hablaras a alguien que nunca usó una terminal
- Usás lenguaje cotidiano, sin jerga técnica
- Celebrás los logros del usuario

## Tu rol
1. Guiar al usuario en la configuración
2. Explicar cada paso sin asumir conocimientos previos
3. Resolver dudas sobre el CRM
4. Después de configurar, recomendar abrir index.html

## Flujo
Cuando el usuario pregunte qué hacer:
1. Preguntá en qué paso está
2. Guialo en ese paso específico
3. Cuando termine la configuración, decile:
   "¡Listo! Para aprender, abrí index.html en tu navegador"
ZIRA

    cat > "$PROFILE_DIR/project_context.md" << 'CTX'
# PROJECT_CONTEXT.md — CRM IA Hotelero

## Estado
El usuario tiene el CRM instalado. Está en fase de configuración.

## Archivos
- 1_PASOS_AQUI.html — Guía inicial
- install.sh — Instalador
- index.html — Curso completo (6 módulos)

## Próximos pasos
1. Google Cloud (base de datos)
2. WhatsApp (con QR o API)
3. Instagram
4. GitHub
CTX

    cat > "$PROFILE_DIR/memories/zira-crm.md" << 'MEM'
# Memoria de Zira

## Pendiente
- [ ] Google Cloud
- [ ] WhatsApp
- [ ] Instagram
- [ ] GitHub
MEM

    echo -e "${G}✓ Zira configurada${NC}"
fi

# Copiar providers del config principal al perfil
if [ ! -f "$PROFILE_DIR/.providers_copied" ]; then
    echo -e "${Y}→ Copiando configuración de proveedores...${NC}"
    python3 -c "
import yaml, os
home = os.path.expanduser('~')
with open(f'{home}/.hermes/config.yaml') as f:
    main_config = yaml.safe_load(f)
with open(f'{home}/.hermes/profiles/zira-test/config.yaml') as f:
    profile_config = yaml.safe_load(f)
if 'providers' in main_config:
    profile_config['providers'] = main_config['providers']
with open(f'{home}/.hermes/profiles/zira-test/config.yaml', 'w') as f:
    yaml.dump(profile_config, f, default_flow_style=False, allow_unicode=True)
print('OK')
"
    touch "$PROFILE_DIR/.providers_copied"
    echo -e "${G}✓ Proveedores copiados${NC}"
fi

echo -e "${W}Iniciando Zira en perfil aislado...${NC}"
echo -e "${Y}Escribí /exit para salir${NC}"
echo ""

# Ejecutar Zira en el perfil aislado
hermes --profile zira-test chat
