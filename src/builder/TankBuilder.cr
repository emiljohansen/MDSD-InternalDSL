require model

class TankBuilder

    property name : String
    property length
    property height
    property width
    property defVariables : Hash = {} of String => T # Defined Variables, ie. sections and objects.
    property defLayouts : Hash = {} of String => T # Defined Layouts.
    property finalLayout : Hash = {} of String => T # Final layout of a tank.

    # Position ?
    def object(name : String, type : String, dimensions : String, shape : Shape)
        ao = AquariumObject.new name type dimensions shape
        defVariables[name] = ao # Necessary?
        defVariables[section].contains << defVariables.select{ |k, v| typeof(v) == Section}.lastKey
        self
    end

    def section(name : String, dimensions : String, shape : Shape)
        sec = Section.new name dimensions shape
        defVariables[name] = sec
        self
    end

    def add_to(section : String)
        sec = defVariables[section] # Find section reference
        sec.contains << defVariables.select{ |k, v| typeof(v) == Section}.lastKey
        self
    end

    def new_layout(name : String, dimensions : String, shape : Shape)
        lay = layout.new name dimensions shape
        defLayouts[name] = lay
        self
    end

    def add_layout(name : String)
        finalLayout[name] = defLayouts[name]?
        self
    end
end