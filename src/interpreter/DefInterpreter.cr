# Default interpreter.
# Ideas?
# Spacial analysis. How well is the space utilised, does anything intersect the golden ratio? Does anything block the view of something? Does everything fit without overlap? -> Ask if the user wants overlap.
# Interpret dimensions -> How to draw circles and squares.
# Get user input if there are options, maybe duplicate objects in different layouts. -> Allow overlapping sections or no=

class DefInterpreter

    def extract_diemnsions(dimensions : String, shape : String)
        when shape == "Square"
        
        when shape == "Circle"
        
        else
            raise "Unknown shape #{shape}"
    end

    def draw(obj : AquariumObject)
        draw obj.shape obj.dimensions
    end

    def draw(sec : Section)
        draw sec.shape sec.dimensions
    end

    def draw(shape : String, dimensions : String)

    end

    def shadow(tank : Tank)
        # Iterate sections and objects.
        # Check if objects further back are shorter than ones in front.
    end

    def space_waste(tank : Tank)
        # How much space is not occupied by sections.
        tank_area = extract_diemnsions tank.dimensions tank.shape
        while tank.contains.size != 0
        
        end
    end

    def write_file()
    
    end
        # Grab user input, to allow for overlap or no.
    def interpret()
    
    end

end