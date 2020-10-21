class Argyle::View::Text < Argyle::View::Base

  # @param component [Argyle::Component::Text]
  #
  def render(window, component)
    Ncurses.mvwprintw(window, 0, 0, component.value)
  end
end
