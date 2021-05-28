require 'curses'

module Argyle
  class << self
    def activate
      return if active?

      Curses.init_screen
      Curses.start_color
      Curses.use_default_colors
      Curses.cbreak
      Curses.noecho
      # Curses.curs_set(0)
      Curses.stdscr.keypad(true)
      Curses.stdscr.nodelay = true

      @active = true
    end

    def deactivate
      return unless active?

      Curses.close_screen

      @active = false
    end

    def active?
      @active ||= false
    end
  end
end

require_relative 'argyle/positioning'
require_relative 'argyle/publisher'
require_relative 'argyle/subscriber'
require_relative 'argyle/assert'
require_relative 'argyle/blueprint'
require_relative 'argyle/error'
require_relative 'argyle/prototype'
require_relative 'argyle/renderer'

require_relative 'argyle/input/input'
require_relative 'argyle/component/component'
require_relative 'argyle/page/page'
require_relative 'argyle/layout/layout'
require_relative 'argyle/style_sheet/style_sheet'
require_relative 'argyle/view/view'
