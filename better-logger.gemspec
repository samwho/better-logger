# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better-logger/version'

Gem::Specification.new do |gem|
  gem.name          = "better-logger"
  gem.version       = Better::Logger::VERSION
  gem.authors       = ["Sam Rose"]
  gem.email         = ["samwho@lbak.co.uk"]
  gem.description   = %q{A better logging default for Ruby.}
  gem.summary       = %q{A little tired of unconventional logging techniques in projects, this gem aims to introduce a logging convention.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # Dependencies
  gem.add_development_dependency "rspec"
  gem.add_dependency "colored"
end
