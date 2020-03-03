require "json"

# Higher order layout, consists of sections and objects. Allows easier composition to tanks.
class Layout

    property name : String
    property dimensions : String
    property shape : String

    def initialize(@name : String, @dimensions : String, @shape : String)
        @contains = [] of Section | AquariumObject
    end

    def contains
        @contains
    end

    def to_html() : String
        returnstring = ""
        returnstring = "<div>"
        returnstring += "Layout Name: #{name}\n dimensions #{dimensions}, shape #{shape}" 
        contains.each {|part|
            returnstring += part.to_html()
        }
        returnstring += "</div>"
        returnstring   
    end

    JSON.mapping(
        name: String,
        dimensions: String,
        shape: String,
        contains: Array(Section | AquariumObject)
    )

end