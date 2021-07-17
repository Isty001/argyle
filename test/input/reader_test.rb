require_relative '../test'

class ReaderTest < Minitest::Test
  def test_reader
    Curses.expects(:get_char).times(4).returns('q'.ord, Curses::KEY_UP, 'd'.ord, nil)

    reader = Argyle::Input::Reader.new

    assert_equal(['q'.ord, Curses::KEY_UP, 'd'.ord], reader.read)
  end
end
