class Argyle::View::Base
  # @param style_container [Argyle::StyleSheet::Container]
  #
  def initialize(style_container)
    @style_container = style_container
  end

  # @param window [Ncurses::WINDOW]
  # @param component [Argyle::Component::Base]
  #
  def render(_window, _component)
    raise NotImplementedError.new("render method must be implemented in #{self.class}")
  end
end
