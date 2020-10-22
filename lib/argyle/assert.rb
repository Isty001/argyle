class Argyle::Assert
  class << self
    def klass(expected, actual)
      return if actual.respond_to?(:superclass) && expected == actual.superclass

      actual_name = actual.respond_to?(:name) ? actual.name : actual.class

      raise Argyle::Error::TypeError.new("Expected subclass of #{expected.name}, #{actual_name} given")
    end
  end
end
