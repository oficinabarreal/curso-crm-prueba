#!/data/data/com.termux/files/usr/bin/bash

# ╔══════════════════════════════════════════════════╗
# ║  RESTAURAR big-pickle desde backup               ║
# ╚══════════════════════════════════════════════════╝

BACKUP_DIR="/data/data/com.termux/files/home/.hermes/backups/big-pickle-20260627_130154"
HERMES_HOME="/data/data/com.termux/files/home/.hermes"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ No se encontró el backup en: $BACKUP_DIR"
    exit 1
fi

echo "🔄 Restaurando big-pickle desde backup..."
echo "   Backup: $BACKUP_DIR"
echo ""

# Restaurar archivos críticos
cp "$BACKUP_DIR/SOUL.md" "$HERMES_HOME/SOUL.md"
cp "$BACKUP_DIR/project_context.md" "$HERMES_HOME/project_context.md"
cp "$BACKUP_DIR/config.yaml" "$HERMES_HOME/config.yaml"

# Restaurar memories
rm -rf "$HERMES_HOME/memories/"*
cp -r "$BACKUP_DIR/memories/"* "$HERMES_HOME/memories/"

# Restaurar skills (solo si hay differencias)
echo "   Skills: verificando..."
# No sobrescribir skills — pueden haber nuevos del sistema

echo ""
echo "✅ big-pickle restaurado"
echo "   SOUL.md: $(wc -c < "$HERMES_HOME/SOUL.md") bytes"
echo "   project_context.md: $(wc -c < "$HERMES_HOME/project_context.md") bytes"
echo "   memories: $(ls "$HERMES_HOME/memories/" | wc -l) archivos"
echo ""
echo "⚠️  Reiniciá Hermes para que los cambios tomen efecto"
