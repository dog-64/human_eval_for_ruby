require 'spec_helper'
require_relative '../../lib/runner/cli'

RSpec.describe Runner::CLI do
  let(:runner) { instance_double('Runner::Runner') }
  let(:default_options) { { log_level: :normal, report: false } }
  
  before do
    allow(Runner::Runner).to receive(:new).and_return(runner)
    allow(runner).to receive(:run_tests)
  end
  
  describe '#execute' do
    context 'когда не указаны опции' do
      let(:cli) { described_class.new([]) }
      
      it 'запускает все тесты' do
        expect(Runner::Runner).to receive(:new).with(default_options).and_return(runner)
        expect(runner).to receive(:run_tests).with(task: nil, model: nil)
        cli.execute
      end
    end
    
    context 'когда указана опция --task' do
      let(:cli) { described_class.new([], { task: 't1' }) }
      
      it 'запускает тесты для конкретной задачи' do
        expect(Runner::Runner).to receive(:new).with(default_options).and_return(runner)
        expect(runner).to receive(:run_tests).with(task: 't1', model: nil)
        cli.execute
      end
    end
    
    context 'когда указаны опции --task и --model' do
      let(:cli) { described_class.new([], { task: 't1', model: 'model1' }) }
      
      it 'запускает тесты для конкретной модели в задаче' do
        expect(Runner::Runner).to receive(:new).with(default_options).and_return(runner)
        expect(runner).to receive(:run_tests).with(task: 't1', model: 'model1')
        cli.execute
      end
    end
    
    context 'когда указана только опция --model' do
      let(:cli) { described_class.new([], { model: 'model1' }) }
      
      it 'запускает тесты для конкретной модели' do
        expect(Runner::Runner).to receive(:new).with(default_options).and_return(runner)
        expect(runner).to receive(:run_tests).with(task: nil, model: 'model1')
        cli.execute
      end
    end
    
    context 'когда указан оригинальный формат имени модели' do
      let(:cli) { described_class.new([], { model: 'deepseek/deepseek-chat:free' }) }
      
      it 'использует оригинальное имя модели' do
        expect(Runner::Runner).to receive(:new).with(default_options).and_return(runner)
        expect(runner).to receive(:run_tests).with(task: nil, model: 'deepseek/deepseek-chat:free')
        cli.execute
      end
    end
    
    context 'когда указаны дополнительные опции' do
      let(:cli) { described_class.new([], { log_level: 'debug', report: true }) }
      
      it 'передает дополнительные опции в Runner' do
        expected_options = { log_level: :debug, report: true }
        allow(Runner::Runner).to receive(:new).with(hash_including(expected_options)).and_return(runner)
        expect(runner).to receive(:run_tests).with(task: nil, model: nil)
        cli.execute
      end
    end
  end
  
  describe '#list_models' do
    let(:cli) { described_class.new([]) }
    let(:models_manager) { instance_double('Models') }
    let(:openrouter_models) do
      {
        'model1' => { 'name' => 'model/1', 'provider' => 'openrouter.ai', 'done' => true },
        'model2' => { 'name' => 'model/2', 'provider' => 'openrouter.ai', 'done' => false }
      }
    end
    let(:ollama_models) do
      {
        'model3' => { 'name' => 'model3', 'provider' => 'ollama', 'done' => true },
        'model4' => { 'name' => 'model4', 'provider' => 'ollama', 'done' => false }
      }
    end
    
    before do
      allow(Models).to receive(:new).and_return(models_manager)
      allow(models_manager).to receive(:all).and_return(openrouter_models.merge(ollama_models))
      allow(STDOUT).to receive(:puts)
    end
    
    it 'выводит список моделей' do
      expect(STDOUT).to receive(:puts).with("Доступные модели:")
      expect(STDOUT).to receive(:puts).with("\nOpenRouter.ai модели:")
      expect(STDOUT).to receive(:puts).with(/model1: model\/1/)
      expect(STDOUT).to receive(:puts).with(/model2: model\/2/)
      expect(STDOUT).to receive(:puts).with("\nOllama модели:")
      expect(STDOUT).to receive(:puts).with(/model3: model3/)
      expect(STDOUT).to receive(:puts).with(/model4: model4/)
      
      cli.list_models
    end
  end
end 