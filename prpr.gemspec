# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prpr/version'

Gem::Specification.new do |spec|
  spec.name          = "prpr"
  spec.version       = Prpr::VERSION
  spec.authors       = ["mzp"]
  spec.email         = ["mzpppp@gmail.com"]

  spec.summary       = %q{Pull requset bot}
  spec.description   = %q{Pull request bot}
  spec.homepage      = "https://codefirst.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "octokit"
  spec.add_dependency "hashie"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "ultrahook"
  spec.add_development_dependency "webmock"
end
