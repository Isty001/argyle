class Argyle::View::AttributeMap
  MAP = {
    bold: Ncurses::A_BOLD,
    standou: Ncurses::A_STANDOUT,
    underline: Ncurses::A_UNDERLINE,
    reverse: Ncurses::A_REVERSE,
    blink: Ncurses::A_BLINK,
    dim: Ncurses::A_DIM
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
