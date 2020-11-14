require 'test'

class LayoutFactoryTest < Minitest::Test
  class TestLayout < Argyle::Layout::Base
    area(id: :header)
    area(id: :footer)
  end

  class TestSizeLayout < Argyle::Layout::Base
    area(
      id: :custom_sizes,
      height: '57%',
      width: '33%'
    )

    area(id: :default_sizes)
  end

  class TestFloatLayout < Argyle::Layout::Base
    area(id: :top_left, float: %i[left top])
    area(id: :bottom_right, float: %i[right bottom])
    area(id: :center, float: %i[center])
  end

  class TestOffsetLayout < Argyle::Layout::Base
    area(id: :test, offset: {top: '30%', left: '55%'})
  end

  def test_happy_path
    factory = Argyle::Layout::Factory.new

    layout = factory.create(TestLayout)

    assert_equal(3, layout.areas.length)

    main = layout.areas[Argyle::Layout::Base::DEFAULT_AREA]
    assert_instance_of(Argyle::Layout::Area, main)

    main_window = layout.windows[Argyle::Layout::Base::DEFAULT_AREA]
    assert_instance_of(Ncurses::WINDOW, main_window)

    header = layout.areas[:header]
    assert_instance_of(Argyle::Layout::Area, header)

    header_window = layout.windows[:header]
    assert_instance_of(Ncurses::WINDOW, header_window)

    footer = layout.areas[:footer]
    assert_instance_of(Argyle::Layout::Area, footer)

    footer_window = layout.windows[:footer]
    assert_instance_of(Ncurses::WINDOW, footer_window)
  end

  def test_sizes
    factory = Argyle::Layout::Factory.new

    max_height = Ncurses.getmaxy(Ncurses.stdscr)
    max_width = Ncurses.getmaxx(Ncurses.stdscr)

    layout = factory.create(TestSizeLayout)

    custom = layout.windows[:custom_sizes]
    assert_equal((max_height * 0.57).ceil, custom.getmaxy)
    assert_equal((max_width * 0.33).ceil, custom.getmaxx)

    default = layout.windows[:default_sizes]
    assert_equal(max_height, default.getmaxy)
    assert_equal(max_width, default.getmaxx)
  end

  def test_float
    factory = Argyle::Layout::Factory.new

    max_height = Ncurses.getmaxy(Ncurses.stdscr)
    max_width = Ncurses.getmaxx(Ncurses.stdscr)

    layout = factory.create(TestFloatLayout)

    center = layout.windows[:center]
    assert_equal((max_height - center.getmaxy) / 2, center.getbegy)
    assert_equal((max_width - center.getmaxx) / 2, center.getbegx)

    top_left = layout.windows[:top_left]
    assert_equal(0, center.getbegy)
    assert_equal(center.getmaxx - top_left.getmaxx, center.getbegx)

    top_left = layout.windows[:bottom_right]
    assert_equal(center.getmaxy - top_left.getmaxy, center.getbegy)
    assert_equal(0, center.getbegx)
  end

  def test_offset
    factory = Argyle::Layout::Factory.new

    max_height = Ncurses.getmaxy(Ncurses.stdscr)
    max_width = Ncurses.getmaxx(Ncurses.stdscr)

    layout = factory.create(TestOffsetLayout)

    window = layout.windows[:test]
    assert_equal((max_height * 0.30).ceil, window.getbegy)
    assert_equal((max_width * 0.55).ceil, window.getbegx)
  end

  def test_invalid_instance
    factory = Argyle::Layout::Factory.new

    error = assert_raises(Argyle::Error::TypeError) do
      factory.create(19)
    end

    assert_equal(error.message, "Expected subclass of #{Argyle::Layout::Base.name}, Integer given")
  end

  def test_invalid_class
    factory = Argyle::Layout::Factory.new

    error = assert_raises(Argyle::Error::TypeError) do
      factory.create(Float)
    end

    assert_equal(error.message, "Expected subclass of #{Argyle::Layout::Base.name}, Float given")
  end
end
