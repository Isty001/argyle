class Argyle::View::Text < Argyle::View::Base
  # @param component [Argyle::Component::Text]
  #
  def render(window, component)
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
