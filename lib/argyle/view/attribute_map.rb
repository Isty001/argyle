class Argyle::View::AttributeMap
  MAP = {
    bold: Curses::A_BOLD,
    standou: Curses::A_STANDOUT,
    underline: Curses::A_UNDERLINE,
    reverse: Curses::A_REVERSE,
    blink: Curses::A_BLINK,
    dim: Curses::A_DIM
  }.freeze
  private_constant :MAP

  class << self
    def [](id)
      MAP[id] or raise Argyle::Error::NotFound.new("Attribute not found: #{id}")
    end

    def include?(id)
      MAP.include?(id)
    end
  end
end
