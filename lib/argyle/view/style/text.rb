class Argyle::View::Style::Text
  # @param parts [Hash{Array<Symbol>=>String}]
  #
  def initialize(parts)
    @parts = parts
  end

  # @param width [Integer]
  # @param lines [Integer]
  # @param default_style [Array<Symbol>]
  #
  # @yieldparam text [String]
  # @yieldparam style [Array<Symbol>]
  #
  def wrap(width, lines, default_style = [])
    p "hello"
  end
end
