require 'test'

class PageFactorytest < Minitest::Test
  class NicePage < Argyle::Page::Base
    layout(:main)

    text(:title, 'Hello')
    text(:header, 'Test')
  end

  class NoLayoutPage < Argyle::Page::Base
  end

  def test_happy_path
    layout = Argyle::Layout::Base.new({})

    registry = mock
    registry.expects(:clone).with(:main).returns(layout)

    factory = Argyle::Page::Factory.new(registry)
    page = factory.create(NicePage)

    assert_equal(2, page.components.length)

    title = page.components[:title]
    assert_equal("Hello", title.value)

    header = page.components[:header]
    assert_equal("Test", header.value)

    assert_equal(layout, page.layout)
  end

  def test_default_layout
    layout = Argyle::Layout::Base.new({})

    registry = mock
    registry.expects(:clone).with(:default).returns(layout)

    factory = Argyle::Page::Factory.new(registry)
    page = factory.create(NoLayoutPage)

    assert_equal(0, page.components.length)
    assert_equal(layout, page.layout)
  end

  def test_invalid_instance
    factory = Argyle::Page::Factory.new(mock)

    error = assert_raises(Argyle::Error::TypeError) do
      factory.create("asd")
    end

    assert_equal(error.message, "Expected subclass of #{Argyle::Page::Base.name}, String given")
  end

  def test_invalid_class
    factory = Argyle::Page::Factory.new(mock)

    error = assert_raises(Argyle::Error::TypeError) do
      factory.create(Symbol)
    end

    assert_equal(error.message, "Expected subclass of #{Argyle::Page::Base.name}, Symbol given")
  end
end
