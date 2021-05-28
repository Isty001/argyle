require 'test'

class RendererTest < Minitest::Test
  class TestComponent < Argyle::Component::Base
    def initialize
      super(area: :test)
    end
  end

  class TestView < Argyle::View::Base
  end

  def test_add_view_invalid_component
    renderer = Argyle::Renderer.new(mock)

    error = assert_raises(Argyle::Error::TypeError) do
      renderer.add_view(String, TestView)
    end

    assert_equal("Expected subclass of #{Argyle::Component::Base.name}, String given", error.message)
  end

  def test_add_view_invalid_view
    renderer = Argyle::Renderer.new(mock)

    error = assert_raises(Argyle::Error::TypeError) do
      renderer.add_view(TestComponent, 'some string')
    end

    assert_equal("Expected subclass of #{Argyle::View::Base}, String given", error.message)
  end

  def test_no_view_for_component
    renderer = Argyle::Renderer.new(mock)

    layout = mock
    layout.expects(:windows).returns({test: mock})

    page = new_page(layout, {test: TestComponent.new})

    error = assert_raises(Argyle::Error::NotFound) do
      renderer.render(page)
    end

    assert_equal('View not found fo component RendererTest::TestComponent', error.message)
  end

  def test_no_window_for_area
    renderer = Argyle::Renderer.new(mock)
    renderer.add_view(TestComponent, TestView)

    layout = mock
    layout.expects(:windows).returns({})

    page = new_page(layout, {test: TestComponent.new})

    error = assert_raises(Argyle::Error::NotFound) do
      renderer.render(page)
    end

    assert_equal('Window not found for area: test. Is the area defined in the layout?', error.message)
  end

  def test_happy_path
    container = mock

    view = mock
    TestView.expects(:new).with(container).returns(view)

    inputs = [10, 932]
    reader = mock
    reader.expects(:read).returns(input)

    renderer = Argyle::Renderer.new(container, input_reader: reader)
    renderer.add_view(TestComponent, TestView)

    window = mock
    window.expects(:refresh)

    layout = mock
    layout.expects(:windows).returns({test: window})

    component = TestComponent.new

    ctx = Argyle::View::Context.new(inputs)
    Argyle::View::Context.expects(:new).with(inputs).returns(ctx)

    page = new_page(layout, {test: component})
    view.expects(:render).with(window, component, ctx)

    renderer.render(page)
  end

  private

  def new_page(layout, components)
    page = mock
    page.expects(:components).returns(components)
    page.expects(:layout).returns(layout)

    page
  end
end
