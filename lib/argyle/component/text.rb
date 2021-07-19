# @!attribute [r] value
#   @return [String]
#
class Argyle::Component::Text < Argyle::Component::Base
  attr_reader :value

  def initialize(value:, **args)
    super(**args)

    @value = value
  end
end
