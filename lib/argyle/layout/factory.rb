class Argyle::Layout::Factory

  # @param klass [Class<Argyle::Layout::Base>] Subclass of Argyle::Layout::Base
  #
  # @return [Argyle::Layout::Base]
  #
  # @raise [Argyle::Error::TypeError] If the layout is not a subclass of Argyle::Layout::Base
  #
  def create(klass)
    Argyle::Assert.klass(Argyle::Layout::Base, klass)

    areas = klass.area_prototypes.transform_values do |prototype|
      prototype.klass.new(prototype.parameters)
    end

    klass.new(areas)
  end

  private

  # @param area [Argyle::Layout::Area]
  #
  # @return [Ncurses::WINDOW]
  #
  def window_for(area)

  end
end
