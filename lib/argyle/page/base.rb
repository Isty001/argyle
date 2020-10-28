# @!attribute [r] components
#   @return [Hash{Symbol=>Argyle::Component::Base}]
#
# @!attribute [r] layout
#   @return [Argyle::Layout::Base]
#
class Argyle::Page::Base
  attr_reader :components, :layout

  def initialize(components, layout)
    @components = components
    @layout = layout
  end

  # @!attribute [r] component_prototypes
  #   @return [Hash{Symbol=>Argyle::Prototype}]
  #
  # @!attribute [r] layout_id
  #   @return [Symbol]
  #
  # @!attribute [r] id
  #   @return [Symbol]
  #
  class << self
    attr_reader :component_prototypes, :layout_id

    private

    # @param id [Symbol]
    # @param value [String]
    #
    def text(id, **opts)
      opts[:area] = @current_area

      component_prototypes[id] = Argyle::Prototype.new(Argyle::Component::Text, opts)
    end

    # @param id [Symbol]
    #
    # @raise [Argyle::Error::RuntimeError] When area calls are nested
    #
    def area(id)
      raise Argyle::Error::RuntimeError.new('Areas cannot be nested') unless @current_area == :main

      @current_area = id
      yield
      @current_area = :main
    end

    # @param id [Symbol]
    #
    def layout(id)
      @layout_id = id
    end

    def inherited(klass)
      super

      klass.instance_variable_set('@current_area', :main)

      klass.instance_variable_set('@component_prototypes', component_prototypes || {})
      klass.instance_variable_set('@layout_id', layout_id)
    end
  end
end
