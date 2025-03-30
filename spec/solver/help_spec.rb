require 'spec_helper'
require_relative '../../lib/solver/help'
require_relative '../../lib/models'

RSpec.describe Solver::Help do
  let(:test_class) do
    Class.new do
      include Solver::Help
    end.new
  end

  let(:models_mock) do
    instance_double('Models')
  end

  let(:openrouter_models) do
    {
      'model1' => { 'name' => 'Model 1', 'provider' => 'openrouter.ai' },
      'model2' => { 'name' => 'Model 2', 'provider' => 'openrouter.ai', 'note' => 'test note' }
    }
  end

  let(:ollama_models) do
    {
      'ollama_model1' => { 'name' => 'ollama1', 'provider' => 'ollama' },
      'ollama_model2' => { 'name' => 'ollama2', 'provider' => 'ollama', 'note' => 'test note' }
    }
  end

  let(:all_models) do
    openrouter_models.merge(ollama_models)
  end

  before do
    allow(Models).to receive(:new).and_return(models_mock)
    allow(models_mock).to receive(:all).and_return(all_models)
    allow(test_class).to receive(:puts)
  end

  describe '#show' do
    it 'вызывает соответствующие методы для вывода информации' do
      expect(test_class).to receive(:base)
      expect(test_class).to receive(:models)
      expect(test_class).to receive(:examples)

      test_class.show
    end
  end

  describe '#models' do
    it 'вызывает методы для отображения моделей' do
      expect(test_class).to receive(:show_openrouter_models)
      expect(test_class).to receive(:show_ollama_models)

      test_class.send(:models)
    end
  end

  describe '#show_openrouter_models' do
    it 'выводит информацию о моделях OpenRouter.ai' do
      expect(test_class).to receive(:puts).with('OpenRouter.ai модели:')
      expect(test_class).to receive(:puts).with('  model1: Model 1')
      expect(test_class).to receive(:puts).with('  model2: Model 2 (test note)')

      test_class.send(:show_openrouter_models)
    end
  end

  describe '#show_ollama_models' do
    it 'выводит информацию о моделях Ollama' do
      expect(test_class).to receive(:puts).with("\nЛокальные Ollama модели:")
      expect(test_class).to receive(:puts).with('  ollama_model1: ollama1')
      expect(test_class).to receive(:puts).with('  ollama_model2: ollama2 (test note)')

      test_class.send(:show_ollama_models)
    end
  end

  describe '#base' do
    it 'выводит базовую информацию о командах' do
      expect(test_class).to receive(:puts).with('Доступные команды Solver:')
      expect(test_class).to receive(:puts)
      expect(test_class).to receive(:show_commands)

      test_class.send(:base)
    end
  end

  describe '#show_commands' do
    it 'выводит информацию о командах и их опциях' do
      expect(test_class).to receive(:puts).with('== Команды ==')
      expect(test_class).to receive(:puts).with('solve TASKS_DIR: Solve tasks from TASKS_DIR using AI models')
      expect(test_class).to receive(:show_solve_options)
      expect(test_class).to receive(:puts)
      expect(test_class).to receive(:puts).with('commands: Показать все доступные команды и опции')
      expect(test_class).to receive(:puts)
      expect(test_class).to receive(:puts).with('help [COMMAND]: Describe available commands or one specific command')
      expect(test_class).to receive(:puts)

      test_class.send(:show_commands)
    end
  end

  describe '#show_solve_options' do
    it 'выводит опции команды solve' do
      expect(test_class).to receive(:puts).with('  Опции:')
      expect(test_class).to receive(:puts).with('    --model=MODEL: Use specific model')
      expect(test_class).to receive(:puts).with(
        '    --task=TASK: Решить конкретную задачу (можно указать как номер, так и имя, например: 1 или t1)'
      )
      expect(test_class).to receive(:puts).with('    --log-level=LOG_LEVEL: Logging level (по умолчанию: normal)')
      expect(test_class).to receive(:puts).with('      Возможные значения: none, normal, debug')
      expect(test_class).to receive(:puts).with('    --keep-existing: Keep existing solutions (по умолчанию: false)')
      msg = '    --create-empty-on-timeout: Создавать пустой файл решения с комментарием при таймауте или ошибке ' \
            '(по умолчанию: false)'
      expect(test_class).to receive(:puts).with(msg)

      test_class.send(:show_solve_options)
    end
  end

  describe '#examples' do
    it 'вызывает методы для вывода примеров использования' do
      expect(test_class).to receive(:puts).with("\n== Примеры использования ==")
      expect(test_class).to receive(:show_solve_examples)
      expect(test_class).to receive(:show_additional_examples)

      test_class.send(:examples)
    end
  end

  describe '#show_solve_examples' do
    it 'выводит примеры использования команды solve' do
      expect(test_class).to receive(:puts).with('# Решение всех задач конкретной моделью')
      expect(test_class).to receive(:puts).with('./bin/solver solve tasks --model "MODEL_NAME"')
      expect(test_class).to receive(:puts)
      expect(test_class).to receive(:puts).with('# Решение конкретной задачи')
      expect(test_class).to receive(:puts).with('./bin/solver solve tasks --task t1 --model "MODEL_NAME"')
      expect(test_class).to receive(:puts).with('# или')
      expect(test_class).to receive(:puts).with('./bin/solver solve tasks --task 1 --model "MODEL_NAME"')

      test_class.send(:show_solve_examples)
    end
  end

  describe '#show_additional_examples' do
    it 'выводит дополнительные примеры использования' do
      expect(test_class).to receive(:puts)
      expect(test_class).to receive(:puts).with('# Сохранение промежуточных результатов')
      expect(test_class).to receive(:puts).with('./bin/solver solve tasks --model "MODEL_NAME" --keep-existing')
      expect(test_class).to receive(:puts)
      expect(test_class).to receive(:puts).with('# Включение подробного логирования')
      expect(test_class).to receive(:puts).with('./bin/solver solve tasks --model "MODEL_NAME" --log-level debug')
      expect(test_class).to receive(:puts)
      expect(test_class).to receive(:puts).with('# Создание пустых файлов при таймаутах или ошибках')
      expect(test_class).to receive(:puts).with(
        './bin/solver solve tasks --model "MODEL_NAME" --create-empty-on-timeout'
      )

      test_class.send(:show_additional_examples)
    end
  end
end
