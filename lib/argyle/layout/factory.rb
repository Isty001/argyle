class Argyle::Layout::Factory
  # @param klass [Class<Argyle::Layout::Base>] Subclass of Argyle::Layout::Base
  #
  # @return [Argyle::Layout::Base]
  #
  # @raise [Argyle::Error::TypeError] If the layout is not a subclass of Argyle::Layout::Base
  #
  def create(klass)
    Argyle::Assert.klass(Argyle::Layout::Base, klass)

    areas = klass.area_prototypes.transform_values(&:unwrap)

    windows = areas.map(&method(:create_window)).to_h

    klass.new(areas, windows)
  end

  # @param layout [Argyle::Layout::Base]
  #
  def refresh(layout)
    layout.windows.values.each(&:close)

    layout.windows = layout.areas.map(&method(:create_window)).to_h
  end

  private

  # @param area [Argyle::Layout::Area]
  #
  # @return [Curses::WINDOW]
  #
  def create_window(id, area)
    max_width = Curses.stdscr.maxx
    max_height = Curses.stdscr.maxy

    width = Argyle::Positioning.convert_relative_size(area.relative_width, max_width)
    height = Argyle::Positioning.convert_relative_size(area.relative_height, max_height)

    x, y = Argyle::Positioning.float_to_coordinates(area.float, width, height, max_width, max_height)
    x, y = Argyle::Positioning.apply_offsets(x, y, max_width, max_height, area.relative_offsets)

    win = Curses::Window.new(height, width, y, x)
    win.box(0, 0)

    [id, win]
  end
end
