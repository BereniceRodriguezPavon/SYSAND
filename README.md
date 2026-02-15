# SYSAND

SYSAND DEPENDENCIES

## 📋 Descripción

Este proyecto está configurado como un **proyecto de intercambio** (interchange project) que permite importar y exportar modelos SysML v2 entre diferentes herramientas y sistemas.

## 📁 Estructura del Proyecto

```
my_project/
├── sysand.toml                      # Configuración de Sysand
├── .project.json                    # Metadatos del proyecto de intercambio
├── .meta.json                       # Metadatos de intercambio extendidos
├── models/                          # Modelos SysML v2
│   └── InterchangeExample.sysml    # Modelo de ejemplo
├── src/                             # Fuentes adicionales
├── docs/                            # Documentación
└── README.md
```

## 🚀 Características

### Archivos de Configuración

1. **sysand.toml**: Configuración del gestor de paquetes Sysand
   - Metadatos del paquete (nombre, versión, autores)
   - Dependencias de otros paquetes
   - Configuración de build y validación
   - Tipo de proyecto: `interchange`

2. **.project.json**: Metadatos del proyecto de intercambio
   - Información del proyecto
   - Estructura de carpetas
   - Scripts de build y validación
   - Configuración de intercambio (importable/exportable)

3. **.meta.json**: Metadatos extendidos de intercambio
   - Protocolo de intercambio: `sysmlv2-json`
   - Capacidades bidireccionales
   - Herramientas utilizadas (Syside, Sysand, Git)
   - Validación estricta con imports explícitos
   - Formatos soportados (JSON, XML, SysML)

## ✅ Validación

Todos los archivos .sysml siguen las mejores prácticas:
- ✅ Imports con visibilidad explícita (`private import`)
- ✅ Uso de paquetes `ISQ` y `SI` para unidades físicas
- ✅ Paquetes con nombres únicos para evitar shadowing
- ✅ Validados con `syside check`

## 🛠️ Comandos Útiles

### Validar archivos
```bash
# Validar un archivo específico
syside check models/InterchangeExample.sysml

# Validar todos los modelos
syside check models/**/*.sysml
```

### Formatear archivos
```bash
# Formatear un archivo
syside format models/InterchangeExample.sysml
```

### Build con Sysand
```bash
# Construir el proyecto
sysand build

# Actualizar dependencias
sysand update
```

## 📦 Intercambio de Modelos

Este proyecto está configurado para intercambio bidireccional:

### Exportar modelos
- Formato JSON para intercambio entre herramientas
- Preserva metadatos y relaciones
- Compatible con estándar SysML v2

### Importar modelos
- Soporta formatos: SysML textual, JSON, XML
- Valida automáticamente los imports
- Verifica unicidad de nombres de paquetes

## 📚 Recursos

- **Sysand**: https://sysand.org/
- **Sysand Docs**: https://docs.sysand.org/
- **Lesson 9 - Package Manager**: https://sensmetry.com/advent-of-sysml-v2-lesson-9-package-manager-for-sysml-v2/
- **Syside Docs**: https://docs.sensmetry.com/
- **SysML v2 Cheatsheet**: https://sensmetry.com/sysml-cheatsheet/

## 🔧 Desarrollo

### Agregar dependencias
Edita `sysand.toml` en la sección `[dependencies]`:

```toml
[dependencies]
nombre-paquete = { version = "1.0.0", registry = "https://sysand.org" }
```

### Crear nuevos modelos
1. Crea archivos `.sysml` en `models/` o `src/`
2. Usa imports explícitos: `private import ISQ::*;`
3. Define paquetes únicos
4. Valida con: `syside check models/tu-archivo.sysml`

## 📄 Licencia

MIT License - ver archivo LICENSE

## 👥 Autores

- Tu Nombre <tu.email@ejemplo.com>
