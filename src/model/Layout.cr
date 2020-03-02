class Layout

    property name : String
    property dimensions : String
    property shape : String
    #property contains : Array

    def initialize(@name : String, @dimensions : String, @shape : String)
        @contains = [] of Section | AquariumObject
    end
end