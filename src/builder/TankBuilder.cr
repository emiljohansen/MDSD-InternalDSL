require model

class TankBuilder

    property name : String
    property length
    property height
    property width
    property defVariables : Hash
    property defLayouts : Hash

    # Position ?
    def object(name : String, type : String, dimensions : String, shape : Shape)
        ao = AquariumObject.new name type dimensions shape
        defVariables[name] = ao # Necessary?
        defVariables[section].contains << defVariables.lastKey
        self
    end

    def section(name : String, dimensions : String, shape : Shape)
        sec = Section.new name dimensions shape
        defVariables[name] = sec
        self
    end

    def add_to(section : String)
        sec = defVariables[section] # Find section reference
        sec.contains << defVariables.lastKey # What if last key is an object?
        self
    end

    def new_layout(name : String, dimensions : String, shape : Shape)
        lay = layout.new name dimensions shape
        defLayouts[name] = lay
        self
    end

    def add_layout(name : String)

        self
    end

    def build()

    end
end