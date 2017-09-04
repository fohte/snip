# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snip/version'

Gem::Specification.new do |spec|
  spec.name          = 'snip'
  spec.version       = Snip::VERSION
  spec.authors       = ['Hayato Kawai']
  spec.email         = ['fohte.hk@gmail.com']

  spec.summary       = 'A CLI tool for management snippets'
  spec.description   = 'A CLI tool for management snippets'
  spec.homepage      = 'https://github.com/fohte/snip'
  spec.license       = 'MIT'

  spec.files =
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.49'
end
