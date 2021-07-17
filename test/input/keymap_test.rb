require_relative '../test'

class KeymapTest < Minitest::Test
  def test_unknown_namespace
    keymap = Argyle::Input::Keymap.new

    error = assert_raises(Argyle::Error::NotFound) do
      keymap.convert([], :test)
    end

    assert_equal('Unknown keymap namespace: test', error.message)
  end

  def test_no_mapping_for_key
    keymap = Argyle::Input::Keymap.new

    keymap.convert(['X'], :global) do |input|
      assert_nil(input)
    end
  end

  def test_happy_path
    keymap = Argyle::Input::Keymap.new

    inputs = []
    keymap.convert(["\t", Curses::KEY_BTAB], :global, &inputs.method(:<<))

    assert_equal(%i[focus_next focus_prev], inputs)
  end
end
