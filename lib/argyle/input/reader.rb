class Argyle::Input::Reader
  # @return [Array<Integer>]
  #
  def read
    queue = []

    while (input = Curses.get_char)
      queue.push(input)
    end

    queue
  end

  def flush
    Curses.flushinp
  end
end
