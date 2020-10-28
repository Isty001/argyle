class Argyle::Layout::Registry
  def initialize
    @layouts = {}
  end

  # @param id [Symbol]
  # @param layout [Argyle::Layout::Base]
  #
  # @raise [Argyle::Error::TypeError] If layout is not an instance of Argyle::Layout::Base
  # @raise [Argyle::Error::ArgumentError] If he layout has no id set
  #
  def add(id, layout)
    unless layout.is_a?(Argyle::Layout::Base)
      raise Argyle::Error::TypeError.new("Layout must be an instance of #{Argyle::Layout::Base}")
    end

    raise Argyle::Error::ArgumentError.new("No id given for layout: #{layout.class}") if id.nil?

    @layouts[id] = layout
  end

  # @param id [Symbol]
  #
  # @return [Argyle::Layout::Base] Clone of the original definition
  #
  # @raise [Argyle::Error::NotFound] If the layout does not exist
  #
  def clone(id)
    raise Argyle::Error::NotFound.new("Unknown layout: #{id}") unless @layouts.include?(id)

    @layouts[id].clone
  end
end
