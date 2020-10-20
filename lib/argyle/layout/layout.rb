# @!attribute [r] areas
#   @return [Hash{Symbol=>Argyle::Layout::Area}]
#
class Argyle::Layout

  attr_reader :areas

  # @param areas [Hash{Symbol=>Argyle::Layout::Area}]
  #
  def initialize(areas)
    @areas = areas
  end

  # @!attribute [r] area_prototypes
  #   @return [Hash{Symbol=>Argyle::Prototype}]
  #
  class << self
    attr_reader :area_prototypes

    # @param id [Symbol]
    #
    def area(id)
      area_prototypes[id] = Argyle::Prototype.new(Argyle::Layout::Area, {})
    end

    def inherited(klass)
      klass.instance_variable_set('@area_prototypes', area_prototypes || {})

      klass.area(:main)
    end
  end
end