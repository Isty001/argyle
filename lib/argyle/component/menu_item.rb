# @!attribute [r] title
#   @return [String]
#
class Argyle::Component::MenuItem
  attr_reader :title

  # @param title [String]
  # @param on [Hash{Symbol=>Proc]
  #
  def initialize(title:, on: {})
    @title = title
    @subscriptions = on
  end
end
