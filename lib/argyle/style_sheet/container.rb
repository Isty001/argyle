class Argyle::StyleSheet::Container
  def initialize
    @colors = {}
    @styles = {}
  end

  # @param klass [Class<StyleSheet::Base>]
  #
  def add(klass)
    @colors.merge!(klass.color_prototypes.transform_values(&:unwrap))

    styles = klass.style_prototypes.transform_values(&:unwrap)

    validate_styles(styles)

    @styles.merge!(klass.style_prototypes.transform_values(&:unwrap))
  end

  private

  def validate_styles(styles)
    styles.each do |stlye_id, style|
      check_color_existence(stlye_id, style.fg)
      check_color_existence(stlye_id, style.bg)

      style.attributes.each do |attr_id|
        check_attribute_existence(stlye_id, attr_id)
      end
    end
  end

  def check_color_existence(stlye_id, color_id)
    return if color_id.nil? || @colors.include?(color_id)

    raise Argyle::Error::NotFound.new("Color #{color_id} not found for style: #{stlye_id}")
  end

  def check_attribute_existence(style_id, attribute_id)
    return if Argyle::View::Style::AttributeMap.include?(attribute_id)

    raise Argyle::Error::NotFound.new("Attribute #{attribute_id} not found for style: #{style_id}")
  end

  public

  # @param klass [Symbol]
  #
  def get_style(id)
    @styles[id] or raise Argyle::Error::NotFound.new("Style not found: #{id}")
  end

  # @param klass [Symbol]
  #
  def get_color(id)
    @colors[id] or raise Argyle::Error::NotFound.new("Color not found: #{id}")
  end
end
