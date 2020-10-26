class Argyle::StyleSheet::Container
  def initialize
    @colors = {}
    @styles = {}
  end

  # @param klass [Class<StyleSheet::Base>]
  #
  def add(klass)
    @colors.merge!(klass.color_prototypes.transform_values(&:unwrap))
    @styles.merge!(klass.style_prototypes.transform_values(&:unwrap))
  end
end
