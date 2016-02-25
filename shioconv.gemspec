lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shioconv/version'

Gem::Specification.new do |spec|
  spec.name          = 'shioconv'
  spec.version       = Shioconv::VERSION
  spec.authors       = ['SHIOYA, Hiromu']
  spec.email         = ['kwappa.856@gmail.com']
  spec.summary       = %q{Shioconv converts between weight and volume of typical condiments.}
  spec.description   = %q{Shioconv converts between weight and volume of typical condiments.}
  spec.homepage      = 'http://github.com/kwappa/shioconv'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coveralls'
end
