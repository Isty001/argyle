require_relative '../test'

class GlobalFocusChangeTest < MiniTest::Test
  def test_focus_next
    keymap = mock
    keymap.expects(:convert).with(["\t"], :global).yields(:focus_next)

    page = mock
    page.expects(:focused_component_id).times(2).returns(:form)
    page.expects(:components).returns({form: mock, menu: mock})
    page.expects(:focus).with(:menu)

    globals = Argyle::Input::Globals.new(keymap)
    globals.process(page, ["\t"])
  end

  def test_focus_next_rewind
    keymap = mock
    keymap.expects(:convert).with(["\t"], :global).yields(:focus_next)

    page = mock
    page.expects(:focused_component_id).times(2).returns(:text)
    page.expects(:components).returns({sidebar: mock, test: mock, text: mock})
    page.expects(:focus).with(:sidebar)

    globals = Argyle::Input::Globals.new(keymap)
    globals.process(page, ["\t"])
  end

  def test_focus_next_no_focused_component
    keymap = mock
    keymap.expects(:convert).with(["\t"], :global).yields(:focus_next)

    page = mock
    page.expects(:focused_component_id).returns(nil)

    globals = Argyle::Input::Globals.new(keymap)
    globals.process(page, ["\t"])
  end

  def test_focus_prev
    keymap = mock
    keymap.expects(:convert).with([Curses::KEY_BTAB], :global).yields(:focus_prev)

    page = mock
    page.expects(:focused_component_id).times(2).returns(:menu)
    page.expects(:components).returns({form: mock, menu: mock})
    page.expects(:focus).with(:form)

    globals = Argyle::Input::Globals.new(keymap)
    globals.process(page, [Curses::KEY_BTAB])
  end

  def test_focus_prev_rewind
    keymap = mock
    keymap.expects(:convert).with([Curses::KEY_BTAB], :global).yields(:focus_prev)

    page = mock
    page.expects(:focused_component_id).times(2).returns(:sidebar)
    page.expects(:components).returns({sidebar: mock, test: mock, text: mock})
    page.expects(:focus).with(:text)

    globals = Argyle::Input::Globals.new(keymap)
    globals.process(page, [Curses::KEY_BTAB])
  end

  def test_focus_prev_no_focused_component
    keymap = mock
    keymap.expects(:convert).with([Curses::KEY_BTAB], :global).yields(:focus_prev)

    page = mock
    page.expects(:focused_component_id).returns(nil)

    globals = Argyle::Input::Globals.new(keymap)
    globals.process(page, [Curses::KEY_BTAB])
  end
end
