Gem::Specification.new do |spec|
  spec.name          = "argyle"
  spec.version       = "0.1.0"
  spec.authors       = ["Isty001"]
  spec.email         = ["isty001@gmail.com"]

  spec.summary       = %q{Argyle}
  spec.description   = %q{Argyle}
  spec.homepage      = "https://github.com/argyle/argyle"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/argyle/argyle"
  spec.metadata["changelog_uri"] = "https://github.com/argyle/argyle/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir['README.md', 'VERSION', 'Gemfile', 'Rakefile', '{bin,lib}/**/*']

  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'ncursesw'

  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'mocha'

  spec.add_development_dependency "codecov", "~> 0.1.16"
  spec.add_development_dependency "simplecov", "~> 0.17"
end
