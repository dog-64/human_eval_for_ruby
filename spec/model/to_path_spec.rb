require 'spec_helper'
require_relative '../../lib/model/to_path'
require_relative '../../lib/models'

RSpec.describe Model::ToPath do
  describe '.to_path' do
    it 'преобразует имя модели с символами / в формат пути' do
      expect(described_class.to_path('deepseek/deepseek-chat')).to eq('deepseek_deepseek_chat')
    end

    it 'преобразует имя модели с дефисами в формат пути' do
      expect(described_class.to_path('model-name')).to eq('model_name')
    end

    it 'преобразует имя модели с двоеточием в формат пути' do
      expect(described_class.to_path('model:tag')).to eq('model_tag')
    end

    it 'преобразует полное имя модели с несколькими специальными символами' do
      expect(described_class.to_path('deepseek/deepseek-chat:free')).to eq('deepseek_deepseek_chat_free')
    end

    it 'возвращает nil для nil' do
      expect(described_class.to_path(nil)).to be_nil
    end

    it 'возвращает пустую строку для пустой строки' do
      expect(described_class.to_path('')).to eq('')
    end
  end
  
  describe '.from_path' do
    let(:models_manager) { instance_double('Models') }
    let(:models_data) do
      {
        'deepseek_deepseek_chat_free' => {
          'name' => 'deepseek/deepseek-chat:free',
          'provider' => 'openrouter.ai'
        },
        'google_gemini_flash_1_5' => {
          'name' => 'google/gemini-flash-1.5',
          'provider' => 'openrouter.ai'
        }
      }
    end

    before do
      allow(models_manager).to receive(:all).and_return(models_data)
      allow(models_manager).to receive(:get).with('deepseek_deepseek_chat_free').and_return(models_data['deepseek_deepseek_chat_free'])
      allow(models_manager).to receive(:get).with('google_gemini_flash_1_5').and_return(models_data['google_gemini_flash_1_5'])
      allow(models_manager).to receive(:class).and_return(double(name: 'Models'))
    end
    
    it 'возвращает nil для nil' do
      expect(described_class.from_path(nil)).to be_nil
    end
    
    it 'возвращает исходное имя, если оно уже содержит / или -' do
      expect(described_class.from_path('deepseek/deepseek-chat')).to eq('deepseek/deepseek-chat')
      expect(described_class.from_path('model-name')).to eq('model-name')
    end
    
    it 'ищет модель в конфигурации и возвращает её оригинальное имя, если найдено' do
      allow(described_class).to receive(:find_model_key_by_path).with('deepseek_deepseek_chat_free', models_manager).and_return('deepseek_deepseek_chat_free')
      expect(described_class.from_path('deepseek_deepseek_chat_free', models_manager)).to eq('deepseek/deepseek-chat:free')
    end
    
    it 'применяет алгоритмическое форматирование, если модель не найдена в конфигурации' do
      allow(described_class).to receive(:find_model_key_by_path).with('google_gemini_2_5_pro_exp_03_25_free', models_manager).and_return(nil)
      expect(described_class.from_path('google_gemini_2_5_pro_exp_03_25_free', models_manager)).to eq('google/gemini-2-5-pro-exp-03-25:free')
    end
    
    it 'возвращает исходное имя, если алгоритмическое форматирование невозможно' do
      expect(described_class.from_path('single', models_manager)).to eq('single')
    end
  end

  describe '.from_file_path' do
    let(:models_manager) { instance_double('Models') }
    let(:models_data) do
      {
        'deepseek_deepseek_chat_free' => {
          'name' => 'deepseek/deepseek-chat:free',
          'provider' => 'openrouter.ai'
        },
        'google_gemini_flash_1_5' => {
          'name' => 'google/gemini-flash-1.5',
          'provider' => 'openrouter.ai'
        }
      }
    end

    before do
      allow(models_manager).to receive(:all).and_return(models_data)
      allow(models_manager).to receive(:get).with('deepseek_deepseek_chat_free').and_return(models_data['deepseek_deepseek_chat_free'])
      allow(models_manager).to receive(:get).with('google_gemini_flash_1_5').and_return(models_data['google_gemini_flash_1_5'])
      
      # Необходимо для тестового режима
      allow(ENV).to receive(:[]).with('RACK_ENV').and_return(nil)
      allow(models_manager).to receive(:class).and_return(double(name: 'Models'))
    end

    it 'получает оригинальное имя модели по пути к файлу' do
      result = described_class.from_file_path('tasks/t1-deepseek_deepseek_chat_free.rb', models_manager)
      expect(result).to eq('deepseek/deepseek-chat:free')
    end

    it 'возвращает имя из пути, если в конфигурации нет соответствующей модели' do
      allow(described_class).to receive(:find_model_key_by_path).with('unknown_model', models_manager).and_return(nil)
      allow(described_class).to receive(:from_path).with('unknown_model', models_manager).and_return('unknown/model')
      result = described_class.from_file_path('tasks/t1-unknown_model.rb', models_manager)
      expect(result).to eq('unknown/model')
    end

    it 'возвращает nil, если путь к файлу или менеджер моделей nil' do
      expect(described_class.from_file_path(nil, models_manager)).to be_nil
      expect(described_class.from_file_path('tasks/t1-model.rb', nil)).to be_nil
    end
    
    context 'в тестовом окружении' do
      before do
        allow(ENV).to receive(:[]).with('RACK_ENV').and_return('test')
      end
      
      it 'возвращает имя модели из пути без обращения к менеджеру моделей' do
        # Даже если models_manager вернет nil, функция должна вернуть имя из пути
        allow(models_manager).to receive(:all).and_raise("Этот метод не должен вызываться")
        allow(models_manager).to receive(:get).and_raise("Этот метод не должен вызываться")
        
        # Обратите внимание, что мы просто передаем имя пути в from_path
        allow(described_class).to receive(:from_path).with('deepseek_deepseek_chat_free', models_manager).and_return('deepseek/deepseek-chat:free')
        
        result = described_class.from_file_path('tasks/t1-deepseek_deepseek_chat_free.rb', models_manager)
        expect(result).to eq('deepseek/deepseek-chat:free')
      end
    end
  end

  describe '.find_model_key_by_path' do
    let(:models_manager) { instance_double('Models') }
    let(:models_data) do
      {
        'deepseek_deepseek_chat_free' => {
          'name' => 'deepseek/deepseek-chat:free',
          'provider' => 'openrouter.ai'
        },
        'google_gemini_flash_1_5' => {
          'name' => 'google/gemini-flash-1.5',
          'provider' => 'openrouter.ai'
        }
      }
    end

    before do
      allow(models_manager).to receive(:all).and_return(models_data)
      
      # Необходимо для тестового режима
      allow(ENV).to receive(:[]).with('RACK_ENV').and_return(nil)
      allow(models_manager).to receive(:class).and_return(double(name: 'Models'))
    end

    it 'находит ключ модели по имени пути' do
      result = described_class.find_model_key_by_path('deepseek_deepseek_chat_free', models_manager)
      expect(result).to eq('deepseek_deepseek_chat_free')
    end

    it 'возвращает nil, если модель не найдена' do
      result = described_class.find_model_key_by_path('unknown_model', models_manager)
      expect(result).to be_nil
    end
    
    context 'в тестовом окружении' do
      before do
        allow(ENV).to receive(:[]).with('RACK_ENV').and_return('test')
      end
      
      it 'всегда возвращает nil без обращения к менеджеру моделей' do
        allow(models_manager).to receive(:all).and_raise("Этот метод не должен вызываться")
        
        result = described_class.find_model_key_by_path('deepseek_deepseek_chat_free', models_manager)
        expect(result).to be_nil
      end
    end
  end
end 