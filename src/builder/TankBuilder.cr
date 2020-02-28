require "model"

#TODO: Initialize objects with empty fields to allow referencing before creation.
class TankBuilder

    property defVariables : Hash = {} of String => T # Defined Variables, ie. sections and objects.
    property defLayouts : Hash = {} of String => Layout # Defined Layouts.
    property defTanks : Hash = {} of String => Tank # All defined tanks for this builder.

    # Position ?
    # Create a new object, adds object to last defined section.
    def object(name : String, type : String, dimensions : String, shape : String)
        ao = AquariumObject.new name type dimensions shape
        defVariables[name] = ao # Necessary?
        defVariables[section].contains << defVariables.select{ |k, v| typeof(v) == Section}.lastKey
        self
    end
    
    # Create a new section
    def section(name : String, dimensions : String, shape : String)
        sec = Section.new name dimensions shape
        defVariables[name] = sec
        self
    end

    # Add a section to the last defined section.
    def add_to(section : String)
        sec = defVariables[section] # Find section reference
        sec2 = defVariables.select{ |k, v| typeof(v) == Section}.lastKey
        sec.contains << sec2 unless sec == sec2
        self
    end

    # Add a previously defined section or object to a section.
    def add_to(object : String, section : String)
        sec = defVariables[section]
        obj = defVariables[object]
        sec.contains << obj unless sec == obj
        self
    end

    # Define a new layout
    def new_layout(name : String, dimensions : String, shape : Shape)
        lay = layout.new name dimensions shape
        defLayouts[name] = lay
        self
    end

    # Add a layout to a tank.
    def add_layout(name : String)
        layout = defLayouts[name]?
        defTanks.lastKey.contains << layout if not Nil
        self
    end

    # Create a new tank.
    def create_tank(name : String, dimensions : String)
        finalLayout = {} of String => T
        defTanks[name] = Tank.new name dimensions
        self
    end
end