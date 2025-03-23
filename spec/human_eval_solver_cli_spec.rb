# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/human_eval_solver_cli'

RSpec.describe HumanEval::SolverCLI do
  let(:cli) { described_class.new }
  let(:solver_double) { instance_double('HumanEval::SolverClass') }
  let(:tasks_dir) { 'tasks' }

  before do
    allow(HumanEval::SolverClass).to receive(:new).and_return(solver_double)
    allow(solver_double).to receive(:process)
  end

  describe '#solve' do
    context 'with default options' do
      it 'creates solver with default options' do
        expect(HumanEval::SolverClass).to receive(:new).with(
          tasks_dir,
          hash_including(
            model: nil,
            task: nil,
            log_level: nil,
            keep_existing: nil
          )
        )
        cli.solve(tasks_dir)
      end

      it 'calls process on solver' do
        expect(solver_double).to receive(:process)
        cli.solve(tasks_dir)
      end
    end

    context 'with custom options' do
      let(:cli) do
        described_class.new([], {
          'model' => 'gpt-4',
          'task' => '42',
          'log_level' => 'debug',
          'keep_existing' => true
        })
      end

      it 'creates solver with custom options' do
        expect(HumanEval::SolverClass).to receive(:new).with(
          tasks_dir,
          hash_including(
            model: 'gpt-4',
            task: '42',
            log_level: 'debug',
            keep_existing: true
          )
        )
        cli.solve(tasks_dir)
      end
    end

    context 'with invalid log_level' do
      let(:cli) { described_class.new([], { 'log_level' => 'invalid' }) }

      it 'creates solver with invalid log_level' do
        expect(HumanEval::SolverClass).to receive(:new).with(
          tasks_dir,
          hash_including(log_level: 'invalid')
        )
        cli.solve(tasks_dir)
      end
    end
  end

  describe '.exit_on_failure?' do
    it 'returns true' do
      expect(described_class.exit_on_failure?).to be true
    end
  end
end 