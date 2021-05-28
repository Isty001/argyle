class Argyle::View::Text < Argyle::View::Base
  # @param window [Curses::Window]
  # @param component [Argyle::Component::Text]
  # @param _ [Argyle::Component::Context]
  #
  def render(window, component, _)
    x, y, width, height = component_gemoetry(window, component)

    style(window, component.style) do
      wrap_text(component.value, width, height).each do |line|
        window.setpos(y, x)
        window.addstr(line)
        y += 1
      end
    end
  end
end
