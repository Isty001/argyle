class Argyle::View::Style::Formatter
  GLOBAL_PATTERN = %r{(.*?)\[( {0,}style:.*?)\](.*?)(\[/style\])}.freeze
  STYLE_PATTERN = / {0,}style:(.*)/i.freeze

  CLOSING_TAG = '[/style]'.freeze

  private_constant :GLOBAL_PATTERN, :STYLE_PATTERN

  # @param raw [String]
  #
  # @return [Array<Argyle::View::Style::Text>]
  #
  def format(raw)
    current_style = []

    raw.scan(GLOBAL_PATTERN).flatten.map do |part|
      if part == CLOSING_TAG
        current_style = nil
        next
      end

      style = extract_styles(part)

      unless style.empty?
        current_style = style
        next
      end

      {current_style => part}
    end.reject(&:nil?)
  end

  private

  # @param part [String]
  #
  # @return [Array<Symbol>]
  #
  def extract_styles(part)
    style = part.match(STYLE_PATTERN).to_a.last&.strip.to_s

    return [] if style.empty?

    style.split(',').map { |s| s.strip.to_sym }
  end
end
