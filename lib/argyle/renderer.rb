class Argyle::Renderer
  # @param style_container [Argyle::StyleSheet::Container]
  #
  def initialize(style_container)
    @style_container = style_container
    @views = {}

    set_view(Argyle::Component::Text, Argyle::View::Text)
  end

  # @param component_klass [Class<Argyle::Component::Base>]
  # @param view_klass [Class<Argyle::View::Base>]
  #
  # @raise [Argyle::Error::TypeError] If component_klass is not a subclass of Argyle::Component::Base
  # @raise [Argyle::Error::TypeError] If view_klass is not a subclass of Argyle::View::Base
  #
  def set_view(component_klass, view_klass)
    Argyle::Assert.klass(Argyle::Component::Base, component_klass)
    Argyle::Assert.klass(Argyle::View::Base, view_klass)

    @views[component_klass] = view_klass.new(@style_container)
  end

  # @param page [Argyle::Page::Base]
  #
  # @raise [Argyle::Error::NotFound] If no view is set for a component class
  # @raise [Argyle::Error::NotFound] If the layout has no associated window for the a component's area
  #
  def render(page)
    windows = page.layout.windows

    page.components.each_value do |component|
      component_class = component.class
      area = component.area

      unless @views.include?(component_class)
        raise Argyle::Error::NotFound.new("View not found fo component #{component_class}")
      end

      raise Argyle::Error::NotFound.new("Window not found for area: #{area}") unless windows.include?(area)

      @views[component_class].render(windows[area], component)
    end

    windows.each_value(&:refresh)
  end
end
