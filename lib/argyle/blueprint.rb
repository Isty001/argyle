# @!attribute [r] pages
#   @return [Hash{Symbol=>Argyle::Page}]
#
class Argyle::Blueprint
  attr_reader :pages

  # @param layout_factory [Argyle::Layout::Factory]
  # @param layout_registry [Argyle::Layout::Registry]
  # @param page_factory [Argyle::Page::Factory]
  # @param renderer [Argyle::Renderer]
  #
  def initialize(layout_factory: nil, layout_registry: nil, page_factory: nil, renderer: nil)
    @pages = {}
    @current_page = nil
    @layout_factory = layout_factory || Argyle::Layout::Factory.new
    @layout_registry = layout_registry || Argyle::Layout::Registry.new
    @page_factory = page_factory || Argyle::Page::Factory.new(@layout_registry)

    @renderer = renderer || create_renderer

    add_layout(:default, Argyle::Layout::Default)
  end

  private

  def create_renderer
    container = Argyle::StyleSheet::Container.new
    container.add(Argyle::StyleSheet::Default)

    style_transformer = Argyle::View::StyleTransformer.new(container)

    renderer = Argyle::Renderer.new(style_transformer)
    renderer.add_view(Argyle::Component::Text, Argyle::View::Text)

    renderer
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

  # @note Renders the current page
  #
  def render
    raise Argyle::Error::NotFound.new('No pages defined yet') if @pages.empty?

    @renderer.render(@current_page)
  end
end
