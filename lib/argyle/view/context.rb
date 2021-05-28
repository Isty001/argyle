# @!attribute [r] inputs
#   @return [Array<Integer>]
#
class Argyle::View::Context
  attr_reader :inputs

  def initialize(inputs)
    @inputs = inputs
  end
end
