class Argyle::Input::Keymap
  def initialize
    @map = {
      global: {
      },
      Argyle::Component::Menu => {
        Curses::KEY_UP => :up,
        Curses::KEY_DOWN => :down,
        Curses::KEY_RIGHT => :right,
        Curses::KEY_LEFT => :left,
        Curses::KEY_MOUSE => :mouse
      }
    }
  end

  # @param inputs [Array<Integer>]
  # @param component [Argyle::Component::Base]
  #
  def convert(inputs, component)
    return unless component.in_focus?

    namespace = component.class

    raise ArgumentError.new("No keymapping for #{namespace}") unless @map.include?(namespace)

    inputs.map do |raw|
      yield @map[namespace][raw] if @map[namespace].include?(raw)
    end
  end
end
