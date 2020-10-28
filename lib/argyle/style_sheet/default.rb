class Argyle::StyleSheet::Default < Argyle::StyleSheet::Base
  color(:red, r: 255, g: 0, b: 0)
  color(:green, r: 0, g: 255, b: 0)
  color(:blue, r: 0, g: 0, b: 255)

  style(:red_fg, fg: :red)
  style(:gree_fg, fg: :green)
  style(:blue_fg, fg: :blue)

  style(:red_bg, bg: :red)
  style(:gree_bg, bg: :green)
  style(:blue_bg, bg: :blue)
end
