# AquariumLang

A small internal DSL for defining layouts in aquaria, allows for creating and reusing layouts, sections and objects.

## Environment

Installation instructions for the crystal language can be found [here](https://crystal-lang.org/install/ "Installation Instructions")

It has been tested in Ubuntu 18.04 under Windows Subsystem for Linux. Crystal version 0.32.1 with LLVM 8.0.

In this environment, the program can be run using "crystal run AquariumLang.cr". Alternatively simply compiling with "crystal compile AquariumLang.cr" and then running the created binary with "./AquariumLang".

## Meta Model

![Metamodel](./Metamodel.png)

## Usage

.object(NAME, DIMENSIONS, SHAPE, TYPE) $\rightarrow$ Creates an arbitrary object, given name, dimensions, shape and type.

.section(NAME, DIMENSIONS, SHAPE) $\rightarrow$ Creates a new section, given name and dimensions.

.add_to(SECTION_NAME) $\rightarrow$ Adds most recently defined section to a section, referred to by name.

.add_to(NAME, SECTION_NAME) $\rightarrow$ Adds an arbitrary object or section to a section.

.new_layout(NAME, DIMENSIONS, SHAPE) $\rightarrow$ Defines a new reusable layout.

.layout(NAME) $\rightarrow$ Adds a previously defined layout to the most recently created tank.

.create_tank(NAME, DIMENSIONS) $\rightarrow$ Creates a new tank. Assumed to be a square.

Shape is currently one of Circle or Square.

Dimensions are a single string, written with spaces between measurements, for Squares the format is "L W H", while for Circles the format is "R H". Height is not required for sections or layouts.

### Interacting with the program

Interaction is done through a standard shell. After running the program, the user is given a number of prompts to follow. First of which is the wanted output file format, currently two options are implemented, HTML and JSON.

Secondly the user is prompted if there is a large amount of empty space in the tank, given the option to add more predefined layouts to the tank, should it be wanted. The prompt is case sensitive, if the case is not matched, new layouts will not be added to the tank.

## Development

Implemented using the fluent interface with a builder class, introduced during lectures.

Model classes can be found in /src/model. The builder class in /src/builder and the interpreter in /src/interpreter. An example program is defined in AquariumLang.cr, which can be found in /src.
