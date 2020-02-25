# AquariumLang

TODO: Finish Description

## Environment

Installation instructions for the crystal language can be found [here](https://crystal-lang.org/install/ "Installation Instructions")

## Meta Model

TODO: Update Meta model.
Tank -> Section -> Plants
                -> Object -> Plants
                -> Object -> Plants
                -> Section -> Repeat.

TODO: Draw and insert picture.

## Usage

TODO: Write usage instructions here

.object() -> Creates an arbitrary object, given name, dimensions and type. -> Should be able to be reused, ie. plantgroups can be placed multiple times.
.section() -> Creates a new section, given name and dimensions.
.add_to(SECTION_NAME) -> Adds most recently defined section to a section, referred to by name.
.add_to(NAME, SECTION_NAME) -> Adds an arbitrary object or section to an arbitrary section.
.new_layout() -> Defines a new reusable layout.
.layout(NAME) -> Adds a previously defined layout to a tank.
.create_tank() -> Creates a new tank. 

## Development

TODO: Write development instructions here


