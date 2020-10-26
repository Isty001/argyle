class Argyle::Prototype
  attr_reader :klass, :parameters

  def initialize(klass, parameters)
    @klass = klass
    @parameters = parameters
  end

  def unwrap
    klass.new(**parameters)
  end
end
