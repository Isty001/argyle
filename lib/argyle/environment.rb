# @!attribute [r] focused_component_id
#   @return [Symbol]
#
# @!attribute [r] current_page_id
#   @return [Symbol]
#
class Argyle::Environment
  attr_reader :focused_component_id, :current_page_id

  # @param blueprint [Argyle::Blueprint]
  #
  def initialize(blueprint)
    @blueprint = blueprint
  end

  # @param id [Symbol]
  #
  def focus(id)
    @blueprint.current_page.focus(id)
  end

  # @param id [Symbol]
  #
  def open_page(id)
    Argyle::Publisher.instance.publish(:page_open, id)
    Argyle::Publisher.instance.publish(:page_refresh)
  end
end
