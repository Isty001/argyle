class Argyle::App

  # @yield This is where the interface elements must be built
  #
  # @example
  #   app.construct do
  #     window(...)
  #     form(...)
  #   end
  #
  # @see Argyle::Architect
  def construct
  end

  def interact
  end

  def changed?
  end

  def close
  end
end
