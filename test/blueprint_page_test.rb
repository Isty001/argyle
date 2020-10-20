require 'test'

class BlueprintPageTest < Minitest::Test

  class TestPage1 < Argyle::Page
  end

  class TestPage2 < Argyle::Page
  end

  def test_add_page
    blueprint = Argyle::Blueprint.new
    blueprint.add_page(:test_1, TestPage1)
    blueprint.add_page(:test_2, TestPage2)

    pages = blueprint.pages
    assert_equal(2, pages.length)
    assert_equal([:test_1, :test_2], pages.keys)

    assert_equal(TestPage1, pages[:test_1].class)
    assert_equal(TestPage2, pages[:test_2].class)
  end

  def test_existing_id
    blueprint = Argyle::Blueprint.new
    blueprint.add_page(:test_1, TestPage1)

    error = assert_raises(Argyle::Error::ArgumentError) do
      blueprint.add_page(:test_1, TestPage2)
    end

    assert_equal(error.message, 'Page test_1 already exists')
  end

  def test_no_current_page
    blueprint = Argyle::Blueprint.new

    error = assert_raises(Argyle::Error::RuntimeError) do
      blueprint.current_page
    end

    assert_equal('No pages defined yet', error.message)
  end

  def test_first_page_as_current
    blueprint = Argyle::Blueprint.new
    blueprint.add_page(:test_1, TestPage1)
    blueprint.add_page(:test_2, TestPage2)

    assert_instance_of(TestPage1, blueprint.current_page)
  end

  def test_set_unknown_current_page
    blueprint = Argyle::Blueprint.new

    error = assert_raises(Argyle::Error::NotFound) do
      blueprint.current_page = :test
    end

    assert_equal("Unknown page: test", error.message)
  end

  def test_set_current_page
    blueprint = Argyle::Blueprint.new
    blueprint.add_page(:first, TestPage1)
    blueprint.add_page(:second, TestPage2)

    blueprint.current_page = :second

    assert_instance_of(TestPage2, blueprint.current_page)
  end
end
