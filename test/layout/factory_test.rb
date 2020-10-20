require 'test'

class LayoutRegistryTest < Minitest::Test

  class TestLayout < Argyle::Layout
    area(:header)
    area(:footer)
  end

  def test_happy_path
    factory = Argyle::Layout::Factory.new

    layout = factory.create(TestLayout)

    assert_equal(3, layout.areas.length)

    main = layout.areas[:main]
    assert_instance_of(Argyle::Layout::Area, main)

    header = layout.areas[:header]
    assert_instance_of(Argyle::Layout::Area, header)

    footer = layout.areas[:footer]
    assert_instance_of(Argyle::Layout::Area, footer)
  end

  def test_invalid_instance
    factory = Argyle::Layout::Factory.new

    error = assert_raises(Argyle::Error::TypeError) do
      factory.create(19)
    end

    assert_equal(error.message, "Expected subclass of #{Argyle::Layout.name}, Integer given")
  end

  def test_invalid_class
    factory = Argyle::Layout::Factory.new

    error = assert_raises(Argyle::Error::TypeError) do
      factory.create(Float)
    end

    assert_equal(error.message, "Expected subclass of #{Argyle::Layout.name}, Float given")
  end
end
