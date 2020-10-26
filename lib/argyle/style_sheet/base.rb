class Argyle::StyleSheet::Base
  # @!attribute [r] style_prototypes
  #   @return [Hash{Symbol=>Argyle::Prototype}]
  #
  # @!attribute [r] color_prototypes
  #   @return [Hash{Symbol=>Argyle::Prototype}]
  #
  class << self
    attr_reader :style_prototypes, :color_prototypes

    def color(id, r:, g:, b:)
      color_prototypes[id] = Argyle::Prototype.new(Argyle::StyleSheet::Color, {r: r, g: g, b: b})
    end

    # @param id [Symbol]
    #
    # @option opts [Symbol] :fg Foreground color
    # @option opts [Symbol] :bg Background color
    #
    def style(id, **opts)
      style_prototypes[id] = Argyle::Prototype.new(Argyle::StyleSheet::Style, opts)
    end
  end
end
