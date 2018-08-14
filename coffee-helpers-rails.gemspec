# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coffee/helpers/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "coffee-helpers-rails"
  spec.version       = Engine::Helpers::Rails::VERSION
  spec.authors       = ["StraDIVar"]
  spec.email         = ["strdvr@gmail.com"]
  spec.summary       = "an asset gemification of the simple frequently-used CoffeeScript helpers"
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/StraDIVar/coffee-helpers-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
