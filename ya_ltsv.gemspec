# coding: us-ascii
# frozen_string_literal: true

lib_name = 'ltsv'.freeze

require_relative './lib/ltsv/version'
repository_url = "https://github.com/kachick/#{lib_name}"

Gem::Specification.new do |gem|
  # specific

  gem.summary       = %q{Yet another gem for LTSV}
  gem.description   = %q{An reader/writer library for the LTSV(Labeled Tab Separated Values) format. 
  See LTSV specs http://ltsv.org/.}
  gem.homepage      = "https://github.com/kachick/#{lib_name}"
  gem.license       = 'MIT'
  gem.name          = 'ya_ltsv'
  gem.version       = LTSV::VERSION.dup

  gem.metadata = {
    'documentation_uri'     => 'https://kachick.github.io/ltsv/',
    'homepage_uri'          => repository_url,
    'source_code_uri'       => repository_url,
    'bug_tracker_uri'       => "#{repository_url}/issues",
    'rubygems_mfa_required' => 'true'
  }

  gem.required_ruby_version = Gem::Requirement.new('>= 3.1')

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  git_managed_files = `git ls-files`.lines.map(&:chomp)
  might_be_parsing_by_tool_as_dependabot = git_managed_files.empty?
  base_files = Dir['README*', '*LICENSE*',  'lib/**/*', 'sig/**/*'].uniq
  files = might_be_parsing_by_tool_as_dependabot ? base_files : (base_files & git_managed_files)

  unless might_be_parsing_by_tool_as_dependabot
    if files.grep(%r!\A(?:lib|sig)/!).size < 2
      raise "obvious mistaken in packaging files, looks shortage: #{files.inspect}"
    end
  end

  gem.files         = files
  gem.require_paths = ['lib']
end
