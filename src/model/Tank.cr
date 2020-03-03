require "json"

# Defines a tank, consists of layouts.
class Tank

    property name : String
    property dimensions : String


    def initialize(@name : String, @dimensions : String)
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