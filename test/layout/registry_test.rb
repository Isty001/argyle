require 'test'

class LayoutRegistryTest < Minitest::Test

  def test_happy_path
    original = Argyle::Layout.new
    clone = original.clone
    original.expects(:clone).returns(clone)

    registry = Argyle::Layout::Registry.new
    registry.set(:test, original)

    assert_equal(clone, registry.clone(:test))
  end

  def test_add_invalid_instance
    registry = Argyle::Layout::Registry.new

    error = assert_raises(Argyle::Error::TypeError) do
      registry.set(:test_2, :symbol)
    end

    assert_equal("Layout must be an instance of #{Argyle::Layout}", error.message)
  end

  def test_unknown_layout
    registry = Argyle::Layout::Registry.new

    error = assert_raises(Argyle::Error::NotFound) do
      registry.clone(:test)
    end

    assert_equal("Unknown layout: test", error.message)
  end
end
