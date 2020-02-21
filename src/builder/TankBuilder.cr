require model

class TankBuilder

    property name : String
    property length
    property height
    property width
    property defVariables : Hash

    # Position ?
    def object(name : String, type : String, dimensions : String)
        ao = AquariumObject.new name type dimensions
        defVariables[name] = ao # Necessary?
        defVariables[section].contains << defVariables.lastKey
        self
    end

    def section(name : String, dimensions : String, type : String, shape : Shape)
        sec = Section.new name dimensions type shape
        defVariables[name] = sec
        self
    end

    def add_to(section : String)
        sec = defVariables[section] # Find section reference
        sec.contains << defVariables.lastKey # What if last key is an object?
        self
    end

    def build()

    end
end