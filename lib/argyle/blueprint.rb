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
    @layouts = []
    @current_page = nil
    @layout_factory = layout_factory || Argyle::Layout::Factory.new
    @layout_registry = layout_registry || create_layout_registry
    @page_factory = page_factory || Argyle::Page::Factory.new(@layout_registry)
    @renderer = renderer || Argyle::Renderer.new
  end

  private
  def create_layout_registry
    registry = Argyle::Layout::Registry.new
    registry.set(@layout_factory.create(Argyle::Layout::Default))

    registry
  end

  public

  # @param page_klass [Class<Argyle::Page::Base>] Subclass of Argyle::Page::Base
  #
  def set_page(page_klass)
    page = @page_factory.create(page_klass)
    @pages[page_klass.identifier] = page

    @current_page = page if @current_page.nil?
  end

  # @note Renders the current page
  #
  def render
    raise Argyle::Error::NotFound.new('No pages defined yet') if @pages.empty?

    @renderer.render(@current_page)
  end
end
