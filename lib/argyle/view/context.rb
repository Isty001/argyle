# @!attribute [r] inputs
#   @return [Array<Integer>]
#
# @!attribute [r] focused
#   @return [Boolean]
#
class Argyle::View::Context
  attr_reader :inputs

  def initialize(inputs, focused)
    @inputs = inputs
    @focused = focused
  end

  def focused?
    @focused
  end
end
