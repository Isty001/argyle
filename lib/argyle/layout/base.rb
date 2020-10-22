# @!attribute [r] areas
#   @return [Hash{Symbol=>Argyle::Layout::Area}]
#
# @!attribute [r] windows
#   @return [Hash{Symbol=>Ncurses::WINDOW}]
#
# @!attribute [r] identifier
#   @return [Symbol]
#
class Argyle::Layout::Base
  attr_reader :areas, :windows

  # @param areas [Hash{Symbol=>Argyle::Layout::Area}]
  # @param windows [Hash{Symbol=>Ncurses::WINDOW}] Mapped to the corresponding Area
  #
  def initialize(areas, windows)
    @areas = areas
    @windows = windows
  end

  # @!attribute [r] area_prototypes
  #   @return [Hash{Symbol=>Argyle::Prototype}]
  #
  class << self
    attr_reader :area_prototypes, :identifier

    protected

    # @param id [Symbol]
    #
    def area(id)
      area_prototypes[id] = Argyle::Prototype.new(Argyle::Layout::Area, {})
    end

    private

    # @param id [Symbol]
    #
    def id(id)
      @identifier = id
    end

    def inherited(klass)
      super

      klass.instance_variable_set('@area_prototypes', area_prototypes || {})

      klass.area(:main)
    end
  end
end
