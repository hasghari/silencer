# frozen_string_literal: true

require 'tempfile'

RSpec.describe Silencer do
  it 'has a version number' do
    expect(Silencer::VERSION).not_to be_nil
  end

  describe '::ignore_warnings' do
    let(:file) do
      Tempfile.new('.silencer.yml').tap do |f|
        f.write(content)
        f.rewind
      end
    end

    context 'when the gem version matches' do
      let(:content) do
        <<~YAML
          yaml:
            version: 0.4.0
            patterns:
              - constant ::YAML::ENGINE is deprecated
        YAML
      end

      it 'ignores the warnings' do
        expect { Silencer.ignore_warnings(file.path) }.not_to raise_error
      end
    end

    context 'when the gem version does not match' do
      let(:content) do
        <<~YAML
          yaml:
            version: 0.5.0
            patterns:
              - constant ::YAML::ENGINE is deprecated
        YAML
      end

      it 'raises an error' do
        expect { Silencer.ignore_warnings(file.path) }.to raise_error Silencer::Error
      end
    end
  end
end
