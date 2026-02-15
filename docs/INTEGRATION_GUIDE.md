# Guía de Integración de Modelos en Sysand

Esta guía explica cómo incluir modelos SysML v2 de lecciones anteriores en tu proyecto Sysand.

## 📋 Proceso de Integración

### 1. Copiar el Modelo

Copia el archivo `.sysml` desde la lección al directorio `models/` o `src/` de tu proyecto:

```bash
# Ejemplo: copiar modelo de Lesson 11
cp /path/to/advent-of-sysml-v2/lesson11/models/L11_Attributes_Quantities.sysml \
   my_project/models/ReindeerModel.sysml
```

### 2. Adaptar el Paquete

**IMPORTANTE**: Renombra el paquete para que sea único en tu proyecto y evitar shadowing:

```sysml
// ❌ ANTES (nombre original de la lección)
package L11_Attributes_Quantities {
    ...
}

// ✅ DESPUÉS (nombre único para tu proyecto)
package MyProjectReindeerModel {
    ...
}
```

**Reglas para nombres de paquetes:**
- ✅ Usa nombres simples sin `::` en la declaración: `package MiPaquete {`
- ❌ No uses `::` en nombres de paquete: `package Mi::Paquete {` (error de sintaxis)
- ✅ Usa prefijos para evitar conflictos: `MyProject`, `MyApp`, etc.
- ✅ Los nombres deben ser únicos en todo el proyecto

### 3. Verificar Imports

Asegúrate de que todos los imports tengan visibilidad explícita:

```sysml
// ✅ CORRECTO
private import ScalarValues::Real;
private import ISQ::length;
private import SI::kg;

// ❌ INCORRECTO (falta visibilidad)
import ScalarValues::Real;
import ISQ::length;
```

### 4. Validar el Modelo

Valida el modelo importado individualmente:

```bash
syside check models/ReindeerModel.sysml
```

### 5. Usar el Modelo en Otros Archivos

Para usar definiciones del modelo importado en otros archivos:

```sysml
// En IntegratedExample.sysml
private import MyProjectReindeerModel::*;

package MyProjectIntegrated {
    // Ahora puedes usar Reindeer, Rudolph, Color, etc.
    part myReindeer : Reindeer {
        ...
    }
}
```

### 6. Validación Conjunta

Cuando tienes múltiples archivos que se referencian entre sí, valídalos juntos:

```bash
# Validar múltiples archivos relacionados
syside check models/ReindeerModel.sysml models/IntegratedExample.sysml

# O usar el script de validación
bash scripts/validate-all.sh
```

## 🎯 Ejemplo Completo

### Estructura del Proyecto

```
my_project/
├── models/
│   ├── ReindeerModel.sysml        # Modelo importado de Lesson 11
│   ├── IntegratedExample.sysml    # Usa ReindeerModel
│   └── InterchangeExample.sysml   # Modelo independiente
└── sysand.toml
```

### ReindeerModel.sysml (Importado)

```sysml
package MyProjectReindeerModel {
    private import ScalarValues::Real;
    private import ISQ::mass;
    private import SI::kg;

    part def Reindeer {
        constant attribute weight redefines ISQ::mass default 110 [kg];
        attribute energyLevel : Real default := 100;
    }

    part def Rudolph specializes Reindeer {
        constant attribute :>> weight = 100 [kg];
        attribute :>> energyLevel := 200;
    }
}
```

### IntegratedExample.sysml (Usa el importado)

```sysml
private import MyProjectReindeerModel::*;
private import SI::*;

package MyProjectIntegrated {
    part def ReindeerTeam {
        part reindeerMembers : Reindeer[8..9];
    }

    part santaTeam : ReindeerTeam {
        part rudolph : Rudolph;
        part dasher : Reindeer {
            constant :>> weight = 105.0[SI::kg];
        }
    }
}
```

## ✅ Mejores Prácticas

### 1. Nomenclatura Consistente

- Usa un prefijo común para todos los paquetes: `MyProject*`
- Nombres descriptivos que reflejen el contenido
- Evita abreviaturas confusas

```sysml
✅ MyProjectReindeerModel
✅ MyProjectSleighSystem
✅ MyProjectInterchange

❌ MP_Reindeer  (abreviatura confusa)
❌ Model1       (no descriptivo)
```

### 2. Organización de Archivos

```
models/
├── imported/           # Modelos de lecciones anteriores
│   ├── ReindeerModel.sysml
│   └── SleighModel.sysml
├── custom/             # Modelos propios
│   └── CustomSystem.sysml
└── integration/        # Modelos que integran varios
    └── IntegratedExample.sysml
```

### 3. Documentación

Siempre documenta el origen de modelos importados:

```sysml
/**
 * Modelo de Renos importado desde Lesson 11
 * Original: L11_Attributes_Quantities.sysml
 * Adaptado para my_project con Sysand
 * Fecha: 2026-02-15
 */
package MyProjectReindeerModel {
    ...
}
```

### 4. Validación Continua

Agrega validación al flujo de trabajo:

```bash
# Antes de commits
bash scripts/validate-all.sh

# En CI/CD
syside check models/**/*.sysml
```

## 🔧 Solución de Problemas

### Error: "No Namespace named 'X' found"

**Causa**: El modelo referenciado no está en el mismo comando de validación.

**Solución**: Valida múltiples archivos juntos:
```bash
syside check models/ModelA.sysml models/ModelB.sysml
```

### Error: "shadows previously declared element"

**Causa**: Nombre de paquete duplicado.

**Solución**:
1. Renombra el paquete con un nombre único
2. Reinicia el servidor de lenguaje: `Ctrl+Shift+P` → "Syside modeler: Restart language server"

### Error: "Expected a token. Did you forget ';'?"

**Causa**: Uso de `::` en declaración de paquete.

**Solución**: Usa nombres simples sin `::`
```sysml
❌ package MyProject::Reindeer { }
✅ package MyProjectReindeer { }
```

### Error: "Subsetting feature must be constant"

**Causa**: Intentas redefinir un atributo `constant` sin especificar `constant`.

**Solución**: Agrega `constant` al redefinir:
```sysml
✅ constant :>> weight = 105.0[SI::kg];
❌ :>> weight = 105.0[SI::kg];
```

## 📚 Recursos

- [Lesson 8: Packages and Names](https://sensmetry.com/advent-of-sysml-v2-lesson-8-packages-and-names/)
- [Lesson 9: Sysand Package Manager](https://sensmetry.com/advent-of-sysml-v2-lesson-9-package-manager-for-sysml-v2/)
- [Sysand Documentation](https://docs.sysand.org/)
- [SysML v2 Cheatsheet](https://sensmetry.com/sysml-cheatsheet/)

## 🎓 Lecciones Recomendadas para Importar

| Lección | Archivo | Contenido | Complejidad |
|---------|---------|-----------|-------------|
| Lesson 11 | L11_Attributes_Quantities.sysml | Atributos y cantidades | ⭐⭐ |
| Lesson 12 | L12_Connections.sysml | Conexiones | ⭐⭐⭐ |
| Lesson 13 | L13_Ports_Interfaces.sysml | Puertos e interfaces | ⭐⭐⭐ |
| Lesson 17 | L17_Actions.sysml | Acciones | ⭐⭐⭐⭐ |
| Lesson 22 | L22_Requirements.sysml | Requisitos | ⭐⭐⭐ |

---

**Nota**: Esta guía se actualizará conforme evolucione Sysand y SysML v2.
