class Argyle::Input::Reader
  # @yieldparam [Integer] input
  #
  def read
    queue = []

    while (input = Curses.get_char)
      queue.push(input)
    end

    queue.freeze
  end
end
