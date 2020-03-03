require "json"

# Represents an object in the aquarium, fx. decorations or plants.
class AquariumObject

    property name : String
    property dimensions : String
    property shape : String
    property type : String

    def initialize(@name : String, @dimensions : String, @shape : String, @type : String)

    end

    def to_html()
        returnstring = ""
        returnstring += "<div>"
        returnstring += "Object Name: #{name}\n dimensions #{dimensions}, shape #{shape}, type #{type}"
        returnstring += "</div>"
        returnstring
    end

    JSON.mapping(
        name: String,
        dimensions: String,
        shape: String,
        type: String,
    )

end