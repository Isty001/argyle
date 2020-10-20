# @!attribute [r] pages
#   @return [Hash{Symbol=>Argyle::Page}]
#
class Argyle::Blueprint

  attr_reader :pages

  # @param layout_factory [Argyle::Layout::Factory]
  # @param layout_registry [Argyle::Layout::Registry]
  # @param page_factory [Argyle::Page::Factory]
  #
  def initialize(layout_factory: nil, layout_registry: nil, page_factory: nil)
    @pages = {}
    @layouts = []
    @current_page = nil
    @layout_factory = layout_factory || Argyle::Layout::Factory.new
    @layout_registry = layout_registry || create_layout_registry
    @page_factory = page_factory || Argyle::Page::Factory.new(@layout_registry)
  end

  private
  def create_layout_registry
    registry = Argyle::Layout::Registry.new
    registry.set(:default, @layout_factory.create(Argyle::Layout::Default))

    registry
  end

  public

  # @param id [Symbol]
  # @param page [Class<Argyle::Page>] Subclass of Argyle::Page
  #
  # @raise [Argyle::Error::ArgumentError] If the id already exists
  #
  def add_page(id, page_klass)
    raise Argyle::Error::ArgumentError.new("Page #{id} already exists") if @pages.include?(id)

    page = @page_factory.create(page_klass)
    @pages[id] = page

    @current_page = page if @current_page.nil?
  end

  # @return [Argyle::Page]
  #
  # @raise [Argyle::Error::RuntimeError] If no pages defined yet
  #
  def current_page
    raise Argyle::Error::RuntimeError.new('No pages defined yet') if @pages.empty?

    @current_page
  end

  # @param id [Symbol]
  #
  # @raise [Argyle::Error::NotFound] If no page exists with the id
  #
  def current_page=(id)
    raise Argyle::Error::NotFound.new("Unknown page: #{id}") unless @pages.include?(id)

    @current_page = @pages[id]
  end

  def render
    @renderer.render(@current_page)
  end
end
