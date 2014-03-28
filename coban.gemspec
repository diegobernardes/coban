# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coban/version'

Gem::Specification.new do |spec|
  spec.name          = "coban"
  spec.version       = Coban::VERSION
  spec.authors       = ["Diego Bernardes"]
  spec.email         = ["diego.bernardes@outlook.com"]
  spec.summary       = %q{Parser for Coban trackers}
  spec.description   = %q{Parser for Coban trackers}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md ROADMAP.md CHANGELOG.md)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "debugger"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
