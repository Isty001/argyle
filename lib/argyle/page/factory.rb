class Argyle::Page::Factory
  # @param layout_registry [Argyle::Layout::Registry]
  #
  def initialize(layout_registry)
    @layout_registry = layout_registry
  end

  # @param klass [Class<Argyle::Page::Base>] Subclass of Argyle::Page
  #
  # @return [Argyle::Page::Base]
  #
  # @raise [Argyle::Error::TypeError] If the page is not a subclass of Argyle::Page
  #
  def create(klass)
    Argyle::Assert.klass(Argyle::Page::Base, klass)

    components = klass.component_prototypes.transform_values(&:unwrap)

    klass.new(
      components,
      @layout_registry.clone(klass.layout_id || :default)
    )
  end
end
