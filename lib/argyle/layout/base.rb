# @!attribute [r] areas
#   @return [Hash{Symbol=>Argyle::Layout::Area}]
#
# @!attribute [r] windows
#   @return [Hash{Symbol=>Curses::WINDOW}]
#
class Argyle::Layout::Base
  # This Area will always be defined on every Layout, by default with full Window size.
  # You can redefine the default values via {.area} in your Layout.
  # If no Area is set for a component, then this will be used.
  #
  DEFAULT_AREA = :main

  attr_accessor :windows
  attr_reader :areas

  # @param areas [Hash{Symbol=>Argyle::Layout::Area}]
  # @param windows [Hash{Symbol=>Curses::WINDOW}] Mapped to the corresponding Area
  #
  def initialize(areas, windows)
    @areas = areas

    @windows = windows
  end

  # @!attribute [r] area_prototypes
  #   @return [Hash{Symbol=>Argyle::Prototype}]
  #
  class << self
    attr_reader :area_prototypes

    # @param id [Symbol]
    #
    def area(id:, **opts)
      area_prototypes[id] = Argyle::Prototype.new(Argyle::Layout::Area, opts)
    end

    private

    def inherited(klass)
      super

      klass.instance_variable_set('@area_prototypes', area_prototypes || {})

      klass.area(id: DEFAULT_AREA)
    end
  end
end
