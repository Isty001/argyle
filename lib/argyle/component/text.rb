class Argyle::Component::Text < Argyle::Component::Base
  attr_reader :value

  def initialize(area:, value:, style: nil)
    super(area: area, style: style)

    @value = value
  end
end
