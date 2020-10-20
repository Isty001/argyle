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

module Argyle::Component end
module Argyle::View end

require_relative 'argyle/prototype.rb'
require_relative 'argyle/blueprint.rb'
require_relative 'argyle/error.rb'
require_relative 'argyle/renderer.rb'
require_relative 'argyle/assert.rb'

require_relative 'argyle/component/text.rb'

require_relative 'argyle/page/page.rb'
require_relative 'argyle/page/factory.rb'

require_relative 'argyle/layout/layout.rb'
require_relative 'argyle/layout/area.rb'
require_relative 'argyle/layout/registry.rb'
require_relative 'argyle/layout/factory.rb'
require_relative 'argyle/layout/default.rb'

require_relative 'argyle/view/default.rb'
require_relative 'argyle/view/text.rb'

