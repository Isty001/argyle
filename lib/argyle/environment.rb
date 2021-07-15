# @!attribute [r] focused_component_id
#   @return [Symbol]
#
# @!attribute [r] current_page_id
# @return [Symbol]
#
class Argyle::Environment
  attr_reader :focused_component_id, :current_page_id

  # @param publisher [Argyle::Publisher]
  #
  def initialize(publisher)
    @publisher = publisher
  end

  def focus(id)
    @publisher.publish(:component_focus, id)
  end

  def open_page(id)
    @publisher.publish(:page_open, id)
  end
end
