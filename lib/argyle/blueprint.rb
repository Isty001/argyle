# @!attribute [r] pages
#   @return [Hash{Symbol=>Argyle::Page}]
#
class Argyle::Blueprint
  attr_reader :pages

  # @param layout_factory [Argyle::Layout::Factory]
  # @param layout_registry [Argyle::Layout::Registry]
  # @param page_factory [Argyle::Page::Factory]
  # @param renderer [Argyle::Renderer]
  # @param style_container [Argyle::StyleSheet::Container]
  #
  def initialize(layout_factory: nil, layout_registry: nil, page_factory: nil, renderer: nil, style_container: nil)
    @pages = {}
    @current_page = nil
    @layout_factory = layout_factory || Argyle::Layout::Factory.new
    @layout_registry = layout_registry || Argyle::Layout::Registry.new
    @page_factory = page_factory || Argyle::Page::Factory.new(@layout_registry)

    @style_container = style_container || Argyle::StyleSheet::Container.new
    @renderer = renderer || create_renderer

    add_layout(:default, Argyle::Layout::Default)
    add_style_sheet(Argyle::StyleSheet::Default)

    add_view(Argyle::Component::Text, Argyle::View::Text)
    add_view(Argyle::Component::Menu, Argyle::View::Menu)

    at_exit { Argyle::Publisher.instance.publish(:exit) }
  end

  private

  def create_renderer
    style_transformer = Argyle::View::StyleTransformer.new(@style_container)

    Argyle::Renderer.new(style_transformer)
  end

  public

  # @param id [Symbol]
  # @param page_klass [Class<Argyle::Page::Base>] Subclass of Argyle::Page::Base
  #
  def add_page(id, page_klass)
    raise Argyle::Error::ArgumentError.new("No id given for page: #{page_klass}") if id.nil?

    page = @page_factory.create(page_klass)
    @pages[id] = page

    @current_page = page if @current_page.nil?
  end

  # @param id [Symbol]
  # @param layout_klass [Class<Argyle::Layout::Base>] Subclass of Argyle::Layout::Base
  #
  def add_layout(id, layout_klass)
    @layout_registry.add(id, @layout_factory.create(layout_klass))
  end

  # @param sheet_klass [Class<Argyle::StyleSheet::Base>]
  #
  def add_style_sheet(sheet_klass)
    @style_container.add(sheet_klass)
  end

  # @param component_klass [Class<Argyle::Component::Base>]
  # @param view_klass [Class<Argyle::View::Base>]
  #
  def add_view(component_klass, view_klass)
    @renderer.add_view(component_klass, view_klass)
  end

  # Renders the current page
  #
  def render
    Argyle.activate

    raise Argyle::Error::NotFound.new('No pages defined yet') if @pages.empty?

    @renderer.render(@current_page)
  end
end
