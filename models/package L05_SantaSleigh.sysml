// Reindeer model imported from Lesson 5. Adapted for my_project with Sysand.

// ============================================================================
// SYSAND DEPENDENCIES
// ============================================================================
// This model depends on standard libraries installed via sysand install:
//
// Installation commands:
//   sysand install ISQ
//   sysand install SI
//   sysand install ScalarValues
//
// - ISQ (International System of Quantities) - Used for physical quantity types
// - SI (International System of Units) - Used for unit values (kg, cm, etc.)
// - ScalarValues - Used for basic scalar types (Boolean, Real, String, etc.)
// ============================================================================

package L05_SantaSleigh {
    private import ScalarValues::*;
    private import ISQ::*;
    private import SI::*;

// Enumerations

  enum def Color {
        enum red;
        enum gold;
        enum white;
        enum brown;
        enum blue;
    }

    enum def SkillType {
        enum assembly;
        enum navigation;
        enum magic;
    }

// Basic Definitions

    part def Bag;

    part def OrdinaryBag specializes Bag;

    part def Hallway;

    part def Person;

// Cargo Bay Architecture (Polymorphic Design)

    part def CargoBay {
        // Common access point to payload regardless of configuration
        ref part payload : Bag [1..*];
    }

    // Ordinary cargo bay: holds exactly one BottomlessGiftBag
    part def OrdinaryCargoBay specializes CargoBay {
        ref part payload : BottomlessGiftBag [1] redefines payload;
    }

    // Magical cargo bay: holds multiple ordinary bags
    part def MagicalCargoBay specializes CargoBay {
        ref part payload : OrdinaryBag [1..*] redefines payload;
    }

    // Bottomless bag definition
    part def BottomlessGiftBag specializes Bag {
        doc /* A magic container that stores any number of gifts */
        attribute infiniteCapacity : Boolean = true;
    }

// Sleigh Definitions

    part def Sleigh {
        part cargoBay : CargoBay [1];
        attribute bagColor : Color = Color::red;
    }

    part def SantaSleigh specializes Sleigh {
        doc /* Magical vehicle pulled by flying reindeer */

        // Exactly two runners, explicitly enumerated
        part leftHallway  : Hallway [1];
        part rightHallway : Hallway [1];

        // Referential usage (external entity)
        ref part mrsClaus : Person [1];
    }

 // Reindeer Features

    attribute def ReindeerFeatures{
        //Not variables, so cannot be constant!
        attribute eyecolor : Color;
        attribute noseColor : Color;
        attribute antlerLength : LengthValue;
        attribute skillLevel  : Real;
        attribute skillType   : SkillType;
        attribute name   : String;
    }
    
    part def Reindeer{
        attribute features : ReindeerFeatures;
        attribute weight : MassValue default 110 [kg];
    }

// Reindeer Team (9 total)

    part reindeerTeam {
        doc /* The team of reindeer pulling the magic sleigh*/

        part dasher : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::assembly;
                attribute :>> name = "Dasher";
            }
            attribute :>> weight = 100 [kg];
        }

        part dancer : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::magic;
                attribute :>> name = "Dancer";
            }
            attribute :>> weight = 100 [kg];
        }

        part prancer : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::navigation;
                attribute :>> name = "Prancer";
            }
            attribute :>> weight = 100 [kg];
        }

        part vixen : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::magic;
                attribute :>> name = "Vixen";
            }
            attribute :>> weight = 100 [kg];
        }

        part comet : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::magic;
                attribute :>> name = "Comet";
            }
            attribute :>> weight = 100 [kg];
        }

        part cupid : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::magic;
                attribute :>> name = "Cupid";
            }
            attribute :>> weight = 100 [kg];
        }

        part donner : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::magic;
                attribute :>> name = "Donner";
            }
            attribute :>> weight = 100 [kg];
        }

        part blitzen : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::brown;
                attribute :>> noseColor = Color::brown;
                attribute :>> antlerLength = 60 [cm];
                attribute :>> skillLevel = 150;
                attribute :>> skillType = SkillType::magic;
                attribute :>> name = "Blitzen";
            }
            attribute :>> weight = 100 [kg];
        }

        part rudolph : Reindeer {
            attribute :>> features : ReindeerFeatures {
                attribute :>> eyecolor = Color::blue;
                attribute :>> noseColor = Color::red;
                attribute :>> antlerLength = 70 [cm];
                attribute :>> skillLevel = 200;
                attribute :>> skillType = SkillType::navigation;
                attribute :>> name = "Rudolph";
            }
            attribute :>> weight = 110 [kg];
        }

    }

}


