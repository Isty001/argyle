module Argyle end

Dir[File.join(File.dirname(__FILE__), 'argyle', '*.rb')].each {|file| require file }
