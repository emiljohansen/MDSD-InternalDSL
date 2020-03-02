require "./builder/TankBuilder"
require "./interpreter/DefInterpreter"

# TODO: Write documentation for `AquariumLang`
module AquariumLang
  VERSION = "0.1.0"
  builder = TankBuilder.new

   builder.new_layout("Layout1", "60 30", "Square")
    .section("Section1", "20 30", "Square")
      .object("Object1", "5 5 40", "Square", "Decoration")
      .object("Object2", "10 10 15", "Square", "Decoration")
      .object("Object3", "7 15", "Circle", "Decoration")
    .section("Section2", "15 15", "Square")
      .object("Object4", "10 10 30", "Square", "Plant")
    .section("Section3", "10", "Circle").add_to("Section2")
      .object("Object5", "3 3 10", "Square", "Decoration")
      .object("Object6", "7 7 7", "Square", "Decoration")
    .section("Section4", "15", "Circle")
      .object("Object7", "10 10 50", "Square", "Decoration")
    .section("Section5", "10 10", "Square").add_to("Section4")
  .new_layout("Layout2", "20 45", "Square")
    .section("Section6", "", "")
      .object("Object8", "8 8 18", "Square", "Plant")
    .section("Section7", "15 25", "Square")
      .object("Object9", "20 5 9", "Square", "Root")
      .object("Object10", "11 7 21", "Square", "Stone")
  .new_layout("Layout3", "20", "Circle")
    .section("Section8", "15 15", "Square")
      .object("Object11", "10 25", "Circle", "Plant")
  
  .create_tank("AwesomeTank", "120 50 50")
    .layout("Layout1")
    .layout("Layout2")
    .new_layout("Layout3", "20 20", "Square")
      .section("Something", "30 30", "Square")
        .object("Object12", "10 15 15", "Square", "Rock")
        .object("Object13", "10 5 5", "Square", "Rock")
  .create_tank("SmolTank", "40 20 25")
    .layout("Layout3")
    .layout("Layout2")

  tanks = builder.build()

  interpreter = DefInterpreter.new

  interpreter.interpret(tanks, builder.defLayouts)
end
