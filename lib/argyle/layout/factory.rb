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

  private

  # @param area [Argyle::Layout::Area]
  #
  # @return [Ncurses::WINDOW]
  #
  def create_window(id, area)
    max_height = Ncurses.getmaxy(Ncurses.stdscr)
    max_width = Ncurses.getmaxx(Ncurses.stdscr)

    width = calculate_size(area.relative_width, max_width)
    height = calculate_size(area.relative_height, max_height)

    y, x = calculate_coordinates(area.float, width, height, max_width, max_height)

    win = Ncurses::WINDOW.new(height, width, y, x)
    win.box(0, 0)

    [id, win]
  end

  def calculate_size(relative_size, max_size)
    relative_size ? (max_size * (relative_size / 100.0)).to_i : max_size
  end

  def calculate_coordinates(float, width, height, max_width, max_height)
    y = 0
    x = 0

    float.to_a.each do |item|
      case item
      when :right
        x = max_width - width
      when :bottom
        y = max_height - height
      when :center
        y = (max_height - height) / 2
        x = (max_width - width) / 2
      end
    end

    [y, x]
  end
end
