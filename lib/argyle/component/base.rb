class Argyle::Component::Base
  attr_reader :area, :style

  # @param area [Symbol]
  # @param style [Symbol
  #
  def initialize(area:, style: nil)
    @area = area.to_sym
    @style = style
  end
end
