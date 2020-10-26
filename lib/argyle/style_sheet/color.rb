class Argyle::StyleSheet::Color
  attr_reader :id, :r, :g, :b

  def initialize(id:, r:, g:, b:)
    @id = id
    @r = r
    @g = g
    @b = b
  end
end
