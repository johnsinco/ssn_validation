# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "ssn_validation"
  spec.version       = SsnValidation::VERSION
  spec.authors       = ["John Stewart"]
  spec.summary       = 'Social Security Number (SSN) Validation'
	spec.license       = 'Apache-2.0'
  spec.homepage      = 'https://github.com/johnsinco/ssn_validation'
  spec.summary       = 'Social Security Number (SSN) Validation'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map {|f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.3'
  spec.add_development_dependency "rake", '~> 12'
  spec.add_development_dependency "activemodel", '~> 5'
end

