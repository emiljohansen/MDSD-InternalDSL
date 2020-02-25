require model

class TankBuilder

    property defVariables : Hash = {} of String => T # Defined Variables, ie. sections and objects.
    property defLayouts : Hash = {} of String => T # Defined Layouts.
    property defTanks : Hash = {} of String => T # All defined tanks for this builder.

    # Position ?
    def object(name : String, type : String, dimensions : String, shape : String)
        ao = AquariumObject.new name type dimensions shape
        defVariables[name] = ao # Necessary?
        defVariables[section].contains << defVariables.select{ |k, v| typeof(v) == Section}.lastKey
        self
    end
    #TODO: Fix shape, given as string but passed as a Shape.
    def section(name : String, dimensions : String, shape : String)
        sec = Section.new name dimensions shape
        defVariables[name] = sec
        self
    end

    def add_to(section : String)
        sec = defVariables[section] # Find section reference
        sec.contains << defVariables.select{ |k, v| typeof(v) == Section}.lastKey
        self
    end

    # Add a previously defined section or object to a section.
    def add_to(object : String, section : String)
        defVariables[section].contains << defVariables[object]
        self
    end

    def new_layout(name : String, dimensions : String, shape : Shape)
        lay = layout.new name dimensions shape
        defLayouts[name] = lay
        self
    end

    def add_layout(name : String)
        layout = defLayouts[name]?
        defTanks.lastKey.contains << layout if not Nil
        self
    end

    def create_tank(name : String, dimensions : String)
        finalLayout = {} of String => T
        defTanks[name] = Tank.new name dimensions
        self
    end
end