class Argyle::Layout::Factory

  # @param klass [Class<Argyle::Layout>] Subclass of Argyle::Layout
  #
  # @return [Argyle::Layout]
  #
  # @raise [Argyle::Error::TypeError] If the layout is not a subclass of Argyle::Layout
  #
  def create(klass)
    Argyle::Assert.klass(Argyle::Layout, klass)

    areas = klass.area_prototypes.map do |id, prototype|
      [id, prototype.klass.new(prototype.parameters)]
    end.to_h

    klass.new(areas)
  end
end
