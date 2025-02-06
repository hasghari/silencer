# frozen_string_literal: true

require_relative 'lib/silencer/version'

Gem::Specification.new do |spec|
  spec.name = 'gem-silencer'
  spec.version = Silencer::VERSION
  spec.authors = ['Hamed Asghari']
  spec.email = ['hasghari@gmail.com']

  spec.summary = 'A gem to silence ruby warnings from other gem dependencies'
  spec.homepage = "https://github.com/hasghari/silencer"
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.4.0'

  spec.metadata['homepage_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w(git ls-files -z), chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w(bin/ test/ spec/ features/ .git appveyor Gemfile))
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'warning', '~> 1.0'
  spec.add_dependency 'yaml', '~> 0.1'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
