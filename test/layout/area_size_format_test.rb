require 'test'

class AreaSizeFormatTest < Minitest::Test
  def test_valid_format
    area = Argyle::Layout::Area.new(width: '10%', height: '45%')

    assert_equal(10, area.relative_width)
    assert_equal(45, area.relative_height)
  end

  def test_invalid_width_format
    error = assert_raises(Argyle::Error::ArgumentError) do
      Argyle::Layout::Area.new(width: 10, height: '66%')
    end

    assert_equal('Invalid size format: 10', error.message)
  end

  def test_invalid_height_format
    error = assert_raises(Argyle::Error::ArgumentError) do
      Argyle::Layout::Area.new(width: '10%', height: 'hello')
    end

    assert_equal('Invalid size format: hello', error.message)
  end
end
