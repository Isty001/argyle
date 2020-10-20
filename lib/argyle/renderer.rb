class Argyle::Renderer
  def initialize
    @views = {
      Argyle::Component::Text => Argyle::View::Text.new
    }
  end

  # @param page [Argyle::Page]
  #
  def render(page)
    page.components.each do |component|
      @views[component.class].render
    end
  end
end
