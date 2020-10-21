class Argyle::Component::Base

  attr_reader :area

  # @param area [Symbol]
  #
  def initialize(area:)
    @area = area.to_sym
  end
end
