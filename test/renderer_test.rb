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
    renderer = create_renderer(mock, [])

    layout = mock
    layout.expects(:windows).returns({test: mock})

    page = new_page(layout, {test: TestComponent.new})

    error = assert_raises(Argyle::Error::NotFound) do
      renderer.render(page)
    end

    assert_equal('View not found fo component RendererTest::TestComponent', error.message)
  end

  def test_no_window_for_area
    renderer = create_renderer(mock, [])
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
    keymap = mock

    view = mock
    TestView.expects(:new).with(container, keymap).returns(view)

    inputs = [10, 932]
    renderer = create_happy_renderer(inputs, container, keymap)

    windows = mock_windows

    layout = mock
    layout.expects(:windows).returns(windows)

    component = TestComponent.new

    ctx = Argyle::View::Context.new(inputs, true)
    Argyle::View::Context.expects(:new).with(inputs, true).returns(ctx)

    page = new_page(layout, {test: component})
    page.expects(:focused_component_id).returns(:test)

    view.expects(:render).with(windows[:test], component, ctx)

    renderer.render(page)
  end

  private

  def mock_windows
    window = mock
    window.expects(:touched?).returns(true)
    window.expects(:refresh)

    untouched_window = mock
    untouched_window.expects(:touched?).returns(false)

    {unused: untouched_window, test: window}
  end

  def create_renderer(inputs, container)
    reader = mock
    reader.expects(:read).returns(inputs)

    Argyle::Renderer.new(container, input_reader: reader)
  end

  def create_happy_renderer(inputs, container, keymap)
    reader = mock
    reader.expects(:read).returns(inputs)
    reader.expects(:flush)

    renderer = Argyle::Renderer.new(container, input_reader: reader, keymap: keymap)
    renderer.add_view(TestComponent, TestView)

    renderer
  end

  def new_page(layout, components)
    page = mock
    page.expects(:components).returns(components)
    page.expects(:layout).returns(layout)

    page
  end
end
