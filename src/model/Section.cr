class Section

    property name : String
    property dimensions : String
    property shape : String
    #property contains : Array

    def initialize(@name : String, @dimensions : String, @shape : String)
        @name
        @dimensions
        @shape
        @contains = [] of Section | AquariumObject
    end

    def name
        @name
    end

    def contains
        @contains
    end

end