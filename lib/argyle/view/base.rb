class Argyle::View::Base
  # @param style_transformer [Argyle::View::StyleTransformer]
  # @param keymap [Argyle::Input::Keymap]
  # @param environment [Argyle::Environment]
  #
  def initialize(style_transformer, keymap, environment)
    @style_transformer = style_transformer
    @keymap = keymap
    @environment = environment
  end

  # @param _window [Curses::WINDOW]
  # @param _component [Argyle::Component::Base]
  # @param _context [Argyle::View::Context]
  #
  def render(_window, _component, _context)
    raise NotImplementedError.new("render method must be implemented in #{self.class}")
  end

  private

  def style(window, id, &block)
    @style_transformer.apply(window, id, &block)
  end

  # @param str [String]
  # @param width [Integer]
  # @param max_lines [Integer]
  #
  # @return [Array<String>] Array of lines with width fitting the window size
  #
  def wrap_text(str, width, max_lines)
    lines = str.split(/(.{1,#{width}})(\s+|\Z)/).map(&:strip).reject(&:empty?)

    lines.take(max_lines)
  end

  # @param window [Curses::WINDOW]
  # @param component [Argyle::Component::Base]
  #
  # @return [Array<Integer>] Geometry values: [x, y, width, height]
  #
  def component_gemoetry(window, component)
    max_width = window.maxx
    max_height = window.maxy

    width = Argyle::Positioning.convert_relative_size(component.relative_width, max_width)
    height = Argyle::Positioning.convert_relative_size(component.relative_height, max_height)

    x, y = component_coordinates(component, width, height, max_width, max_height)

    [
      x + 1,
      y + 1,
      [width - 2, 0].max,
      [height - 2, 0].max
    ]
  end

  # @param component [Argyle::Component::Base]
  # @param width [Integer]
  # @param height [Integer]
  # @param max_width [Integer]
  # @param max_height [Integer]
  #
  # @return [Array<Integer>] Componenet Coordinates: [x, y]
  #
  def component_coordinates(component, width, height, max_width, max_height)
    x, y = Argyle::Positioning.float_to_coordinates(component.float, width, height, max_width, max_height)

    Argyle::Positioning.apply_offsets(x, y, max_width, max_height, component.relative_offsets)
  end
end
