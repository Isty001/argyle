class Argyle::Layout::Registry

  def initialize
    @layouts = {}
  end

  # @param id [Symbol]
  # @param layout [Argyle::Layout]
  #
  # @raise [Argyle::Error::TypeError] If layout is not an instance of Argyle::Layout
  #
  def set(id, layout)
    raise Argyle::Error::TypeError.new("Layout must be an instance of #{Argyle::Layout}") unless layout.is_a?(Argyle::Layout)

    @layouts[id] = layout
  end

  # @param id [Symbol]
  #
  # @return [Argyle::Layout] Clone of the original definition
  #
  # @raise [Argyle::Error::NotFound] If the layout does not exist
  #
  def clone(id)
    raise Argyle::Error::NotFound.new("Unknown layout: #{id}") unless @layouts.include?(id)

    @layouts[id].clone
  end
end
