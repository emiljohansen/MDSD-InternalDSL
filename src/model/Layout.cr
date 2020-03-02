class Layout

    property name : String
    property dimensions : String
    property shape : String
    #property contains : Array

    def initialize(@name : String, @dimensions : String, @shape : String)
        @contains = [] of Section | AquariumObject
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

    def contains
        @contains
    end
end