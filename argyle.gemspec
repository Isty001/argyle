Gem::Specification.new do |spec|
  spec.name          = 'argyle.rb'
  spec.version       = '0.0.0'
  spec.authors       = ['Isty001']
  spec.email         = ['isty001@gmail.com']

  spec.summary       = 'Argyle'
  spec.description   = 'Argyle'
  spec.homepage      = 'https://github.com/Isty001/argyle'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  # spec.metadata['allowed_push_host'] = 'TODO: Set to 'http://mygemserver.com''

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/argyle/argyle'
  spec.metadata['changelog_uri'] = 'https://github.com/argyle/argyle/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir['README.md', 'VERSION', 'Gemfile', 'Rakefile', '{bin,lib}/**/*']

  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'curses', '~> 1.4.0'

  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'mocha', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 13.0'

  spec.add_development_dependency 'codecov', '~> 0.1.18'
  spec.add_development_dependency 'simplecov', '~> 0.21'

  spec.add_development_dependency 'rubocop', '~> 1.15'
  spec.add_development_dependency 'rubocop-performance', '~> 1.11'
end
