class Argyle::View::Text < Argyle::View::Base
  # @param component [Argyle::Component::Text]
  #
  def render(window, component)
    style(window, component.style) do
      window.mvwprintw(0, 0, component.value)
    end
  end
end
