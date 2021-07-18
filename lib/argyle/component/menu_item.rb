# @!attribute [r] title
#   @return [String]
#
# @!attribute [r] actions
#   @return [Hash{Symbol=>Proc}]
#
class Argyle::Component::MenuItem
  attr_reader :title, :actions

  # @param title [String]
  # @param on [Hash{Symbol=>Proc] List of actions
  #
  def initialize(title:, on: {})
    @title = title
    @actions = on
  end
end
