class Argyle::Environment
  # @param publisher [Argyle::Publisher]
  #
  def initialize(publisher)
    @publisher = publisher
  end

  # @param id [Symbol] Id of the Page
  #
  def open_page(id)
    @publisher.publish(:open_page, {id: id})
  end
end
