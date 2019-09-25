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
  spec.files         = Dir['lib/**/*']
  spec.test_files    = Dir['test/**/*']
  spec.required_ruby_version = '>= 2.4'
  spec.add_development_dependency "rake", "~> 12"
end

