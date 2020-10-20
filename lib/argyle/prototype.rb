class Argyle::Prototype
  attr_reader :klass, :parameters

  def initialize(klass, parameters)
    @klass = klass
    @parameters = parameters
  end
end
