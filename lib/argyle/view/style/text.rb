require 'ostruct'

class Argyle::View::Style::Text
  class Part
    attr_reader :text, :style

    # @!attribute [r] text
    #   @return [String]
    #
    # @!attribute [r] style
    #   @return [Array<Symbol>]
    #
    def initialize(text, style = [])
      @text = text.freeze
      @style = style.freeze
    end
  end

  private_constant :Part

  def initialize
    @parts = []
  end

  def append(text, style)
    @parts << Part.new(text, style)
    self
  end

  def freeze
    super

    @parts.freeze
  end

  # @param line_length [Integer]
  # @param line_count [Integer]
  # @param default_style [Array<Symbol>]
  #
  # @yieldparam text [String]
  # @yieldparam style [Array<Symbol>]
  #
  def wrap(line_length, line_count, default_style = [])

    lines = []

    # @param part [Part]
    @parts.each do |part|
    end
  end
end
