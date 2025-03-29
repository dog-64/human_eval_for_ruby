require 'spec_helper'
require_relative '../lib/models'

RSpec.describe Models do
  let(:config_path) { 'spec/fixtures/test_models.yml' }
  let(:models) { described_class.new(config_path) }

  before do
    # Создаем временный файл конфигурации для тестов
    FileUtils.mkdir_p(File.dirname(config_path))

    test_config = {
      'openrouter' => {
        'test_model1' => {
          'name' => 'test/model1',
          'provider' => 'openrouter.ai'
        }
      },
      'ollama' => {
        'test_ollama_model' => {
          'name' => 'test_ollama',
          'provider' => 'ollama',
          'note' => 'тестовая модель'
        }
      }
    }

    File.write(config_path, test_config.to_yaml)
  end

  after do
    # Удаляем временный файл
    FileUtils.rm_f(config_path)
  end

  describe '#initialize' do
    it 'использует путь по умолчанию, если не указан путь к конфигурации' do
      default_models = described_class.new
      expect(default_models.instance_variable_get(:@config_path)).to eq(described_class::MODELS_CONFIG_PATH)
    end

    it 'использует указанный путь к конфигурации' do
      custom_models = described_class.new('custom/path.yml')
      expect(custom_models.instance_variable_get(:@config_path)).to eq('custom/path.yml')
    end
  end

  describe '#all' do
    it 'загружает все модели из YAML файла' do
      all_models = models.all
      expect(all_models).to be_a(Hash)
      expect(all_models.keys).to include('test_model1', 'test_ollama_model')
      expect(all_models['test_model1']).to eq({
                                                'name' => 'test/model1',
                                                'provider' => 'openrouter.ai'
                                              })
      expect(all_models['test_ollama_model']).to eq({
                                                      'name' => 'test_ollama',
                                                      'provider' => 'ollama',
                                                      'note' => 'тестовая модель'
                                                    })
    end

    it 'кэширует результат при повторном вызове' do
      expect(YAML).to receive(:load_file).once.and_call_original
      models.all
      models.all # Второй вызов должен использовать кэш
    end

    it 'обрабатывает пустые секции в конфигурации' do
      empty_config_path = 'spec/fixtures/empty_sections.yml'
      FileUtils.mkdir_p(File.dirname(empty_config_path))

      empty_config = {
        'openrouter' => {},
        'ollama' => {}
      }

      File.write(empty_config_path, empty_config.to_yaml)

      begin
        empty_models = described_class.new(empty_config_path)
        expect(empty_models.all).to eq({})
        expect(empty_models.ollama).to eq([])
        expect(empty_models.openrouter).to eq([])
      ensure
        FileUtils.rm_f(empty_config_path)
      end
    end

    it 'генерирует ошибку при отсутствии файла конфигурации' do
      invalid_models = described_class.new('non_existent_file.yml')
      expect { invalid_models.all }.to raise_error(/Конфигурационный файл не найден/)
    end

    it 'генерирует ошибку при некорректном формате YAML' do
      invalid_yaml_path = 'spec/fixtures/invalid.yml'
      FileUtils.mkdir_p(File.dirname(invalid_yaml_path))

      # Создаем некорректный YAML файл
      File.write(invalid_yaml_path,
                 "openrouter:\n  " \
                 "test_model1:\n    " \
                 "name: 'test/model1'\n    " \
                 "provider: 'openrouter.ai'\n  " \
                 "invalid:\n      " \
                 'indentation')

      begin
        invalid_models = described_class.new(invalid_yaml_path)
        expect { invalid_models.all }.to raise_error(/Ошибка при загрузке конфигурации моделей/)
      ensure
        FileUtils.rm_f(invalid_yaml_path)
      end
    end
  end

  describe '#get' do
    it 'возвращает информацию о конкретной модели' do
      model_info = models.get('test_model1')
      expect(model_info).to eq({
                                 'name' => 'test/model1',
                                 'provider' => 'openrouter.ai'
                               })
    end

    it 'возвращает nil для несуществующей модели' do
      expect(models.get('non_existent_model')).to be_nil
    end
  end

  describe '#ollama' do
    it 'возвращает список моделей Ollama' do
      expect(models.ollama).to eq(['test_ollama_model'])
    end

    it 'возвращает пустой массив, если нет моделей Ollama' do
      only_openrouter_config_path = 'spec/fixtures/only_openrouter.yml'
      FileUtils.mkdir_p(File.dirname(only_openrouter_config_path))

      config = {
        'openrouter' => {
          'test_model1' => {
            'name' => 'test/model1',
            'provider' => 'openrouter.ai'
          }
        },
        'ollama' => {}
      }

      File.write(only_openrouter_config_path, config.to_yaml)

      begin
        only_openrouter_models = described_class.new(only_openrouter_config_path)
        expect(only_openrouter_models.ollama).to eq([])
      ensure
        FileUtils.rm_f(only_openrouter_config_path)
      end
    end
  end

  describe '#openrouter' do
    it 'возвращает список моделей OpenRouter' do
      expect(models.openrouter).to eq(['test_model1'])
    end

    it 'возвращает пустой массив, если нет моделей OpenRouter' do
      only_ollama_config_path = 'spec/fixtures/only_ollama.yml'
      FileUtils.mkdir_p(File.dirname(only_ollama_config_path))

      config = {
        'openrouter' => {},
        'ollama' => {
          'test_ollama_model' => {
            'name' => 'test_ollama',
            'provider' => 'ollama'
          }
        }
      }

      File.write(only_ollama_config_path, config.to_yaml)

      begin
        only_ollama_models = described_class.new(only_ollama_config_path)
        expect(only_ollama_models.openrouter).to eq([])
      ensure
        FileUtils.rm_f(only_ollama_config_path)
      end
    end
  end

  describe '#openrouter_api_key' do
    before do
      # Сохраняем текущее значение переменной окружения
      @original_key = ENV.fetch('OPENROUTER_API_KEY', nil)
      ENV['OPENROUTER_API_KEY'] = 'test_key'
    end

    after do
      # Восстанавливаем оригинальное значение
      ENV['OPENROUTER_API_KEY'] = @original_key
    end

    it 'возвращает API ключ из переменных окружения' do
      expect(models.openrouter_api_key).to eq('test_key')
    end

    it 'возвращает nil, если ключ не установлен' do
      ENV['OPENROUTER_API_KEY'] = nil
      expect(models.openrouter_api_key).to be_nil
    end
  end

  describe '#openrouter_available?' do
    context 'когда API ключ установлен' do
      before do
        allow(models).to receive(:openrouter_api_key).and_return('test_key')
      end

      it 'возвращает true' do
        expect(models.openrouter_available?).to be true
      end
    end

    context 'когда API ключ не установлен' do
      before do
        allow(models).to receive(:openrouter_api_key).and_return(nil)
      end

      it 'возвращает false' do
        expect(models.openrouter_available?).to be false
      end
    end

    it 'использует значение из метода openrouter_api_key' do
      expect(models).to receive(:openrouter_api_key).and_return('some_key')
      expect(models.openrouter_available?).to be true

      expect(models).to receive(:openrouter_api_key).and_return(nil)
      expect(models.openrouter_available?).to be false
    end
  end
end
