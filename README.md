# AquariumLang

TODO: Finish Description

## Environment

Installation instructions for the crystal language can be found [here](https://crystal-lang.org/install/ "Installation Instructions")

It has been tested in Ubuntu 18.04 under Windows Subsystem for Linux. In this environment, the program can be run using "crystal run AquariumLang.cr". Alternatively simply compiling with "crystal compile AquariumLang.cr" and then running the created binary with "./AquariumLang".

## Meta Model

TODO: Update Meta model.
Tank -> Layout -> Section -> Section + Object
                -> Object

TODO: Draw and insert picture.

## Usage

.object(NAME, DIMENSIONS, SHAPE, TYPE) -> Creates an arbitrary object, given name, dimensions, shape and type.
.section(NAME, DIMENSIONS, SHAPE) -> Creates a new section, given name and dimensions.
.add_to(SECTION_NAME) -> Adds most recently defined section to a section, referred to by name.
.add_to(NAME, SECTION_NAME) -> Adds an arbitrary object or section to a section.
.new_layout(NAME, DIMENSIONS, SHAPE) -> Defines a new reusable layout.
.layout(NAME) -> Adds a previously defined layout to the most recently created tank.
.create_tank(NAME, DIMENSIONS) -> Creates a new tank. Assumed to be a square.

Shape is currently one of Circle or Square.

Dimensions are a single string, written with spaces between measurements, for Squares the format is "L W H", while for Circles the format is "R H".

### Interacting with the program

Interaction is done through a standard shell. After running the program, the user is given a number of prompts to follow. First of which is the wanted output file format, currently two options are implemented, HTML and JSON. The JSON option is currently bugged in that it will not write the entire object graph, but only the layouts.

Secondly the user is prompted if there is a large amount of empty space in the tank, given the option to add more predefined layouts to the tank, should it be wanted. The prompt is case sensitive, if the case is not matched, new layouts will not be added to the tank.

## Development

TODO: Write development instructions here


