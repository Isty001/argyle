class Argyle::Component::Text
  attr_reader :value, :area

  def initialize(value:, area:)
    @value = value
    @area = area
  end
end
