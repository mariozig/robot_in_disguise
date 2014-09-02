# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robot_in_disguise/version'

Gem::Specification.new do |spec|
  spec.name          = "robot_in_disguise"
  spec.version       = RobotInDisguise::VERSION
  spec.authors       = ["Mario Zigliotto"]
  spec.email         = ["mariozig@gmail.com"]
  spec.summary       = %q{Ruby client for Intuit's Transformation Service}
  spec.description   = %q{Client for Intuit's Transformation Service REST API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'faraday'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
