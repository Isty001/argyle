# @!attribute [r] :fg
#   @return [Symbol]
#
# @!attribute [r] :bg
#   @return [Symbol]
#
# @!attribute [r] :attributes
#   @return [Array<Symbol>]
#
class Argyle::StyleSheet::Style
  attr_reader :fg, :bg, :attributes

  def initialize(fg: nil, bg: nil, attributes: [])
    @fg = fg
    @bg = bg
    @attributes = attributes
  end
end
