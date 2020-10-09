if ENV['GENERATE_COVERAGE']
  require 'simplecov'
  SimpleCov.start

  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require_relative "../lib/argyle.rb"
require "minitest/autorun"
