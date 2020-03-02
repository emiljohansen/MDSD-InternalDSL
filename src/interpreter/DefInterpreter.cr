# Default interpreter.
# Ideas?
# Spacial analysis. How well is the space utilised, does anything intersect the golden ratio? Does anything block the view of something? Does everything fit without overlap? -> Ask if the user wants overlap.
# Interpret dimensions -> How to draw circles and squares.
# Get user input if there are options, maybe duplicate objects in different layouts. -> Allow overlapping sections or no=

require "json"

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

    # TODO: Enhancement, Return the object too.
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
                if dim.last > tank_height # Last element is the
                    return false # False if something sticks out.
                end
            end
        }
        true # Everything fits in the tank.
    end

    #TODO: Add support for sending along the object.
    # Finds the tallest object in a section.
    def find_tallest(sec : Section) : Tuple(Float, AquariumObject)
        tallest = 0
        obj = Nil
        sec.contains.each { |a|
            if a.is_a?(Section)
                b = find_tallest(a)
            else
                dim = extract_dimensions(a.dimensions, a.shape)
                height = dim.last
                if tallest < height
                    tallest = height
                    obj = a
                end
            end
        }
        Tuple.new(a, tallest)
    end

    # Calculate the area of an object or a section.
    def area_calc(dimensions : Array, shape : String) : Float
        if shape == "Square" # Not ideal, maybe take shape too.
            area = dimensions[0] * dimensions[1] # L * W
            puts "Square Area: #{area}"
        elsif shape == "Circle" 
            area = (dimensions.first ** 2) * 3.14 #Radius^2 * PI
            puts "Circle Area #{area}"
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
        tankArea = area_calc(extract_dimensions(tank.dimensions, "Square"), "Square") #Assumption that tanks are squares.
        occupiedArea = 0
        tank.contains.each { |a|
            areaDimensions = extract_dimensions(a.dimensions, a.shape)

            occupiedArea += area_calc(areaDimensions, a.shape)
            puts "Occupied Area #{occupiedArea}"
        }
        wastedSpace = (occupiedArea / tankArea) #Percentage of wasted space.
        wastedSpace
    end

    def show_layouts(layouts : Hash(String, Layout))
            layouts.each {|l|
                puts "Layout name: #{l[0]}, layout shape #{l[1].shape}, layout size: #{l[1].dimensions}"
        }
    end

    #TODO: Implement
    # Grab user input, to allow for overlap or no. If not enough space, and no overlap allowed, raise error.
    # If wasted space is greater than some percentage, ask if the user wants to add additional layouts. -> Print options.
    # User input, what tanks to include in output. Write out the created tanks.
    # User input, file format.
    def interpret(tanks : Array(Tank), layouts : Hash(String, Layout))
        puts "Welcome to AquariumLang (WIP)."
        puts "Which output format do you prefer? (HTML/JSON): "
        requested_format = gets

        exit if requested_format.nil?


        puts "Input the desired path"
        path = gets

        iter = tanks.each()

        iter.each { |tank|
            puts tank.name
            emptySpace = space_waste(tank)
            puts "Empty space percentage: #{emptySpace}"

            if emptySpace > 0.5
                puts "There is a lot of empty space, do you wish to add additional layouts? (y/n)"
                addLayouts = gets

                if addLayouts == "y"
                    show_layouts(layouts)
                    puts "Which layout do you wish to add?"
                    addedLayout = gets

                    if layouts.has_key?(addedLayout) #has_key? as addedLayout is a union of String | Nil
                        tank.contains << layouts[addedLayout] # Add new layout to tank. TODO: Repeat if empty space is too big or small still.
                    end
                end
            
            elsif emptySpace > 1
                puts "Defined layout is too large for the tank, #{tank.name}"
                puts "Do you wish to remove something from the tank?"
            end

            if height_check(tank)
                puts "No objects stick out."
            else
                puts "Some objects are too tall for the tank"
                #TODO: Show object that breaks the rule.
            end

        }

        if requested_format == "HTML"
            write_to_html(path || "./", tanks)
        elsif requested_format == "JSON"
            write_to_json(path ||"./", tanks)
        else
            puts "Unrecognized format #{requested_format}"
        end
            
    end

    #TODO: Define file formatting.
    def write_to_html(path : String, tanks : Array(Tank))
        f = File.new(path + ".html", "w")
        f.puts "<!DOCTYPE html>"
        f.puts "<html>"
        f.puts "<head><title> Aquarium Layout Generator 1.0 </title></head>"
        f.puts "<body>"
        
        tanks.each {|tank| 
            f.puts "<div>"
            f.puts "Tank name: #{tank.name}\n Layouts: "
            tank.contains.each {|layout| 
                f.puts layout.to_html()
            }
            f.puts "</div>"
        }
        f.puts "</body>\n</html>"
        f.close()
    end

    #TODO: Implement
    def write_to_json(path : String, tanks : Array(Tank))
        f = File.new(path, "w")

    end

end