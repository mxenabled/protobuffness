# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'protobuffness/version'

Gem::Specification.new do |spec|
  spec.name          = "protobuffness"
  spec.version       = Protobuffness::VERSION
  spec.authors       = ["Michael Ries"]
  spec.email         = ["michael@riesd.com"]

  spec.summary       = "A pure-ruby implementation of Protobuf encoding/decoding"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/moneydesktop/protobuffness"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
