require "./../model/*"

# Builderclass to construct and instance of the metamodel.
class TankBuilder

    @defTanks : Hash(String, Tank) = {} of String => Tank # Defined tanks for this builder.
    @defLayouts : Hash(String, Layout) = {} of String => Layout # Defined Layouts
    @defVariables : Hash(String, AquariumObject) = {} of String => AquariumObject # Defined objects
    @defSections : Hash(String, Section) = {} of String => Section # Defined Sections

    def initialize()

    end

    def defTanks
        @defTanks
    end

    def defLayouts
        @defLayouts
    end

    def defVariables
        @defVariables
    end

    def defSections
        @defSections
    end

    # Create a new object, adds object to last defined section.
    def object(name : String, type : String, dimensions : String, shape : String)
        ao = AquariumObject.new(name, type, dimensions, shape)
        defVariables[name] = ao
        section = defSections.last_value # Get latest created section.
        section.contains << ao
        self
    end
    
    # Create a new section
    def section(name : String, dimensions : String, shape : String)
        sec = Section.new(name, dimensions, shape)
        defSections[name] = sec
        defLayouts.last_value.contains << sec
        self
    end

    # Add a section to the last defined section.
    def add_to(section : String)
        sec = defSections[section] # Find section reference
        sec2 = defSections.last_value # Latest defined section
        sec.contains << sec2 unless sec == sec2 if sec.is_a?(Section) # Add to section 1 to section 2, if they are not the same.
        # Remove section from layout if it gets added to section. Weakness of chosen approach.
        defLayouts.each { |tup|
            tup[1].contains.each { |section|
                if sec2 == section
                    tup[1].contains.delete(section)
                end
            }
        }
        self
    end

    # Add a previously defined section or object to a section.
    def add_to(object : String, section : String)
        sec = defSections[section]
        obj = defVariables[object]
        sec.contains << obj unless sec == obj
        # Remove section from layout if it gets added to a section.
        defLayouts.each { |tup|
            tup[1].contains.each { |section|
                if sec2 == section
                    tup[1].contains.remove(section)
                end
            }
        }
        self
    end

    # Define a new layout
    def new_layout(name : String, dimensions : String, shape : String)
        layout = Layout.new(name, dimensions, shape)
        defLayouts[name] = layout
        self
    end

    # Add a layout to a tank.
    def layout(name : String)
        layout = defLayouts[name]
        defTanks.last_value.contains << layout #Adds layout to the last defined tank.
        self
    end

    # Create a new tank.
    def create_tank(name : String, dimensions : String)
        defTanks[name] = Tank.new(name, dimensions)
        self
    end

    # Return all tanks defined for this builder as an array.
    def build() : Array(Tank)
        defTanks.values()
    end
end