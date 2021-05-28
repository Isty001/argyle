# @!attribute [r] components
#   @return [Hash{Symbol=>Argyle::Component::Base}]
#
# @!attribute [r] layout
#   @return [Argyle::Layout::Base]
#
# @note A Page instance will hold the actual initialized Component instances which are unique to the given Page instance
#
# @see Argyle::Page::Factory
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
  # @note Every Page definition must inherit from this Base
  #
  class << self
    attr_reader :component_prototypes, :layout_id

    # @!group Adding Components
    #
    # @param id [Symbol]
    # @param (see Argyle::Component::Text#initialize)
    #
    # @see Argyle::Component::Text
    #
    def text(id:, **args)
      args[:area] = @current_area

      component_prototypes[id] = Argyle::Prototype.new(Argyle::Component::Text, args)
    end

    # @param id [Symbol]
    # @param (see Argyle::Component::Menu#initialize)
    #
    # @see Argyle::Component::Menu
    #
    def menu(id:, **args)
      args[:area] = @current_area

      component_prototypes[id] = Argyle::Prototype.new(Argyle::Component::Menu, args)
    end

    # @param id [Symbol]
    # @param (see Argyle::Component::Menu#initialize)
    #
    # @see Argyle::Component::MenuItem
    #
    # MenuItems cannot be added directly to the Page. Can only be used inside menu.items
    #
    def menu_item(**args)
      Argyle::Prototype.new(Argyle::Component::MenuItem, args)
    end

    # @!endgroup
    #
    # @param id [Symbol]
    #
    # @yield
    #
    # @raise [Argyle::Error::RuntimeError] When area calls are nested
    #
    # The Components created inside the block will be diplayed inside the Area defined by the Layout
    #
    # @see Argyle::Layout::Base
    #
    def area(id)
      unless @current_area == Argyle::Layout::Base::DEFAULT_AREA
        raise Argyle::Error::RuntimeError.new('Areas cannot be nested')
      end

      @current_area = id
      yield
      @current_area = Argyle::Layout::Base::DEFAULT_AREA
    end

    # @param id [Symbol]
    #
    # Defines which Layout is used by the Page thus areas of the Layout can be used when adding Components
    #
    def layout(id)
      @layout_id = id
    end

    private

    def inherited(klass)
      super

      klass.instance_variable_set('@current_area', Argyle::Layout::Base::DEFAULT_AREA)

      klass.instance_variable_set('@component_prototypes', component_prototypes || {})
      klass.instance_variable_set('@layout_id', layout_id)
    end
  end
end
