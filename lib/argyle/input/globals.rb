class Argyle::Input::Globals
  # @param keymap [Argyle::Input::Keymap]
  #
  def initialize(keymap)
    @keymap = keymap
  end

  # @param page [Argyle::Page::Base]
  # @param inputs [Array<Integer>]
  #
  def process(page, inputs)
    @keymap.convert(inputs, :global) do |input|
      send(input, page)
    end
  end

  private

  # @param page [Argyle::Page::Base]
  #
  def focus_next(page)
    return unless page.focused_component_id

    ids = page.components.keys
    index = ids.index(page.focused_component_id) + 1
    index = 0 if index == ids.length

    page.focus(ids[index])
  end

  # @param page [Argyle::Page::Base]
  #
  def focus_prev(page)
    return unless page.focused_component_id

    ids = page.components.keys
    index = ids.index(page.focused_component_id) - 1

    page.focus(ids[index])
  end
end
