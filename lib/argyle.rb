require 'ncursesw'

module Argyle
  class << self
    def activate
      return if active?

      Ncurses.initscr
      Ncurses.start_color
      Ncurses.use_default_colors
      Ncurses.cbreak
      Ncurses.noecho
      # Ncurses.curs_set(0)
      Ncurses.stdscr.intrflush(false)
      Ncurses.stdscr.keypad(true)
      Ncurses.stdscr.nodelay(true)

      @active = true
    end

    def deactivate
      return unless active?

      Ncurses.endwin

      @active = false
    end

    def active?
      @active ||= false
    end
  end
end

require_relative 'argyle/assert'
require_relative 'argyle/blueprint'
require_relative 'argyle/error'
require_relative 'argyle/prototype'
require_relative 'argyle/renderer'

require_relative 'argyle/component/component'
require_relative 'argyle/page/page'
require_relative 'argyle/layout/layout'
require_relative 'argyle/style_sheet/style_sheet'
require_relative 'argyle/view/view'
