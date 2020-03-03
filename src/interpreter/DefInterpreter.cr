require "json"

# Default interpreter
# Does a barebone spacial analysis, detecting excessive amounts of empty space, allowing for the addition of extra layouts after the fact, assuming they have been previously defined.
# Interacts with the user, allowing the choice of adding or removing layouts.
# User choice as to what file format to print in, current options are HTML and JSON (bugged)
class DefInterpreter

    # Create an array of dimensional values from the provided string, and the shape.
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
    # Draw object as an ASCII image.
    def draw(obj : AquariumObject)
        draw(obj.shape, obj.dimensions)
    end

    #TODO: Implement
    # Draw section as an ASCII image.
    def draw(sec : Section)
        draw(sec.shape, sec.dimensions)
    end

    #TODO: Implement
    # Draw the object graph as an ASCII image.
    def draw(shape : String, dimensions : String)
        if shape == "Square"

        elsif shape == "Circle"

        else
            raise "Unknown shape #{shape}" # Unknown shape, raise an error.
        end
    end

    #TODO: Implement position
    # Checks if any object is taller than an object behind it.
    def shadow(tank : Tank)
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
        elsif shape == "Circle" 
            area = (dimensions.first ** 2) * 3.14 #Radius^2 * PI
        else
            raise "Unknown shape"
        end
        area
    end

    #TODO: Implement position
    # Checks to see if any object centers intersect the golden ratio.
    def golden_ratio(tank : Tank)

    end

    # How much space is not occupied by something.
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

    # Prints the defined layouts to stdout.
    def show_layouts(layouts : Hash(String, Layout))
            layouts.each {|l|
                puts "Layout name: #{l[0]}, layout shape: #{l[1].shape}, layout size: #{l[1].dimensions}"
        }
    end

    # Prints layouts of arrays to stdout.
    def show_layouts(layouts : Array(Layout))
        layouts.each {|layout|
            puts "Layout name: #{layout.name}, layout shape: #{layout.shape}, layout size: #{layout.dimensions}"
        }
    end

    # If wasted space is greater than some percentage, ask if the user wants to add additional layouts. -> Print defined layouts.
    # User input, file format.
    def interpret(tanks : Array(Tank), layouts : Hash(String, Layout))
        puts "Welcome to AquariumLang (WIP)."
        puts "Which output format do you prefer? (HTML/JSON): "
        requested_format = gets

        # Exit if the user does not request a format.
        exit if requested_format.nil?

        # Get path. If Nil default to current directory.
        puts "Input the desired path including file name."
        path = gets

        # Repeat process for every defined tank.
        tanks.each { |tank|
            puts "Analysing tank: #{tank.name}"
            layoutLoop = false
            loop do
                emptySpace = space_waste(tank)
                puts "Empty space percentage: #{emptySpace}"

                # A lot of empty space, give option of adding additional layouts.
                if emptySpace < 0.5
                        puts "There is a lot of empty space, do you wish to add additional layouts? (y/n)"
                        addLayouts = gets
                        # User wants to add layout, display options.
                        if addLayouts == "y"
                            show_layouts(layouts)
                            # Get user input
                            puts "Which layout do you wish to add?"
                            addedLayout = gets

                            #has_key? as addedLayout is a union of String | Nil
                            if layouts.has_key?(addedLayout)
                                # Add new layout to tank.
                                tank.contains << layouts[addedLayout]
                            end
                        # Break out of loop if user does not want to add any layouts.
                        elsif addLayouts == "n"
                            layoutLoop = true
                        end
                # There is not enough space for everything.
                elsif emptySpace > 1
                    puts "Defined layout is too large for the tank, #{tank.name}"
                    puts "Do you wish to remove something from the tank? (y/n)"
                    removeLayouts = gets

                    # User wants to remove, display options.
                    if removeLayouts == "y"
                        show_layouts(tank.contains)

                        removal = gets
                        # Remove selected layout
                        tank.contains.each {|layout|
                            if layout.name == removal
                                tank.contains.delete(layout)
                            end
                        }
                    # Break out of loop if user does not want to remove anything.
                    elsif removeLayouts == "n"
                        layoutLoop = true
                    end
                    # Break out if there is not a lot of empty space.
                else
                    layoutLoop = true
                end
                break if layoutLoop
            end

            if height_check(tank)
                puts "No objects stick out."
            else
                puts "Some objects are too tall for the tank"
                #TODO: Show object that breaks the rule.
            end

        }
        puts "Outputting tanks to #{requested_format} on #{path} .#{requested_format}"

        if requested_format == "HTML"
            write_to_html(path || "./tanks", tanks)
        elsif requested_format == "JSON"
            write_to_json(path ||"./tanks", tanks)
        else
            puts "Unrecognized format #{requested_format}"
        end
            
    end

    #Write tanks to html file.
    def write_to_html(path : String, tanks : Array(Tank))
        f = File.new(path + ".html", "w")
        # Standard HTML stuff.
        f.puts "<!DOCTYPE html>"
        f.puts "<html>"
        f.puts "<head><title> Aquarium Layout Generator 1.0 </title></head>"
        f.puts "<body>"
        
        tanks.each {|tank|
            # Should probably be moved to Tank. Similar to write_to_json. 
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

    # Write tanks to json file.
    def write_to_json(path : String, tanks : Array(Tank))
        f = File.new(path + ".json", "w")

        f.puts tanks.to_json

        f.close()

    end

end