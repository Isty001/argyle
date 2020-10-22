require 'test'

class LayoutRegistryTest < Minitest::Test
  class TestLayout < Argyle::Layout::Base
    id(:test)
  end

  class TestLayoutNoId < Argyle::Layout::Base
  end

  def test_registry_happy_path
    original = TestLayout.new({}, {})
    clone = original.clone
    original.expects(:clone).returns(clone)

    registry = Argyle::Layout::Registry.new
    registry.add(original)

    assert_equal(clone, registry.clone(:test))
  end

  def test_registry_no_id
    registry = Argyle::Layout::Registry.new

    error = assert_raises(Argyle::Error::ArgumentError) do
      registry.add(TestLayoutNoId.new({}, {}))
    end

    assert_equal('Layout LayoutRegistryTest::TestLayoutNoId has no id', error.message)
  end

  def test_add_invalid_instance
    registry = Argyle::Layout::Registry.new

    error = assert_raises(Argyle::Error::TypeError) do
      registry.add(:symbol)
    end

    assert_equal("Layout must be an instance of #{Argyle::Layout::Base}", error.message)
  end

  def test_unknown_layout
    registry = Argyle::Layout::Registry.new

    error = assert_raises(Argyle::Error::NotFound) do
      registry.clone(:test)
    end

    assert_equal('Unknown layout: test', error.message)
  end
end
