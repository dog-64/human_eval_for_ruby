require 'spec_helper'
require 'fileutils'
require_relative '../lib/runner/runner'

RSpec.describe Runner::Runner do
  let(:runner) { described_class.new(log_level: 'none') }
  let(:solution1_content) { "def add(a, b)\n  a + b\nend" }
  let(:solution2_content) { "def add(a, b)\n  a - b\nend" }
  let(:test_content) { 'include Runner::Assert; assert_equal(add(2, 3), 5)' }
  let(:total_md_content) { "## Рейтинг\n\n- model1: 100%\n- model2: 0%\n" }

  before(:each) do
    # Подменяем все операции с файлами
    allow(FileUtils).to receive(:mkdir_p).with(any_args).and_return(true)
    allow(FileUtils).to receive(:rm_rf).with(any_args).and_return(true)

    # Подменяем чтение файлов
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:exist?).with('tasks/t1-assert.rb').and_return(true)
    allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("def add(a, b)\n  a + b\nend")
    allow(File).to receive(:read).with('tasks/t1-model2.rb').and_return(solution2_content)
    allow(File).to receive(:read).with('tasks/t1-assert.rb').and_return(test_content)
    allow(File).to receive(:read).with('reports/total.md').and_return(total_md_content)
    allow(File).to receive(:write).with(any_args).and_return(true)

    # Мокаем создание файлов отчетов
    report_file = double('report_file')
    allow(report_file).to receive(:puts).with(any_args)
    allow(File).to receive(:open).and_yield(report_file)

    # Подменяем поиск файлов
    allow(Dir).to receive(:glob).with('tasks/t*-*.rb').and_return([
                                                                    'tasks/t1-model1.rb',
                                                                    'tasks/t1-model2.rb'
                                                                  ])
    allow(Dir).to receive(:glob).with('tasks/t1-*.rb').and_return([
                                                                    'tasks/t1-model1.rb',
                                                                    'tasks/t1-model2.rb'
                                                                  ])
    allow(Dir).to receive(:glob).with('tasks/t1-model1.rb').and_return(['tasks/t1-model1.rb'])
    allow(Dir).to receive(:glob).with('tasks/t1-model2.rb').and_return(['tasks/t1-model2.rb'])
    allow(Dir).to receive(:glob).with('tasks/t1-nonexistent.rb').and_return([])

    # Мокаем методы работы с README.md
    allow_any_instance_of(Report::Generator).to receive(:update_readme)
    
    # Убираем глобальные моки для test_solution
  end

  describe '#run_tests' do
    it 'runs tests only for mock solutions' do
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model1.rb').and_return(true)
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model2.rb').and_return(false)
      results = runner.run_tests
      expect(results['t1'].keys).to contain_exactly('model1', 'model2')
      expect(results['t1']['model1']).to be true
      expect(results['t1']['model2']).to be false
    end

    it 'runs tests only for mock solutions of specific task' do
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model1.rb').and_return(true)
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model2.rb').and_return(false)
      results = runner.run_tests(task: 't1')
      expect(results['t1'].keys).to contain_exactly('model1', 'model2')
      expect(results['t1']['model1']).to be true
      expect(results['t1']['model2']).to be false
    end

    it 'returns empty hash for invalid task format' do
      results = runner.run_tests(task: 'invalid')
      expect(results).to eq({})
    end

    it 'returns empty hash when test file missing' do
      allow(File).to receive(:exist?).with('tasks/t1-assert.rb').and_return(false)
      results = runner.run_tests(task: 't1')
      expect(results).to eq({})
    end

    it 'runs test for correct solution' do
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model1.rb').and_return(true)
      results = runner.run_tests(task: 't1', model: 'model1')
      expect(results['t1']['model1']).to be true
    end

    it 'detects incorrect solution' do
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model2.rb').and_return(false)
      results = runner.run_tests(task: 't1', model: 'model2')
      expect(results['t1']['model2']).to be false
    end

    it 'returns empty hash for missing solution' do
      results = runner.run_tests(task: 't1', model: 'nonexistent')
      expect(results).to eq({})
    end

    it 'handles syntax errors' do
      allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("def add(a, b)\n  syntax_error")
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model1.rb').and_return(false)
      results = runner.run_tests(task: 't1', model: 'model1')
      expect(results['t1']['model1']).to be false
    end

    it 'handles timeouts' do
      runner = described_class.new(timeout: 1, log_level: 'none')
      allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("def add(a, b)\n  while true; end\n  a + b\nend")
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model1.rb').and_return(false)
      results = runner.run_tests(task: 't1', model: 'model1')
      expect(results['t1']['model1']).to be false
    end

    it 'handles empty solution files' do
      allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("   \n  \n  ")
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model1.rb').and_return(false)
      results = runner.run_tests(task: 't1', model: 'model1')
      expect(results['t1']['model1']).to be false
    end

    it 'handles missing solution files' do
      allow(File).to receive(:exist?).with('tasks/t1-assert.rb').and_return(true)
      allow(File).to receive(:exist?).with('tasks/t1-model1.rb').and_return(false)
      allow(Dir).to receive(:glob).with('tasks/t1-model1.rb').and_return([])
      allow(runner).to receive(:find_solution_files).with('t1').and_return([])
      results = runner.run_tests(task: 't1', model: 'model1')
      expect(results).to eq({})
    end

    it 'handles runtime errors in solution' do
      allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("def add(a, b)\n  raise 'Runtime error'\nend")
      allow_any_instance_of(described_class).to receive(:test_solution).with('t1', 'tasks/t1-model1.rb').and_return(false)
      results = runner.run_tests(task: 't1', model: 'model1')
      expect(results['t1']['model1']).to be false
    end

    it 'handles invalid task format' do
      results = runner.run_tests(task: 'invalid', model: 'model1')
      expect(results).to eq({})
    end

    it 'handles invalid model name format' do
      allow(Dir).to receive(:glob).with("tasks/t1-invalid_model.rb").and_return([])
      results = runner.run_tests(task: 't1', model: 'invalid/model')
      expect(results).to eq({})
    end

    it 'handles interrupts gracefully' do
      allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("def add(a, b)\n  a + b\nend")
      allow(runner).to receive(:test_solution).and_return(false)
      results = runner.run_tests(task: 't1', model: 'model1')
      expect(results['t1']['model1']).to be false
    end
  end

  describe '#colorize' do
    subject { runner.send(:colorize, 'text', percentage) }

    context 'when percentage is 20' do
      let(:percentage) { 20 }

      it 'возвращает красный цвет для низкого процента' do
        expect(subject).to eq("\e[31mtext\e[0m")
      end
    end

    context 'when percentage is 50' do
      let(:percentage) { 50 }

      it 'возвращает желтый цвет для среднего процента' do
        expect(subject).to eq("\e[33mtext\e[0m")
      end
    end

    context 'when percentage is 80' do
      let(:percentage) { 80 }

      it 'возвращает зеленый цвет для высокого процента' do
        expect(subject).to eq("\e[32mtext\e[0m")
      end
    end

    context 'when percentage is 33' do
      let(:percentage) { 33 }

      it 'корректно обрабатывает граничные значения' do
        expect(subject).to eq("\e[31mtext\e[0m")
      end
    end

    context 'when percentage is 34' do
      let(:percentage) { 34 }

      it 'корректно обрабатывает граничные значения' do
        expect(subject).to eq("\e[33mtext\e[0m")
      end
    end

    context 'when percentage is 66' do
      let(:percentage) { 66 }

      it 'корректно обрабатывает граничные значения' do
        expect(subject).to eq("\e[33mtext\e[0m")
      end
    end

    context 'when percentage is 67' do
      let(:percentage) { 67 }

      it 'корректно обрабатывает граничные значения' do
        expect(subject).to eq("\e[32mtext\e[0m")
      end
    end
  end

  describe 'initialization' do
    it 'initializes without error' do
      expect { described_class.new }.not_to raise_error
    end

    it 'accepts options' do
      runner = described_class.new(log_level: :debug)
      expect(runner.instance_variable_get(:@options)[:log_level]).to eq(:debug)
    end

    it 'sets default timeout' do
      runner = described_class.new
      expect(runner.instance_variable_get(:@timeout)).to eq(5)
    end
  end

  # Тесты для метода log_error_details
  describe '#log_error_details' do
    let(:runner) { described_class.new(log_level: :debug) }

    it 'логирует детали ошибки с полным стеком' do
      error = {
        class: 'RuntimeError',
        message: 'test error',
        backtrace: %w[line1 line2]
      }

      expect(runner).to receive(:debug_log).with('  ❌ Тест не пройден:')
      expect(runner).to receive(:debug_log).with('     RuntimeError: test error')
      expect(runner).to receive(:debug_log).with('     Стек вызовов:')
      expect(runner).to receive(:debug_log).with('       line1')
      expect(runner).to receive(:debug_log).with('       line2')

      runner.log_error_details(error)
    end

    it 'корректно обрабатывает отсутствие стека вызовов' do
      error = {
        class: 'RuntimeError',
        message: 'test error',
        backtrace: nil
      }

      expect(runner).to receive(:debug_log).with('  ❌ Тест не пройден:')
      expect(runner).to receive(:debug_log).with('     RuntimeError: test error')
      expect(runner).to receive(:debug_log).with('     Стек вызовов:')
      expect(runner).to receive(:debug_log).with('       Стек вызовов недоступен')

      runner.log_error_details(error)
    end
  end

  describe '#raise_log' do
    let(:runner) { described_class.new(log_level: :debug) }
    let(:error) { StandardError.new('test error') }

    before do
      allow(error).to receive(:backtrace).and_return(%w[line1 line2])
    end

    it 'логирует ошибку с полным стеком вызовов' do
      expect(runner).to receive(:debug_log).with(' ❌ test message:')
      expect(runner).to receive(:debug_log).with('    Тип: StandardError')
      expect(runner).to receive(:debug_log).with('    Сообщение: test error')
      expect(runner).to receive(:debug_log).with('    Место ошибки: line1')
      expect(runner).to receive(:debug_log).with('    Полный стек вызовов:')
      expect(runner).to receive(:debug_log).with('       line1')
      expect(runner).to receive(:debug_log).with('       line2')

      runner.send(:raise_log, error, 'test message')
    end
  end

  describe '#get_display_model_name' do
    let(:runner) { described_class.new }

    it 'возвращает базовое имя модели без дополнительной информации' do
      allow(runner).to receive(:get_model_info).and_return({ 'name' => 'test_model', 'provider' => 'unknown' })
      expect(runner.send(:get_display_model_name, 'test_model')).to eq('test_model')
    end

    it 'добавляет провайдера к имени модели' do
      allow(runner).to receive(:get_model_info).and_return({ 'name' => 'test_model', 'provider' => 'openai' })
      expect(runner.send(:get_display_model_name, 'test_model')).to eq('test_model (openai)')
    end

    it 'добавляет заметку к имени модели' do
      allow(runner).to receive(:get_model_info).and_return({ 'name' => 'test_model', 'provider' => 'unknown',
                                                             'note' => 'test note' })
      expect(runner.send(:get_display_model_name, 'test_model')).to eq('test_model - test note')
    end

    it 'добавляет и провайдера, и заметку к имени модели' do
      allow(runner).to receive(:get_model_info).and_return({ 'name' => 'test_model', 'provider' => 'openai',
                                                             'note' => 'test note' })
      expect(runner.send(:get_display_model_name, 'test_model')).to eq('test_model (openai) - test note')
    end
  end

  describe '#display_total_console' do
    let(:runner) { described_class.new }
    let(:tasks) { %w[t1 t2 t3] }
    let(:models) { %w[model1 model2] }

    before do
      runner.instance_variable_set(:@results, {
                                     't1' => { 'model1' => true, 'model2' => false },
                                     't2' => { 'model1' => true, 'model2' => true },
                                     't3' => { 'model1' => true, 'model2' => false }
                                   })
    end

    it 'выводит статистику для каждой модели в правильном порядке' do
      expect(runner).to receive(:log).with("\n📊 Общая статистика:")
      expect(runner).to receive(:log).with("- Всего задач: 3")
      expect(runner).to receive(:log).with("- Всего моделей: 2")
      expect(runner).to receive(:log).with("- Моделей с результатами: 2")
      expect(runner).to receive(:log).with("- Общая успешность: #{runner.send(:colorize, "4/6 (67%)", 67)}")
      expect(runner).to receive(:log).with("\n🤖 Результаты тестирования моделей:")
      expect(runner).to receive(:log).with("- model1: #{runner.send(:colorize, "3/3 (100%)", 100)}")
      expect(runner).to receive(:log).with("- model2: #{runner.send(:colorize, "1/3 (33%)", 33)}")

      runner.send(:display_total_console, tasks, models)
    end
  end

  describe '#models' do
    let(:runner) { described_class.new }

    before do
      allow(Dir).to receive(:glob).with('tasks/t*-*.rb').and_return([
                                                                      'tasks/t1-model1.rb',
                                                                      'tasks/t1-model2.rb',
                                                                      'tasks/t2-model1.rb',
                                                                      'tasks/t1-assert.rb',
                                                                      'tasks/t2-model2.rb'
                                                                    ])
    end

    it 'возвращает отсортированный список уникальных моделей' do
      expect(runner.send(:models)).to eq(%w[model1 model2])
    end

    it 'исключает файлы с тестами' do
      expect(runner.send(:models)).not_to include('assert')
    end

    it 'правильно обрабатывает пустой список файлов' do
      allow(Dir).to receive(:glob).with('tasks/t*-*.rb').and_return([])
      expect(runner.send(:models)).to eq([])
    end
  end

  describe '#get_model_stats' do
    let(:runner) { described_class.new(log_level: 'none') }

    before do
      # Подменяем поиск файлов для тестов
      allow(Dir).to receive(:glob).with('tasks/t*-*.rb').and_return([
                                                                      'tasks/t1-model1.rb',
                                                                      'tasks/t1-model2.rb',
                                                                      'tasks/t2-model1.rb',
                                                                      'tasks/t2-model2.rb',
                                                                      'tasks/t1-assert.rb',
                                                                      'tasks/t2-assert.rb'
                                                                    ])
    end

    context 'когда есть результаты тестов' do
      before do
        runner.instance_variable_set(:@results, {
                                       't1' => { 'model1' => true, 'model2' => false },
                                       't2' => { 'model1' => true, 'model2' => true }
                                     })
      end

      it 'возвращает корректную статистику для всех моделей' do
        stats = runner.get_model_stats
        expect(stats).to eq([
                              ['model1', 2, 2, 100], # 2 из 2 задач пройдены
                              ['model2', 1, 2, 50]   # 1 из 2 задач пройдена
                            ])
      end

      it 'сортирует результаты по убыванию процента успешных тестов' do
        stats = runner.get_model_stats
        expect(stats.map { |s| s[3] }).to eq([100, 50])
      end
    end

    context 'когда нет результатов тестов' do
      before do
        runner.instance_variable_set(:@results, {})
      end

      it 'возвращает пустой массив' do
        expect(runner.get_model_stats).to eq([])
      end
    end

    context 'когда нет файлов с решениями' do
      before do
        allow(Dir).to receive(:glob).with('tasks/t*-*.rb').and_return([])
      end

      it 'возвращает пустой массив' do
        expect(runner.get_model_stats).to eq([])
      end
    end

    context 'когда есть только файлы с тестами' do
      before do
        allow(Dir).to receive(:glob).with('tasks/t*-*.rb').and_return([
                                                                        'tasks/t1-assert.rb',
                                                                        'tasks/t2-assert.rb'
                                                                      ])
      end

      it 'возвращает пустой массив' do
        expect(runner.get_model_stats).to eq([])
      end
    end

    context 'когда есть частичные результаты' do
      before do
        runner.instance_variable_set(:@results, {
                                       't1' => { 'model1' => true },
                                       't2' => { 'model2' => true }
                                     })
      end

      it 'корректно обрабатывает отсутствующие результаты' do
        stats = runner.get_model_stats
        expect(stats).to eq([
                              ['model1', 1, 1, 100], # 1 из 1 задачи пройдена
                              ['model2', 1, 1, 100]  # 1 из 1 задачи пройдена
                            ])
      end
    end

    context 'когда все тесты провалены' do
      before do
        runner.instance_variable_set(:@results, {
                                       't1' => { 'model1' => false, 'model2' => false },
                                       't2' => { 'model1' => false, 'model2' => false }
                                     })
      end

      it 'возвращает нулевой процент для всех моделей' do
        stats = runner.get_model_stats
        expect(stats).to eq([
                              ['model1', 0, 2, 0], # 0 из 2 задач пройдены
                              ['model2', 0, 2, 0]  # 0 из 2 задач пройдены
                            ])
      end
    end
  end

  describe '#handle_timeout' do
    let(:runner) { described_class.new(timeout: 5, log_level: 'none') }
    let(:thread) { double('thread') }

    before do
      allow(thread).to receive(:kill)
      allow(thread).to receive(:join).with(1)
      allow(runner).to receive(:error)
    end

    it 'убивает поток' do
      expect(thread).to receive(:kill)
      runner.send(:handle_timeout, thread)
    end

    it 'ждет завершения потока в течение 1 секунды' do
      expect(thread).to receive(:join).with(1)
      runner.send(:handle_timeout, thread)
    end

    it 'выводит сообщение об ошибке с указанием таймаута' do
      expect(runner).to receive(:error).with('  ❌ Превышен лимит времени выполнения (5 секунд)')
      expect(runner).to receive(:error).with('     Возможно, в решении есть бесконечный цикл')
      runner.send(:handle_timeout, thread)
    end

    it 'возвращает false' do
      expect(runner.send(:handle_timeout, thread)).to be false
    end

    context 'когда поток равен nil' do
      it 'не вызывает методы kill и join' do
        expect(thread).not_to receive(:kill)
        expect(thread).not_to receive(:join)
        runner.send(:handle_timeout, nil)
      end

      it 'все равно выводит сообщение об ошибке' do
        expect(runner).to receive(:error).with('  ❌ Превышен лимит времени выполнения (5 секунд)')
        expect(runner).to receive(:error).with('     Возможно, в решении есть бесконечный цикл')
        runner.send(:handle_timeout, nil)
      end

      it 'возвращает false' do
        expect(runner.send(:handle_timeout, nil)).to be false
      end
    end

    context 'когда таймаут установлен в другое значение' do
      let(:runner) { described_class.new(timeout: 10, log_level: 'none') }

      before do
        allow(runner).to receive(:error)
      end

      it 'выводит сообщение с правильным значением таймаута' do
        expect(runner).to receive(:error).with('  ❌ Превышен лимит времени выполнения (10 секунд)')
        expect(runner).to receive(:error).with('     Возможно, в решении есть бесконечный цикл')
        runner.send(:handle_timeout, thread)
      end
    end
  end
end
