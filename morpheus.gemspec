# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'morpheus/version'

Gem::Specification.new do |spec|
  spec.name          = "morpheus"
  spec.version       = Morpheus::VERSION
  spec.authors       = ["Catalin Ionescu"]
  spec.email         = ["catalin.ionescu282@gmail.com"]

  spec.summary       = "A set of Rake scrips to automate interactions with Heroku"
  spec.homepage      = "https://github.com/cionescu/morpheus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rake", "~> 10.0"

  spec.add_development_dependency "rails", ">= 3.2"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "benchmark-ips"
  spec.add_development_dependency "geminabox"
end
