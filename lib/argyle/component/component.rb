module Argyle::Component end

require_relative 'base.rb'

Dir[File.join(__dir__, '*.rb')].each { |file| require file unless __FILE__ == file }
