# @!attribute [r] area
#   @return [Symbol]
#
# @!attribute [r] relative_width
#   @return [Integer]
#
# @!attribute [r] relative_height
#   @return [Integer]
#
# @!attribute [r] float
#   @return [Array<Symbol>]
#
# @!attribute [r] style
#   @return [Symbol]
#
# @!attribute [r] offset
#   @return [Array<Symbol>]
#
class Argyle::Component::Base
  attr_reader :style, :relative_width, :relative_height, :float, :area, :relative_offsets

  # @param area [Symbol]
  # @param width [Integer]
  # @param height [Integer]
  # @param float [Array<Symbol>]
  # @param style [Symbol]
  # @param offset [Array<Symbol>]
  #
  def initialize(area:, width: nil, height: nil, float: [], style: nil, offset: [])
    @area = area.to_sym
    @relative_width = Argyle::Positioning.parse_relative_size(width)
    @relative_height = Argyle::Positioning.parse_relative_size(height)
    @float = float
    @style = style
    @relative_offsets = offset.to_h.transform_values { |m| Argyle::Positioning.parse_relative_size(m) }
  end
end
