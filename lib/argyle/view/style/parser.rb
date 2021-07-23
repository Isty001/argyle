class Argyle::View::Style::Parser
  STYLE_PATTERN_TEMPLATE = '({(?:(?:%style_ids%)(?:,?)){0,}(?::(?:.*?))})'.freeze
  GLOBAL_PATTERN_TEMPLATE = "(.*?)#{STYLE_PATTERN_TEMPLATE}|(.*)".freeze

  private_constant :GLOBAL_PATTERN_TEMPLATE, :STYLE_PATTERN_TEMPLATE

  # @param container [Argyle::StyleSheet::Container]
  #
  def initialize(container)
    ids = container.style_ids.map(&Regexp.method(:quote)).join('|')

    @style_pattern = /#{STYLE_PATTERN_TEMPLATE.gsub('%style_ids%', ids)}/
    @global_pattern = /#{GLOBAL_PATTERN_TEMPLATE.gsub('%style_ids%', ids)}/
  end

  # @param raw [String]
  #
  # @return [Array<Argyle::View::Style::Text>]
  #
  def parse(raw)
    match(raw, @global_pattern).reduce(Argyle::View::Style::Text.new) do |text, part|
      style = []

      style, part = extract(part) unless match(part, @style_pattern).empty?

      text.append(part, style)
    end
  end

  private

  def match(raw, pattern)
    raw.scan(pattern).flatten.reject { |p| p.nil? || p.empty? }
  end

  # @param raw [String]
  #
  # @return [Hash]
  #
  def extract(raw)
    style, text = raw.delete_prefix('{').delete_suffix('}').split(':')
    style = style.split(',').map(&:to_sym)

    [style, text]
  end
end
