class Argyle::View::Base
  # @param window [Ncurses::WINDOW]
  # @param component [Argyle::Component::Base]
  #
  def render(_window, _component)
    raise NotImplementedError.new("render method must be implemented in #{self.class}")
  end
end
