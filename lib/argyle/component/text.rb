class Argyle::Component::Text < Argyle::Component::Base
  attr_reader :value

  def initialize(area:, value:)
    super(area: area)

    @value = value
  end
end
