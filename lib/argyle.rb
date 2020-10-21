module Argyle
  def self.activate
    return if active?

    @@active = true
  end

  def self.active?
    @@active ||= false
  end
end

Argyle.activate

at_exit do
  # p Argyle.active?
end

require 'ncursesw'

Dir[File.join(__dir__, 'argyle', '*.rb')].each { |file| require file unless __FILE__ == file }

require_relative 'argyle/component/component.rb'
require_relative 'argyle/page/page.rb'
require_relative 'argyle/layout/layout.rb'
require_relative 'argyle/view/view.rb'
