# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'rspec-apidoc'
  spec.version       = '0.1.0'
  spec.authors       = ['Stas Suscov']
  spec.email         = ['stas@nerd.ro']

  spec.summary       = 'RSpec HTTP API Documentation'
  spec.description   = \
    'Automatically generates the documentation for your HTTP API.'
  spec.homepage      = 'https://github.com/HeyBetter/rspec-apidoc'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files         = Dir['README.md', 'LICENSE.txt', 'lib/**/*']
  spec.require_path  = 'lib'
  spec.require_paths = ['lib']

  spec.add_dependency 'method_source'
  spec.add_dependency 'rspec-core'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
end
