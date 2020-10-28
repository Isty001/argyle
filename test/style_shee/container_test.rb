require 'test'

class StyleContainerTest < Minitest::Test
  class TestSheet < Argyle::StyleSheet::Base
    color(:red, r: 255, g: 0, b: 0)
    color(:blue, r: 0, g: 0, b: 255)

    style(:error, fg: :blue, bg: :red, attributes: [:bold])
  end

  class UnknownColorSheet < Argyle::StyleSheet::Base
    style(:error, fg: :magenta)
  end

  class UnknownAttributeSheet < Argyle::StyleSheet::Base
    style(:title, attributes: [:test_attr])
  end

  def test_unknown_attribute
    container = Argyle::StyleSheet::Container.new

    error = assert_raises(Argyle::Error::NotFound) do
      container.add(UnknownAttributeSheet)
    end

    assert_equal('Attribute test_attr not found for style: title', error.message)
  end

  def test_unknown_color
    container = Argyle::StyleSheet::Container.new

    error = assert_raises(Argyle::Error::NotFound) do
      container.add(UnknownColorSheet)
    end

    assert_equal('Color magenta not found for style: error', error.message)
  end

  def test_happy_path
    container = Argyle::StyleSheet::Container.new
    container.add(TestSheet)

    red = container.get_color(:red)
    assert_instance_of(Argyle::StyleSheet::Color, red)

    blue = container.get_color(:blue)
    assert_instance_of(Argyle::StyleSheet::Color, blue)

    color_not_found = assert_raises(Argyle::Error::NotFound) do
      container.get_color(:green)
    end
    assert_equal('Color not found: green', color_not_found.message)

    assert_error_style(container.get_style(:error))

    style_not_found = assert_raises(Argyle::Error::NotFound) do
      container.get_style(:success)
    end
    assert_equal('Style not found: success', style_not_found.message)
  end

  private

  def assert_error_style(error)
    assert_instance_of(Argyle::StyleSheet::Style, error)

    assert_equal(:red, error.bg)
    assert_equal(:blue, error.fg)
    assert_equal([:bold], error.attributes)
  end
end
