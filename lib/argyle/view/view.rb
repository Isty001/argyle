module Argyle::View end

require_relative 'base.rb'

Dir[File.join(__dir__, '*.rb')].each { |file| require file unless __FILE__ == file }
