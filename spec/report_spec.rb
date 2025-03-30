require 'spec_helper'
require_relative '../lib/report'

RSpec.describe Report do
  it 'is defined as a module' do
    expect(described_class).to be_a(Module)
  end

  describe 'module structure' do
    it 'includes Generator class' do
      expect(Report.const_defined?(:Generator)).to be true
      expect(Report::Generator).to be_a(Class)
    end

    it 'includes Runner class' do
      expect(Report.const_defined?(:Runner)).to be true
      expect(Report::Runner).to be_a(Class)
    end

    it 'includes CLI class' do
      expect(Report.const_defined?(:CLI)).to be true
      expect(Report::CLI).to be_a(Class)
    end
  end
end 