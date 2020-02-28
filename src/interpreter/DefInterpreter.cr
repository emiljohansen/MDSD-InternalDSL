# Default interpreter.
# Ideas?
# Spacial analysis. How well is the space utilised, does anything intersect the golden ratio? Does anything block the view of something? Does everything fit without overlap? -> Ask if the user wants overlap.
# Interpret dimensions -> How to draw circles and squares.
# Get user input if there are options, maybe duplicate objects in different layouts. -> Allow overlapping sections or no=

require "json"

class DefInterpreter

    #TODO: Test.
    def extract_dimensions(dim : String, shape : String) : [] of Float
        dimensions = [] of Float
        if shape == "Square"
            dimensions = dim.split(" ").map! {|x| x as Float}
        elsif shape == "Circle"
            radius = dim.as(Float)
            dimensions.Push(radius)
        else
            raise "Unknown shape #{shape}"
        end
        dimensions
    end

    def draw(obj : AquariumObject)
        draw(obj.shape, obj.dimensions)
    end

    #TODO: Implement
    def draw(sec : Section)
        draw(sec.shape, sec.dimensions)
    end

    #TODO: Implement
    def draw(shape : String, dimensions : String)
    if shape == "Square"

    elsif shape == "Circle"

    else
        raise "Unknown shape #{shape}"
    end

    end

    #TODO: Implement
    def shadow(tank : Tank)
        # Iterate sections and objects.
        # Check if objects further back are shorter than ones in front.
        # Position?
    end

    def area_calc(dimensions : Array) : Float
        if dimensions.size == 3 # Not ideal, maybe take shape too.
            lw = dimensions.first(2)
            area = lw.pop * lw.pop
        elsif dimensions.size == 2
            area = dimensions.first(1) * 3.14
        else
            raise "Unknown shape"
        end
        area
    end

    #TODO: Implement
    #FIXME: Position
    def golden_ratio(tank : Tank)

    end

    #TODO: Test
    def space_waste(tank : Tank) : Float
        # How much space is not occupied by sections.
        tankArea = area_calc(extract_dimensions(tank.dimensions, tank.shape))
        occupiedArea = 0
        while tank.contains.size != 0
            a = tank.contains.pop(1)
            areaDimensions = extract_dimensions(a.dimensions, a.shape)

            occupiedArea += area_calc(areaDimensions)
        end
        wastedSpace = (occupiedArea / tankArea) #Percentage of wasted space.
        wastedSpace
    end

    #TODO: Implement
    # Grab user input, to allow for overlap or no. If not enough space, and no overlap allowed, raise error.
    # If wasted space is greater than some percentage, ask if the user wants to add additional layouts. -> Print options.
    # User input, what tanks to include in output. Write out the created tanks.
    # User input, file format.
    #FIXME: Allow removal of objects that are too tall? Maybe allow adding to different section.
    def interpret()
    
    end

    #TODO: Define file formatting.
    def write_to_html(path : String)

    end

    #TODO: Define json layouts. Print only tank?
    def write_to_json(path : String)

    end

end