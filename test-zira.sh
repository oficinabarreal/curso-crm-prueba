#!/data/data/com.termux/files/usr/bin/bash

# ╔══════════════════════════════════════════════════╗
# ║  MODO PRUEBA — Zira CRM (Aislado del sistema)   ║
# ╚══════════════════════════════════════════════════╝

echo ""
echo "🔒 MODO PRUEBA — Perfil aislado: zira-test"
echo "   Tu perfil default NO se tocará"
echo ""
echo "   Para salir: escribí /exit"
echo ""

# Ejecutar Hermes con el perfil zira-test
# Esto usa ~/.hermes/profiles/zira-test/ como directorio
hermes --profile zira-test chat
