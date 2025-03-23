# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HumanEval::Reports::CLI do
  let(:cli) { described_class.new }

  describe '#generate' do
    let(:generator) { instance_double(HumanEval::Reports::Generator) }

    before do
      allow(HumanEval::Reports::Generator).to receive(:new).and_return(generator)
      allow(generator).to receive(:generate)
    end

    it 'creates generator with default options' do
      expect(HumanEval::Reports::Generator).to receive(:new)
        .with(hash_including(format: 'all', output_dir: 'reports'))
      
      cli.generate
    end

    it 'creates generator with custom options' do
      expect(HumanEval::Reports::Generator).to receive(:new)
        .with(hash_including(format: 'html', output_dir: 'custom_dir'))
      
      cli.options = { format: 'html', output_dir: 'custom_dir' }
      cli.generate
    end

    it 'calls generate on the generator' do
      expect(generator).to receive(:generate)
      cli.generate
    end

    context 'when generator raises error' do
      before do
        allow(generator).to receive(:generate)
          .and_raise(HumanEval::Reports::Error, 'Test error')
      end

      it 'exits with status 1' do
        expect { cli.generate }.to raise_error(SystemExit) do |error|
          expect(error.status).to eq(1)
        end
      end
    end
  end
end 