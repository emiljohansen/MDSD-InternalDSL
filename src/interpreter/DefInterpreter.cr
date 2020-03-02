# Default interpreter.
# Ideas?
# Spacial analysis. How well is the space utilised, does anything intersect the golden ratio? Does anything block the view of something? Does everything fit without overlap? -> Ask if the user wants overlap.
# Interpret dimensions -> How to draw circles and squares.
# Get user input if there are options, maybe duplicate objects in different layouts. -> Allow overlapping sections or no=

require "json"
#FIXME: Fix pop issue.
class DefInterpreter

    #TODO: Test.
    # Create an array of dimensional values from the provided string, 
    def extract_dimensions(dim : String, shape : String)
        dimensions = [] of Float64
        if shape == "Square"
            dimensions = dim.split(" ").map {|x| x.to_f()} # Split given string on space, map into new array as floats.
        elsif shape == "Circle"
            dimensions = dim.split(" ").map {|x| x.to_f()}
        else
            raise "Unknown shape #{shape}" # Unhandled shape, raises an error.
        end
        dimensions
    end

    #TODO: Implement
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
            raise "Unknown shape #{shape}" # Unknown shape, raise an error.
        end
    end

    #TODO: Implement
    def shadow(tank : Tank)
        # Iterate sections and objects.
        # Check if objects further back are shorter than ones in front.
        # Position?
    end

    #TODO: Implement
    # Check if anything is too tall and wont fit in the tank.
    def height_check(tank : Tank) : Bool
        tank_height = extract_dimensions(tank.dimensions, "Square").last
        tank.contains.each { |a|
            if a.is_a?(Section)
                b = find_tallest(a)
                if b > tank_height
                    return false # Something is taller than the tank.
                end
            else
                dim = extract_dimensions(a.dimensions, a.shape)
                if dim.last > tank_height
                    return false # False if something sticks out.
                end
            end
        }
        true # Everything fits in the tank.
    end

    #TODO: Test
    # Finds tallest object in a section.
    def find_tallest(sec : Section) : Float
        tallest = 0
        while sec.contains.size < 0
            a = sec.contains.first
            if a.is_a?(Section)
                b = find_tallest(a)
            else
                dim = extract_dimensions(a.dimensions, a.shape)
                height = dim.last
                tallest = height if tallest < height
            end
        end
        tallest
    end

    # Calculate the area of an object or a section.
    def area_calc(dimensions : Array) : Float
        if dimensions.size == 3 # Not ideal, maybe take shape too.
            lw = dimensions.first(2)
            area = lw.pop * lw.pop
        elsif dimensions.size == 2
            area = dimensions.first * 3.14
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
    # How much space is not occupied by something.
    # Test for unoccupied space in sections too?
    def space_waste(tank : Tank) : Float
        tankArea = area_calc(extract_dimensions(tank.dimensions, "Square"))
        occupiedArea = 0
        tank.contains.each { |a|
            areaDimensions = extract_dimensions(a.dimensions, a.shape)

            occupiedArea += area_calc(areaDimensions)
        }
        wastedSpace = (occupiedArea / tankArea) #Percentage of wasted space.
        wastedSpace
    end

    def show_layouts()
    
    end

    #TODO: Implement
    # Grab user input, to allow for overlap or no. If not enough space, and no overlap allowed, raise error.
    # If wasted space is greater than some percentage, ask if the user wants to add additional layouts. -> Print options.
    # User input, what tanks to include in output. Write out the created tanks.
    # User input, file format.
    #FIXME: Allow removal of objects that are too tall? Maybe allow adding to different section.
    def interpret(tanks : Array(Tank))
        puts "Welcome to AquariumLang (WIP)."
        puts "Which output format do you prefer? (HTML/JSON): "
        requested_format = gets

        exit if requested_format.nil?


        puts "Input the desired path"
        path = gets

        if requested_format == "HTML"
            write_to_html(path || "./")
        elsif requested_format == "JSON"
            write_to_json(path ||"./")
        else
            puts "Unrecognized format #{requested_format}"
        end

        iter = tanks.each()

        iter.each { |tank|
            puts tank.name
            emptySpace = space_waste(tank)
            puts "Empty space percentage: #{emptySpace}"

            if emptySpace > 0.5
                puts "There is a lot of empty space, do you wish to add additional layouts? (y/n)"
                addLayouts = gets

                if addLayouts == "y"
                    show_layouts()
                end
            
            elsif emptySpace > 1
                puts "Defined layout is too large for the tank, #{tank.name}"
            end

            if height_check(tank)
                puts "No objects stick out."
            else
                puts "Some objects are too tall for the tank"
                #TODO: Show object that breaks the rule.
            end

        }
            
    end

    #TODO: Define file formatting.
    def write_to_html(path : String)

    end

    #TODO: Define json layouts. Print only tank?
    def write_to_json(path : String)

    end

end