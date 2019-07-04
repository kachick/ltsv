# coding: us-ascii

lib_name = 'ltsv'.freeze
require "./lib/ltsv/version"

Gem::Specification.new do |gem|
  # specific

  gem.summary       = %q{Yet another gem for LTSV}
  gem.description   = %q{An reader/writer library for the LTSV(Labeled Tab Separated Values) format. 
  See LTSV specs http://ltsv.org/.}
  gem.homepage      = "https://github.com/kachick/#{lib_name}"
  gem.license       = 'MIT'
  gem.name          = 'ya_ltsv'
  gem.version       = LTSV::VERSION.dup

  gem.add_development_dependency 'rspec', '>= 3.3', '< 4'
  gem.add_development_dependency 'yard', '>= 0.8.7.6', '< 0.9'
  gem.add_development_dependency 'rake', '>= 10', '< 20'
  gem.add_development_dependency 'bundler', '>= 1.10', '< 2'
  
  if RUBY_ENGINE == 'rbx'
    gem.add_development_dependency 'rubysl', '~> 2.1'
  end

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

end
