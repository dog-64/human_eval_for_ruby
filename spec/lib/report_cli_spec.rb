require 'spec_helper'
require_relative '../../lib/report'

RSpec.describe Report do
  describe '.cli' do
    let(:args) { ['generate'] }
    let(:cli_class) { Report::CLI }

    it 'вызывает CLI.start с переданными аргументами' do
      expect(cli_class).to receive(:start).with(args).and_return(true)
      described_class.cli(args)
    end

    it 'возвращает результат выполнения' do
      allow(cli_class).to receive(:start).and_return(true)
      expect(described_class.cli(args)).to be true
    end

    context 'при передаче блока' do
      it 'вызывает блок с результатом выполнения' do
        allow(cli_class).to receive(:start).and_return(true)

        expect { |b| described_class.cli(args, &b) }.to yield_with_args(true)
      end
    end

    context 'без передачи блока' do
      it 'не вызывает yield' do
        allow(cli_class).to receive(:start).and_return(true)

        # Нет ошибки без блока
        expect { described_class.cli(args) }.not_to raise_error
      end
    end
  end
end
