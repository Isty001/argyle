require 'test'

class RendererTest < Minitest::Test

  class TestComponent < Argyle::Component::Base
    def initialize
      super(area: :test)
    end
  end

  class TestView < Argyle::View::Base
  end

  def test_set_view_invalid_component
    renderer = Argyle::Renderer.new

    error = assert_raises(Argyle::Error::TypeError) do
      renderer.set_view(String, TestView.new)
    end

    assert_equal("Expected subclass of #{Argyle::Component::Base.name}, String given", error.message)
  end

  def test_set_view_invalid_view
    renderer = Argyle::Renderer.new

    error = assert_raises(Argyle::Error::TypeError) do
      renderer.set_view(TestComponent, 'some string')
    end

    assert_equal("View must be an instance of #{Argyle::View::Base.name}", error.message)
  end

  def test_no_view_for_component
    renderer = Argyle::Renderer.new

    layout = mock
    layout.expects(:windows).returns({test: mock})

    page = mock
    page.expects(:components).returns({test: TestComponent.new})
    page.expects(:layout).returns(layout)

    error = assert_raises(Argyle::Error::NotFound) do
      renderer.render(page)
    end

    assert_equal('View not found fo component RendererTest::TestComponent', error.message)
  end

  def test_no_window_for_area
    renderer = Argyle::Renderer.new
    renderer.set_view(TestComponent, TestView.new)

    layout = mock
    layout.expects(:windows).returns({})

    page = mock
    page.expects(:components).returns({test: TestComponent.new})
    page.expects(:layout).returns(layout)

    error = assert_raises(Argyle::Error::NotFound) do
      renderer.render(page)
    end

    assert_equal('Window not found for area: test', error.message)
  end

  def test_happy_path
    view = TestView.new

    renderer = Argyle::Renderer.new
    renderer.set_view(TestComponent, view)

    window = mock
    window.expects(:refresh)

    layout = mock
    layout.expects(:windows).returns({test: window})

    component = TestComponent.new

    page = mock
    page.expects(:components).returns({test: component})
    page.expects(:layout).returns(layout)

    view.expects(:render).with(window, component)

    renderer.render(page)
  end
end
