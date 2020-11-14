class Argyle::Renderer
  # @param style_transformer [Argyle::View::StyleTransformer]
  #
  def initialize(style_transformer)
    @style_transformer = style_transformer
    @views = {}
  end

  # @param component_klass [Class<Argyle::Component::Base>]
  # @param view_klass [Class<Argyle::View::Base>]
  #
  # @raise [Argyle::Error::TypeError] If component_klass is not a subclass of Argyle::Component::Base
  # @raise [Argyle::Error::TypeError] If view_klass is not a subclass of Argyle::View::Base
  #
  def add_view(component_klass, view_klass)
    Argyle::Assert.klass(Argyle::Component::Base, component_klass)
    Argyle::Assert.klass(Argyle::View::Base, view_klass)

    @views[component_klass] = view_klass.new(@style_transformer)
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

      unless windows.include?(area)
        raise Argyle::Error::NotFound.new("Window not found for area: #{area}. Is the area defined in the layout?")
      end

      @views[component_class].render(windows[area], component)
    end

    windows.each_value(&:refresh)
  end
end
