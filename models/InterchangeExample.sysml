/**
 * Ejemplo de modelo SysML v2 para intercambio
 * Este archivo demuestra un proyecto de intercambio mínimo con Sysand
 */

// Importar paquetes estándar con visibilidad explícita
private import ScalarValues::*;
private import ISQ::*;
private import SI::*;

/**
 * Paquete principal del proyecto de intercambio
 */
package MyProjectInterchange {

    /**
     * Definición de un componente genérico reutilizable
     */
    part def Component {
        doc /*
         * Componente base para el sistema de intercambio.
         * Incluye atributos físicos básicos.
         */

        // Atributos con unidades ISQ/SI
        attribute mass : ISQ::MassValue;
        attribute volume : ISQ::VolumeValue;
        attribute temperature : ISQ::ThermodynamicTemperatureValue;

        // Metadatos del componente
        attribute id : ScalarValues::String;
        attribute status : ScalarValues::Boolean;
    }

    /**
     * Sistema de ejemplo que usa el componente
     */
    part def System {
        doc /* Sistema principal que contiene componentes */

        // Atributos del sistema
        attribute systemName : ScalarValues::String;
        attribute operatingTemp : ISQ::ThermodynamicTemperatureValue;

        // Componentes del sistema
        part components : Component[1..*];
    }

    /**
     * Instancia concreta del sistema
     */
    part mySystem : System {
        :>> systemName = "Sistema de Intercambio v1";
        :>> operatingTemp = 298.15[SI::K];  // 25°C en Kelvin

        // Componente específico
        part component1 : Component {
            :>> mass = 10.0[SI::kg];
            :>> volume = 500.0[SI::L];
            :>> temperature = 298.15[SI::K];  // 25°C en Kelvin
            :>> id = "COMP-001";
            :>> status = true;
        }
    }

    /**
     * Metadatos del proyecto de intercambio
     */
    metadata def InterchangeMetadata {
        doc /* Metadatos para intercambio entre herramientas */

        attribute projectName : ScalarValues::String;
        attribute version : ScalarValues::String;
        attribute exportDate : ScalarValues::String;
    }

    metadata projectInfo : InterchangeMetadata {
        :>> projectName = "my_project";
        :>> version = "0.1.0";
        :>> exportDate = "2026-02-15";
    }
}
