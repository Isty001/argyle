class Argyle::View::Text < Argyle::View::Base
  # @param window [Curses::Window]
  # @param component [Argyle::Component::Text]
  # @param _ [Argyle::Component::Context]
  #
  def render(window, component, _)
    return unless component.changed?

    x, y, width, height = component_gemoetry(window, component)

    component.update(window.subwin(height, width, y, x))

    display_text(component)
  end

  private

  # @param component [Argyle::Component::Text]
  #
  def display_text(component)
    y = 0

    window = component.window

    style(window, component.style) do
      wrap_text(component.value, window.maxx, window.maxy).each do |line|
        window.setpos(y, 0)
        window.addstr(line)
        y += 1
      end
    end
  end
end
