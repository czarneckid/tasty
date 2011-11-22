# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'tasty-version'

Gem::Specification.new do |s|
  s.name        = "tasty"
  s.version     = Tasty::VERSION.dup
  s.authors     = ["David Czarnecki"]
  s.email       = ["czarneckid@acm.org"]
  s.homepage    = "https://github.com/czarneckid/tasty"
  s.summary     = %q{Ruby library for interacting with del.icio.us}
  s.description = %q{Ruby library for interacting with del.icio.us}

  s.rubyforge_project = "tasty"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rake')
  s.add_development_dependency('mocha')
  s.add_development_dependency('fakeweb')
  
  s.add_dependency('httparty')
end
