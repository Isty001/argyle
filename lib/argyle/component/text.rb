# @!attribute [r] value
#   @return [String]
#
# This component represent a simple text positioned inside an Area
#
class Argyle::Component::Text < Argyle::Component::Base
  attr_reader :value

  def initialize(value:, **args)
    super(**args)

    @value = value
  end
end
