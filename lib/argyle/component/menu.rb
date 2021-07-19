# @!attribute [r] items
#   @return [Array<Argyle::Component::MenuItem>]
#
# @!attribute [r] cols
#   @return [Integer]
#
# @!attribute [r] rows
#   @return [Integer]
#
# @!attribute [r] menu
#   @return [Curses::Menu, nil]
#
# @!attribute [r] window
#   @return [Curses::Window, nil]
#
class Argyle::Component::Menu < Argyle::Component::Base
  attr_reader :items, :cols, :rows, :menu

  # @param items [Array<Argyle::Prototype>]
  # @param cols [Integer]
  # @param rows [Integer]
  #
  def initialize(items:, cols: nil, rows: nil, **args)
    super(**args)

    @items = items.map(&:unwrap)
    @cols = cols
    @rows = rows

    @menu = nil
    @window = nil
  end

  # @param window [Curses::Window]
  # @param menu [Curses::Menu]
  #
  def update(window, menu)
    super(window)

    @menu = menu
  end

  def clear
    if @menu
      @menu.unpost
      @menu = nil
    end

    # Deleting the Window before unpost causes segfault
    super
  end
end
