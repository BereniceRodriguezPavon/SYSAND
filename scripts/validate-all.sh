#!/bin/bash
# Script para validar todos los archivos SysML del proyecto

echo "🔍 Validando archivos SysML en my_project..."
echo ""

# Contador de archivos
total=0
success=0
failed=0

# Buscar todos los archivos .sysml
while IFS= read -r -d '' file; do
    total=$((total + 1))
    echo "Validando: $file"

    if syside check "$file" 2>&1 >/dev/null; then
        echo "✅ $file - OK"
        success=$((success + 1))
    else
        echo "❌ $file - ERROR"
        failed=$((failed + 1))
    fi
    echo ""
done < <(find models src -name "*.sysml" -type f -print0 2>/dev/null)

# Resumen
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Resumen de validación:"
echo "   Total:   $total archivos"
echo "   Éxito:   $success archivos"
echo "   Fallos:  $failed archivos"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Exit code basado en resultados
if [ $failed -gt 0 ]; then
    exit 1
else
    exit 0
fi
