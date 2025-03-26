# frozen_string_literal: true

require 'spec_helper'
require 'test_runner/cli'

RSpec.describe TestRunner::CLI do
  let(:cli) { described_class.new }
  let(:runner) { instance_double(TestRunner::Runner) }

  before do
    allow(TestRunner::Runner).to receive(:new).and_return(runner)
    allow(ENV).to receive(:[]).and_return(nil)
    allow(ENV).to receive(:[]).with('RACK_ENV').and_return(nil)
  end

  describe '#all' do
    it 'запускает все тесты с дефолтными опциями' do
      cli.options = {
        log_level: 'normal',
        report_total: true
      }
      expect(TestRunner::Runner).to receive(:new).with(
        report_total: true,
        log_level: :normal
      )
      expect(runner).to receive(:run_all_tests)
      cli.all
    end

    it 'запускает все тесты с пользовательскими опциями' do
      cli.options = {
        report_total: false,
        log_level: 'debug'
      }
      expect(TestRunner::Runner).to receive(:new).with(
        report_total: false,
        log_level: :debug
      )
      expect(runner).to receive(:run_all_tests)
      cli.all
    end
  end

  describe '#task' do
    it 'запускает тесты для конкретной задачи' do
      cli.options = {
        log_level: 'normal',
        report_total: true
      }
      expect(TestRunner::Runner).to receive(:new).with(
        report_total: true,
        log_level: :normal
      )
      expect(runner).to receive(:run_task_tests).with('t1')
      cli.task('t1')
    end

    it 'запускает тесты с пользовательскими опциями' do
      cli.options = {
        report_total: false,
        log_level: 'debug'
      }
      expect(TestRunner::Runner).to receive(:new).with(
        report_total: false,
        log_level: :debug
      )
      expect(runner).to receive(:run_task_tests).with('t1')
      cli.task('t1')
    end
  end

  describe '#model' do
    it 'запускает тесты для конкретной модели' do
      cli.options = {
        log_level: 'normal',
        report_total: true
      }
      expect(TestRunner::Runner).to receive(:new).with(
        report_total: true,
        log_level: :normal
      )
      expect(runner).to receive(:run_model_tests).with('t1', 'gpt-4')
      cli.model('t1', 'gpt-4')
    end

    it 'запускает тесты с пользовательскими опциями' do
      cli.options = {
        report_total: false,
        log_level: 'debug'
      }
      expect(TestRunner::Runner).to receive(:new).with(
        report_total: false,
        log_level: :debug
      )
      expect(runner).to receive(:run_model_tests).with('t1', 'gpt-4')
      cli.model('t1', 'gpt-4')
    end
  end

  describe '.start' do
    context 'когда RACK_ENV не test' do
      before do
        allow(ENV).to receive(:[]).with('RACK_ENV').and_return(nil)
      end

      it 'добавляет --report-total если опция не указана' do
        args = ['all']
        expect(Thor).to receive(:start).with(args + ['--report-total'], {})
        described_class.start(args)
      end

      it 'не добавляет --report-total если опция уже указана' do
        args = ['all', '--report-total']
        expect(Thor).to receive(:start).with(args, {})
        described_class.start(args)
      end
    end

    context 'когда RACK_ENV=test' do
      before do
        allow(ENV).to receive(:[]).with('RACK_ENV').and_return('test')
      end

      it 'не добавляет --report-total' do
        args = ['all']
        expect(Thor).to receive(:start).with(args, {})
        described_class.start(args)
      end
    end
  end
end 