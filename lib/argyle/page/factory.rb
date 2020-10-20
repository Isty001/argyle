class Argyle::Page::Factory

  # @param layout_registry [Argyle::Layout::Registry]
  #
  def initialize(layout_registry)
    @layout_registry = layout_registry
  end

  # @param klass [Class<Argyle::Page>] Subclass of Argyle::Page
  #
  # @return [Argyle::Page]
  #
  # @raise [Argyle::Error::TypeError] If the page is not a subclass of Argyle::Page
  #
  def create(klass)
    Argyle::Assert.klass(Argyle::Page, klass)

    components = klass.component_prototypes.map do |id, prototype|
      [id, prototype.klass.new(**prototype.parameters)]
    end.to_h

    klass.new(
      components,
      @layout_registry.clone(klass.layout_id || :default)
    )
  end
end
