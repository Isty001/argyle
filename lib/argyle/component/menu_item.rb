# @!attribute [r] title
#   @return [String]
#
# @!attribute [r] actions
#   @return [Hash{Symbol=>Proc}]
#
class Argyle::Component::MenuItem
  attr_reader :title, :actions

  # @param title [String]
  # @param selectable [Boolean]
  # @param on [Hash{Symbol=>Proc] List of actions
  #
  def initialize(title:, selectable: true, on: {})
    @title = title
    @selectable = selectable
    @actions = on
  end

  def selectable?
    @selectable
  end
end
