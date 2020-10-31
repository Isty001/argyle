require 'test'

class BluePrintLayoutTest < MiniTest::Test
  class TestLayout < Argyle::Layout::Base
  end

  def test_add_default_and_custom_layout
    instance_default = mock
    instance_test = mock

    factory = mock
    factory.expects(:create).with(Argyle::Layout::Default).returns(instance_default)
    factory.expects(:create).with(TestLayout).returns(instance_test)

    registry = mock
    registry.expects(:add).with(:default, instance_default)
    registry.expects(:add).with(:test_id, instance_test)

    blueprint = Argyle::Blueprint.new(layout_factory: factory, layout_registry: registry)
    blueprint.add_layout(:test_id, TestLayout)
  end
end
