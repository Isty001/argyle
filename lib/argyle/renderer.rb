class Argyle::Renderer
  def initialize
    @views = {
      Argyle::Component::Text => Argyle::View::Text.new
    }
  end

  # @param component_klass [Class<Argyle::Component::Base>]
  # @param view [Argyle::View::Base]
  #
  # @raise [Argyle::Error::TypeError] If component_klass is not a subclass of Argyle::Component::Base
  # @raise [Argyle::Error::TypeError] If view is not an instance of Argyle::View::Base
  #
  def set_view(component_klass, view)
    Argyle::Assert.klass(Argyle::Component::Base, component_klass)

    raise Argyle::Error::TypeError.new("View must be an instance of #{Argyle::View::Base.name}") unless view.is_a?(Argyle::View::Base)

    @views[component_klass] = view
  end

  # @param page [Argyle::Page::Base]
  #
  # @raise [Argyle::Error::NotFound] If no view is set for a component class
  # @raise [Argyle::Error::NotFound] If the layout has no associated window for the a component's area
  #
  def render(page)
    layout = page.layout
    windows = layout.windows

    page.components.each_value do |component|
      component_class = component.class
      area = component.area

      raise Argyle::Error::NotFound.new("View not found fo component #{component_class}") unless @views.include?(component_class)
      raise Argyle::Error::NotFound.new("Window not found for area: #{area}") unless windows.include?(area)

      @views[component_class].render(windows[area], component)
    end

    windows.each_value(&:refresh)
  end
end
