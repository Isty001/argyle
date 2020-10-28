require 'test'

class BlueprintPageTest < Minitest::Test
  class TestPage1 < Argyle::Page::Base
  end

  class TestPage2 < Argyle::Page::Base
  end

  def test_add_page
    blueprint = Argyle::Blueprint.new
    blueprint.add_page(:test_1, TestPage1)
    blueprint.add_page(:test_2, TestPage2)

    pages = blueprint.pages
    assert_equal(2, pages.length)
    assert_equal(%i[test_1 test_2], pages.keys)

    assert_equal(TestPage1, pages[:test_1].class)
    assert_equal(TestPage2, pages[:test_2].class)
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

    blueprint = Argyle::Blueprint.new(renderer: renderer)
    blueprint.add_page(:test_1, TestPage1)
    blueprint.add_page(:test_2, TestPage2)

    blueprint.render
  end
end
