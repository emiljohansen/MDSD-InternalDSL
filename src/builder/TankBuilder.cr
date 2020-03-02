require "./../model/*"

#TODO: Initialize objects with empty fields to allow referencing before creation.
class TankBuilder

    #property defVariables : Hash = {} of String => T # Defined Variables, ie. sections and objects.
    #property defLayouts : Hash = {} of String => Layout # Defined Layouts.
    #property defTanks : Hash = {} of String => Tank # All defined tanks for this builder.

    @defTanks : Hash(String, Tank) = {} of String => Tank
    @defLayouts : Hash(String, Layout) = {} of String => Layout
    @defVariables : Hash(String, AquariumObject) = {} of String => AquariumObject
    @defSections : Hash(String, Section) = {} of String => Section

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

    # Position ?
    # Create a new object, adds object to last defined section.
    def object(name : String, type : String, dimensions : String, shape : String)
        ao = AquariumObject.new(name, type, dimensions, shape)
        defVariables[name] = ao # Necessary?
        #section = defVariables.select{ |k, v| typeof(v) == Section.class}.last_value #Doesn't work, as type is Section | AquariumObject
        section = defSections.last_value
        if section.is_a?(Section)
            section.contains << ao #FIXME: Type coerce to Section. (Introduce seperate maps for section and object?)
        end
        self
    end
    
    # Create a new section
    def section(name : String, dimensions : String, shape : String)
        sec = Section.new(name, dimensions, shape)
        defSections[name] = sec
        self
    end

    # Add a section to the last defined section.
    def add_to(section : String)
        sec = defSections[section] # Find section reference
        #sec2 = defVariables.select{ |k, v| typeof(v) == Section}.last_value
        sec2 = defSections.last_value
        sec.contains << sec2 unless sec == sec2 if sec.is_a?(Section)
        self
    end

    # Add a previously defined section or object to a section.
    def add_to(object : String, section : String)
        sec = defSections[section]
        obj = defVariables[object]
        sec.contains << obj unless sec == obj
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
        defTanks.last_value.contains << layout #Adds layout to the last defined tank, if the layout exists.
        self
    end

    # Create a new tank.
    def create_tank(name : String, dimensions : String)
        finalLayout = {} of String => Layout
        defTanks[name] = Tank.new(name, dimensions)
        self
    end

    # Return all tanks defined for this build as an array.
    def build() : Array(Tank)
        defTanks.values()
    end
end