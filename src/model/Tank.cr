class Tank

    property name : String
    property dimensions : String

    #property contains : Array = [] of Layout


    def initialize(@name : String, @dimensions : String)
        @name
        @dimensions
        @contains = []of Layout
    end

    def contains
        @contains
    end
end