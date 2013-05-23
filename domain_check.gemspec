# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domain_check/version'

Gem::Specification.new do |spec|
  spec.name          = "domain_check"
  spec.version       = DomainCheck::VERSION
  spec.authors       = ["Chris Kottom"]
  spec.email         = ["chris@chriskottom.com"]
  spec.description   = %q{Bulk checking domain availability}
  spec.summary       = %q{Perform domain name research against a large set using combinations of relevant keywords.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
