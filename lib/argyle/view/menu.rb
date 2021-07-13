class Argyle::View::Menu < Argyle::View::Base
  # @param window [Curses::Window]
  # @param component [Argyle::Component::Menu]
  # @param ctx [Argyle::Component::Context]
  #
  def render(window, component, ctx)
    fire_up(window, component) unless component.fired_up?

    control(component, ctx)
  end

  private

  # @param window [Curses::Window]
  # @param component [Argyle::Component::Menu]
  #
  def fire_up(window, component)
    x, y, width, height = component_gemoetry(window, component)
    menu_window = window.subwin(height, width, y, x)

    items = component.items.map do |item|
      Curses::Item.new(item.title, '')
    end

    menu = create_menu(items, menu_window, component)
    menu_window.refresh

    component.fire_up(menu, menu_window)
  end

  # @param items [Array<Curses::Item>]
  # @param menu_window [Curses::Window]
  # @param component [Argyle::Component::Menu]
  #
  def create_menu(items, menu_window, component)
    menu = Curses::Menu.new(items)
    menu.set_win(menu_window)
    menu.set_format(component.rows.to_i, component.cols.to_i)
    menu.post
  end

  # @param component [Argyle::Component::Menu]
  # @param ctx [Argyle::View::Context]
  #
  def control(component, ctx)
    @keymap.convert(ctx.inputs, component) do |input|
      case input
      when :up
        component.menu.driver(Curses::REQ_UP_ITEM)
      when :down
        component.menu.driver(Curses::REQ_DOWN_ITEM)
      end
      rescue Curses::RequestDeniedError
    end

    component.window.refresh
  end
end
