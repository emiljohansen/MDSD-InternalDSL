require "builder"
require "interpreter"

# TODO: Write documentation for `AquariumLang`
module AquariumLang
  VERSION = "0.1.0"
  builder = TankBuilder.new

  builder.new_layout("Layout1", "60 30", "Square")
    .section("Section1", "20 30", "Square")
      .object("Object1", "", "", "")
      .object("Object2", "", "", "")
      .object("Object3", "", "", "")
    .section("Section2", "15 15", "Square")
      .object("", "", "", "")
    .section("Section3", "10", "Circle").add_to("Section2")
      .object()
      .object()
    .section("Section4", "15", "Circle")
      .object()
    .section("Section5", "10 10").add_to("Section4")
  .new_layout("Layout2", "20 45", "Square")
    .section()
      .object()
    .section("Section6", "15 25", "Square")
      .object()
      .object()
  .new_layout("Layout3", "20", "Circle")
    .section()
      .object()
  
  .create_tank("AwesomeTank", "120 50 50")
    .layout("layout1")
    .layout("layout2")
    .new_layout("layout3")
      .section("Something")
        .object()
        .object()
  .create_tank("SmolTank", "40 20 25")
    .layout("layout3")
    .layout("layout2")
end
