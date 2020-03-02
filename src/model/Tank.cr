require "json"

class Tank

    property name : String
    property dimensions : String


    def initialize(@name : String, @dimensions : String)
        @name
        @dimensions
        @contains = []of Layout
    end

    def contains
        @contains
    end

    JSON.mapping(
        name: String,
        dimensions: String,
        contains: Array(Layout),
    )
end