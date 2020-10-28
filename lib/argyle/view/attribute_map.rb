class Argyle::View::AttributeMap
  MAP = {
    bold: Ncurses::A_BOLD
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
