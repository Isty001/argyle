module Argyle::Component end

Dir[File.join(__dir__, '*.rb')].each { |file| require file unless __FILE__ == file }
