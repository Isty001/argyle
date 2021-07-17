require_relative 'test'

class BlueprintPageTest < Minitest::Test
  class TestPage1 < Argyle::Page::Base
  end

  class TestPage2 < Argyle::Page::Base
  end

  def test_add_page
    blueprint = Argyle::Blueprint.new
    blueprint.add_page(:test1, TestPage1)
    blueprint.add_page(:test2, TestPage2)

    pages = blueprint.pages
    assert_equal(2, pages.length)
    assert_equal(%i[test1 test2], pages.keys)

    assert_equal(TestPage1, pages[:test1].class)
    assert_equal(TestPage2, pages[:test2].class)
  end

  def test_add_page_no_id
    blueprint = Argyle::Blueprint.new

    error = assert_raises(Argyle::Error::ArgumentError) do
      blueprint.add_page(nil, TestPage2)
    end

    assert_equal('No id given for page: BlueprintPageTest::TestPage2', error.message)
  end

  def test_no_current_page
    blueprint = Argyle::Blueprint.new

    Argyle.expects(:activate)

    error = assert_raises(Argyle::Error::NotFound) do
      blueprint.render
    end

    assert_equal('No pages defined yet', error.message)
  end

  def test_first_page_as_current
    renderer = mock
    renderer.expects(:render).with do |page|
      page.is_a?(TestPage1)
    end

    renderer.expects(:add_view).times(2)

    Argyle.expects(:activate)

    blueprint = Argyle::Blueprint.new(renderer: renderer)
    blueprint.add_page(:test1, TestPage1)
    blueprint.add_page(:test2, TestPage2)

    blueprint.render
  end
end
