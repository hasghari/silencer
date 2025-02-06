# frozen_string_literal: true

require_relative 'silencer/version'
require 'warning'
require 'yaml'

module Silencer
  class Error < StandardError
    def initialize(gem, expected, actual)
      super("#{gem} version changed from #{expected} to #{actual}")
    end
  end

  def self.ignore_warnings(file = '.silencer.yml')
    YAML.load_file(file).each do |name, attrs|
      version = attrs['version']
      spec = Gem::Specification.find_by_name(name)
      raise Error.new(name, version, spec.version.to_s) unless version == spec.version.to_s
      Array(attrs['patterns']).each do |pattern|
        Warning.ignore(Regexp.new(pattern), spec.gem_dir)
      end
    end
  end
end
