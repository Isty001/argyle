class Argyle::StyleSheet::Style
  attr_reader :id, :fg, :bg

  def initialize(id:, fg: nil, bg: nil)
    @id = id
    @fg = fg
    @bg = bg
  end
end
