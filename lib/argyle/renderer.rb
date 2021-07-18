class Argyle::Renderer
  # @param style_transformer [Argyle::View::StyleTransformer]
  # @param environment [Argyle::Environment]
  #
  def initialize(style_transformer, environment, input_reader: nil, keymap: nil, globals: nil)
    @style_transformer = style_transformer
    @environment = environment
    @input_reader = input_reader || Argyle::Input::Reader.new
    @keymap = keymap || Argyle::Input::Keymap.new
    @globals = globals || Argyle::Input::Globals.new(@keymap)
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

    @views[component_klass] = view_klass.new(@style_transformer, @keymap, @environment)
  end

  # @param page [Argyle::Page::Base]
  #
  # @raise [Argyle::Error::NotFound] If no view is set for a component class
  # @raise [Argyle::Error::NotFound] If the layout has no associated window for the a component's area
  #
  def render(page)
    windows = page.layout.windows
    inputs = @input_reader.read

    @globals.process(page, inputs)

    page.components.each do |component_id, component|
      component_klass = component.class
      area = component.area

      view_for(component_klass).render(
        window_for(area, windows),
        component,
        new_context(inputs, page, component_id)
      )
    end

    refresh(windows)

    @input_reader.flush
  end

  private

  # @param inputs [Array<Integer>]
  # @param page [Argyle::Page]
  # @param component_id [Symbol]
  #
  def new_context(inputs, page, component_id)
    Argyle::View::Context.new(
      inputs,
      page.focused_component_id == component_id
    )
  end

  def view_for(component_klass)
    return @views[component_klass] if @views.include?(component_klass)

    raise Argyle::Error::NotFound.new("View not found fo component #{component_klass}")
  end

  def window_for(area, windows)
    return windows[area] if windows.include?(area)

    raise Argyle::Error::NotFound.new("Window not found for area: #{area}. Is the area defined in the layout?")
  end

  def refresh(windows)
    windows.each_value do |window|
      window.refresh if window.touched?
    end
  end
end
