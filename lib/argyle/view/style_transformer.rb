class Argyle::View::StyleTransformer
  # @param style_container [Argyle::StyleSheet::Container]
  #
  def initialize(style_container)
    @id_sequnce = 100
    @color_id_map = {}
    @style_container = style_container
    @stlye_attr_id_map = {}
  end

  # @param window [Curses::WINDOW]
  # @param style_ids [Array<Symbol>]
  # @yield
  #
  def apply(window, style_ids)
    return if style_ids.to_a.nil?

    init_style_list(style_ids) unless @stlye_attr_id_map.include?(style_ids)

    attr = @stlye_attr_id_map[style_ids]

    window.attron(attr)
    yield
    window.attroff(attr)
  end

  private

  def init_style_list(style_ids)
    attributes = style_ids.select(&Argyle::View::AttributeMap.method(:include?)) || []

    custom_style_ids = style_ids.reject(&attributes.method(:include?))
    custom_styles = custom_style_ids.map(&@style_container.method(:get_style))

    fg, bg, additional_attributes = pick_colors_and_additional_attributes(custom_styles)

    @stlye_attr_id_map[style_ids] = combine(fg, bg, attributes + additional_attributes)
  end

  def pick_colors_and_additional_attributes(custom_styles)
    fg = nil
    bg = nil
    attributes = []

    custom_styles.each do |style|
      fg = style.fg || fg
      bg = style.bg || bg
      attributes += style.attributes if style.attributes
    end

    [fg, bg, attributes]
  end

  def combine(fg, bg, attributes)
    init_color(fg) unless @color_id_map.include?(fg)
    init_color(bg) unless @color_id_map.include?(bg)

    pair_id = @id_sequnce += 1
    Curses.init_pair(pair_id, @color_id_map[fg] || -1, @color_id_map[bg] || -1)

    attr = attributes.reduce(0) do |result, built_in|
      result | Argyle::View::AttributeMap[built_in]
    end

    attr | Curses.color_pair(pair_id)
  end

  # @param color_id [Symbol]
  #
  def init_color(color_id)
    return if color_id.nil?

    color = @style_container.get_color(color_id)

    attr_id = @id_sequnce += 1

    Curses.init_color(
      attr_id,
      color.r / 0.255,
      color.g / 0.255,
      color.b / 0.255
    )

    @color_id_map[color_id] = attr_id
  end
end
