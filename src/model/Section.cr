class Section

    property name : String
    property dimensions : String
    property shape : Shape
    property contains : Array = [] of T

    def initialize(name : String, dimensions : String, shape : String)
        @name
        @dimensions
        @shape
    end

end