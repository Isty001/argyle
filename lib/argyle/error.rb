module Argyle::Error
  class ArgumentError < ArgumentError
  end

  class TypeError < TypeError
  end

  class RuntimeError < RuntimeError
  end

  class NotFound < RuntimeError
  end

  class NoMethodError < NoMethodError
  end
end
