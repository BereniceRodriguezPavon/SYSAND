/**
 * Ejemplo de integración que usa el modelo importado
 * Demuestra cómo usar modelos de lecciones anteriores en Sysand
 */

// Importar el modelo de Renos que acabamos de integrar
private import MyProjectReindeerModel::*;

// Otros imports necesarios
private import ScalarValues::*;
private import ISQ::*;
private import SI::*;

package MyProjectIntegrated {

    /**
     * Sistema que usa los renos del modelo importado
     */
    part def ReindeerTeam {
        doc /* Equipo de renos para el trineo de Santa */

        attribute teamName : String;
        attribute totalWeight : ISQ::MassValue;

        // Usar la definición de Reindeer del modelo importado
        part reindeerMembers : Reindeer[8..9] {
            doc /* Típicamente 8 renos, 9 con Rudolph */
        }
    }

    /**
     * Instancia concreta del equipo
     */
    part santaReindeerTeam : ReindeerTeam {
        :>> teamName = "Equipo de Santa 2026";

        // Rudolph como líder (usa la definición importada)
        part rudolph : Rudolph {
            doc /* El reno de nariz roja */
        }

        // Otros renos del equipo
        part dasher : Reindeer {
            constant :>> weight = 105.0[SI::kg];
            constant :>> features = new ReindeerFeatures(
                Color::brown,
                Color::brown,
                55.0[SI::cm]
            );
            :>> energyLevel := 180.0;
        }

        part dancer : Reindeer {
            constant :>> weight = 108.0[SI::kg];
            constant :>> features = new ReindeerFeatures(
                Color::brown,
                Color::brown,
                58.0[SI::cm]
            );
            :>> energyLevel := 175.0;
        }
    }

    /**
     * Ejemplo de cálculo simple
     */
    calc def AverageWeight {
        in weight1 : ISQ::MassValue;
        in weight2 : ISQ::MassValue;
        return average : ISQ::MassValue = (weight1 + weight2) / 2.0;
    }
}
