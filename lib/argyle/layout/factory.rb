class Argyle::Layout::Factory

  # @param klass [Class<Argyle::Layout::Base>] Subclass of Argyle::Layout::Base
  #
  # @return [Argyle::Layout::Base]
  #
  # @raise [Argyle::Error::TypeError] If the layout is not a subclass of Argyle::Layout::Base
  #
  def create(klass)
    Argyle::Assert.klass(Argyle::Layout::Base, klass)

    areas = klass.area_prototypes.transform_values do |prototype|
      prototype.klass.new(prototype.parameters)
    end

    windows = areas.map(&method(:create_window)).to_h

    klass.new(areas, windows)
  end

  private

  # @param area [Argyle::Layout::Area]
  #
  # @return [Ncurses::WINDOW]
  #
  def create_window(id, area)
    max_height = Ncurses.getmaxy(Ncurses.stdscr)
    max_width = Ncurses.getmaxx(Ncurses.stdscr)

    width = area.width || max_width
    height = area.height || max_height

    y = 0
    x = 0

    [id, Ncurses::WINDOW.new(height, width, y, x)]
  end
end
