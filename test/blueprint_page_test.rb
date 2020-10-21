require 'test'

class BlueprintPageTest < Minitest::Test

  class TestPage1 < Argyle::Page::Base
    id(:test_1)
  end

  class TestPage2 < Argyle::Page::Base
    id(:test_2)
  end

  def test_set_page
    blueprint = Argyle::Blueprint.new
    blueprint.set_page(TestPage1)
    blueprint.set_page(TestPage2)

    pages = blueprint.pages
    assert_equal(2, pages.length)
    assert_equal([:test_1, :test_2], pages.keys)

    assert_equal(TestPage1, pages[:test_1].class)
    assert_equal(TestPage2, pages[:test_2].class)
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
    blueprint.set_page(TestPage1)
    blueprint.set_page(TestPage2)

    blueprint.render
  end
end
