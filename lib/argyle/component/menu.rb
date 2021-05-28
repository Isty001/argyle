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
  attr_reader :items, :cols, :rows, :menu, :window

  # @param items [Array<Argyle::Prototype>]
  # @param cols [Integer]
  # @param rows [Integer]
  #
  def initialize(items:, cols: nil, rows: nil, **args)
    super(**args)

    @items = items.map(&:unwrap)
    @cols = cols
    @rows = rows
    # @controls = controls

    @menu = nil
    @window = nil
  end

  # @param menu [Curses::Menu]
  # @param window [Curses::Window]
  #
  def fire_up(menu, window)
    @menu = menu
    @window = window
  end

  # @return [Boolean]
  #
  def fired_up?
    @window.nil? == false
  end

  def subscriptions
    super.merge(
      {
        exit: :cleanup
      }
    )
  end

  private

  def cleanup(_params)
    return unless fired_up?

    @menu.unpost
    @window.close
    @window = nil
  end
end
