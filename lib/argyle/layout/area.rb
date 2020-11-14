# @!attribute [r] float
#   @return [Array<Symbol>]
#
# @!attribute [r] relative_width
#   @return [Integer]
#
# @!attribute [r] relative_height
#   @return [Integer]
#
# @!attribute [r] offset
#   @return [Array<Symbol>]
#
class Argyle::Layout::Area
  attr_reader :float, :relative_width, :relative_height, :relative_offsets

  # @param float [Array<Symbol>]
  # @param width [Symbol]
  # @param height [Symbol]
  # @param offset [Array<Symbol>]
  #
  def initialize(float: [], width: nil, height: nil, offset: [])
    @float = float
    @relative_width = Argyle::Positioning.parse_relative_size(width)
    @relative_height = Argyle::Positioning.parse_relative_size(height)
    @relative_offsets = offset.to_h.transform_values { |m| Argyle::Positioning.parse_relative_size(m) }
  end
end
