# @!attribute [r] float
#   @return [Array<Symbol>]
#
# @!attribute [r] relative_width
#   @return [Integer]
#
# @!attribute [r] relative_height
#   @return [Integer]
#
class Argyle::Layout::Area
  attr_reader :float, :relative_width, :relative_height

  def initialize(float: nil, width: nil, height: nil)
    @float = float
    @relative_width = match_size(width)
    @relative_height = match_size(height)
  end

  private

  def match_size(raw)
    return if raw.nil?

    match = raw.to_s.match(/(\d{1,2})%/)

    raise Argyle::Error::ArgumentError.new("Invalid size format: #{raw}") unless match

    match.captures.first.to_i
  end
end
