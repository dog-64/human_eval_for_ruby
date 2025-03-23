# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HumanEval::Reports::Formatters::Base do
  let(:output_dir) { File.join('tmp', 'test_reports') }
  let(:task_results) do
    {
      't1' => { 'model1' => true, 'model2' => false },
      't2' => { 'model1' => false, 'model2' => true }
    }
  end
  let(:model_stats) do
    [
      ['model1', 50],
      ['model2', 50]
    ]
  end
  let(:timestamp) { '2024-03-20 12:00:00' }
  let(:formatter) do
    described_class.new(
      output_dir: output_dir,
      task_results: task_results,
      model_stats: model_stats,
      timestamp: timestamp
    )
  end

  describe '#initialize' do
    it 'устанавливает output_dir' do
      expect(formatter.output_dir).to eq(output_dir)
    end

    it 'устанавливает task_results' do
      expect(formatter.task_results).to eq(task_results)
    end

    it 'устанавливает model_stats' do
      expect(formatter.model_stats).to eq(model_stats)
    end

    it 'устанавливает timestamp' do
      expect(formatter.timestamp).to eq(timestamp)
    end

    context 'когда не указаны обязательные параметры' do
      it 'вызывает ошибку при отсутствии output_dir' do
        expect {
          described_class.new(
            task_results: task_results,
            model_stats: model_stats,
            timestamp: timestamp
          )
        }.to raise_error(ArgumentError, /output_dir/)
      end

      it 'вызывает ошибку при отсутствии task_results' do
        expect {
          described_class.new(
            output_dir: output_dir,
            model_stats: model_stats,
            timestamp: timestamp
          )
        }.to raise_error(ArgumentError, /task_results/)
      end

      it 'вызывает ошибку при отсутствии model_stats' do
        expect {
          described_class.new(
            output_dir: output_dir,
            task_results: task_results,
            timestamp: timestamp
          )
        }.to raise_error(ArgumentError, /model_stats/)
      end
    end
  end

  describe '#generate' do
    it 'вызывает NotImplementedError' do
      expect { formatter.generate }.to raise_error(NotImplementedError)
    end
  end
end 