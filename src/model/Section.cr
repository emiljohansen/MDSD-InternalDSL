require "json"

# Represents defined sections in the aquarium, these can contain other sections or objects.
class Section

    property name : String
    property dimensions : String
    property shape : String

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

    def to_html() : String
        returnstring = ""
        returnstring += "<div>"
        contains.each {|part|
            returnstring += "Section Name: #{name}\n dimensions #{dimensions}, shape #{shape}" 
            returnstring += part.to_html()
        }
        returnstring += "</div>"
        returnstring
    end

    JSON.mapping(
        name: String,
        dimensions: String,
        shape: String,
        contains: Array(Section | AquariumObject),
    )

end