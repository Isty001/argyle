require 'ostruct'

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
  class << self
    attr_reader :component_prototypes, :layout_id

    private

    # @param id [Symbol]
    # @param value [String]
    #
    def text(id, value)
      component_prototypes[id] = Argyle::Prototype.new(Argyle::Component::Text, {value: value, area: @current_area})
    end

    # @param id [Symbol]
    #
    def area(id)
      @current_area = id
      yield
      @current_area = nil
    end

    # @param id [Symbol]
    #
    def layout(id)
      @layout_id = id
    end

    def inherited(klass)
      klass.instance_variable_set('@current_area', nil)

      klass.instance_variable_set('@component_prototypes', component_prototypes || {})
      klass.instance_variable_set('@layout_id', layout_id)
    end
  end
end


