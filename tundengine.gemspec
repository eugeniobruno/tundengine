# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tundengine/version'

Gem::Specification.new do |s|
  s.name        = 'tundengine'
  s.version     = Tundengine::Version
  s.date        = '2017-02-04'
  s.summary     = "Tute Understanding Engine"
  s.description = "A gem to build applications based on the rules of the Tute card game."
  s.authors     = ["Eugenio Bruno"]
  s.email       = 'eugeniobruno@gmail.com'
  s.homepage    = 'https://github.com/eugeniobruno/tundengine'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency 'rake', ['~> 11.2']
  s.add_development_dependency 'minitest', ['~> 5.9']
  s.add_development_dependency 'pry-byebug', ['~> 3.4']

end