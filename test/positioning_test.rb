require 'test'

class PositioningTest < Minitest::Test
  def test_valid_realtive_size_format
    assert_equal(10, Argyle::Positioning.parse_relative_size('10%'))
    assert_equal(45, Argyle::Positioning.parse_relative_size('45%'))
  end

  def test_invalid_relative_size_format
    error = assert_raises(Argyle::Error::ArgumentError) do
      Argyle::Positioning.parse_relative_size(10)
    end

    assert_equal('Invalid size format: 10', error.message)
  end

  def test_out_of_range_relative_size
    assert_equal(100, Argyle::Positioning.parse_relative_size('102313%'))
    assert_equal(1, Argyle::Positioning.parse_relative_size('-10%'))
  end

  def test_convert_ralative_size
    assert_equal(10, Argyle::Positioning.convert_relative_size(10, 100))
    assert_equal((356 * 0.33).ceil, Argyle::Positioning.convert_relative_size(33, 356))
    assert_equal(92, Argyle::Positioning.convert_relative_size(100, 92))
    assert_equal((111 * 0.01).ceil, Argyle::Positioning.convert_relative_size(1, 111))
  end

  def test_float_coordinates
    assert_equal([0, 0], Argyle::Positioning.float_to_coordinates(%i[top left], 10, 20, 100, 350))
    assert_equal([90, 330], Argyle::Positioning.float_to_coordinates(%i[right bottom], 10, 20, 100, 350))
    assert_equal([51, 187], Argyle::Positioning.float_to_coordinates(%i[center], 30, 66, 133, 440))
  end

  def test_offset
    assert_equal([10, 20], Argyle::Positioning.apply_offsets(10, 10, 100, 100, {top: 10}))
    assert_equal([10, 5], Argyle::Positioning.apply_offsets(10, 10, 100, 100, {bottom: 5}))
    assert_equal([20, 10], Argyle::Positioning.apply_offsets(10, 10, 100, 100, {left: 10}))
    assert_equal([5, 10], Argyle::Positioning.apply_offsets(10, 10, 100, 100, {right: 5}))
  end

  def test_out_of_range_offset
    assert_equal([10, 100], Argyle::Positioning.apply_offsets(10, 10, 100, 100, {top: 100}))
    assert_equal([10, 0], Argyle::Positioning.apply_offsets(10, 10, 100, 100, {bottom: 5000}))
    assert_equal([400, 10], Argyle::Positioning.apply_offsets(10, 10, 400, 100, {left: 300}))
    assert_equal([0, 10], Argyle::Positioning.apply_offsets(10, 10, 200, 100, {right: 100}))
  end
end
