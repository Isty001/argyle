# @!attribute [r] data
#   @return [Hash{Symbol=>Array<String>}]
#
# Simple table with one header line and associated columns of data
#
class Argyle::Component::Table < Argyle::Component::Base
  attr_reader :data

  # @param data [Hash{Symbol=>Array<String>}]
  #
  def initialize(data, **args)
    @data = data
  end
end
