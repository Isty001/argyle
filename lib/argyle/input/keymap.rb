class Argyle::Input::Keymap
  def initialize
    @map = {
      global: {
        "\t" => :focus_next,
        Curses::KEY_BTAB => :focus_prev # shitf + tab
      },
      Argyle::Component::Menu => {
        Curses::KEY_UP => :up,
        Curses::KEY_DOWN => :down,
        Curses::KEY_RIGHT => :right,
        Curses::KEY_LEFT => :left
      }
    }
  end

  # @param inputs [Array<Integer>]
  # @param namespace
  #
  # @raise [Argyle::Error::NotFound] On unknown keymap namespace
  #
  def convert(inputs, namespace)
    raise Argyle::Error::NotFound.new("Unknown keymap namespace: #{namespace}") unless @map.include?(namespace)

    inputs.map do |raw|
      yield @map[namespace][raw] if @map[namespace].include?(raw)
    end
  end
end
