# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'
require 'tmpdir'

RSpec.describe HumanEval::SolverClass do
  let(:tasks_dir) { Dir.mktmpdir }
  let(:task_data) do
    {
      task_id: 't1',
      prompt: 'Write a function that adds two numbers',
      entry_point: 'add',
      canonical_solution: "def add(a, b)\n  a + b\nend",
      test: 'assert_equal(4, add(2, 2))'
    }
  end
  let(:solver_prompt) { 'You are a helpful assistant that solves programming tasks.' }
  let(:task_json) { task_data.to_json }
  let(:parsed_task_data) { JSON.parse(task_json) }

  before(:each) do
    ENV['OPENROUTER_API_KEY'] = 'test_key'
    ENV['HTTP_REFERER'] = 'https://github.com/yourusername/human-eval-solver'
    ENV['X_TITLE'] = 'Human Eval Solver'
    ENV['OPENAI_ORGANIZATION'] = 'openrouter'
    ENV['USER_AGENT'] = 'Human Eval Solver/1.0.0'
    ENV['COLUMNS'] = '80'
    ENV['AI_MODEL'] = 'anthropic/claude-3.5-sonnet'

    # Создаем временную директорию и файл задачи
    @temp_dir = Dir.mktmpdir
    File.write(File.join(@temp_dir, 't1.json'), task_json)

    # Разрешаем чтение файлов
    allow(File).to receive(:read).and_call_original
    allow(File).to receive(:read).with(File.join('rules', 'solver_prompt.txt')).and_return(solver_prompt)
    allow(Dir).to receive(:[]).with(File.join(@temp_dir, 't*.json')).and_return([File.join(@temp_dir, 't1.json')])
  end

  after(:each) do
    FileUtils.remove_entry(@temp_dir) if @temp_dir && Dir.exist?(@temp_dir)
  end

  describe 'OpenRouter.ai model' do
    let(:solver) { described_class.new(@temp_dir, model: 'anthropic_claude_3_5_sonnet') }

    before do
      stub_request(:post, "https://openrouter.ai/api/v1/chat/completions").
        with(
          body: {
            model: "anthropic/claude-3.5-sonnet",
            messages: [{
              role: 'user',
              content: "#{solver_prompt}\n\n#{parsed_task_data}\n"
            }],
            temperature: 0.1,
            max_tokens: 1000,
            stream: false
          }.to_json,
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer test_key',
            'Content-Type' => 'application/json',
            'Host' => 'openrouter.ai',
            'Http-Referer' => 'https://github.com/yourusername/human-eval-solver',
            'Openai-Organization' => 'openrouter',
            'User-Agent' => 'Human Eval Solver/1.0.0',
            'X-Title' => 'Human Eval Solver'
          }
        ).
        to_return(status: 200, body: { choices: [{ message: { content: "Here's a solution:\n\n```ruby\ndef add(a, b)\n  a + b\nend\n```" } }] }.to_json)
    end

    it 'processes task with OpenRouter model successfully' do
      solver.process

      solution_file = File.join(@temp_dir, 't1-anthropic_claude_3_5_sonnet.rb')
      expect(File.exist?(solution_file)).to be true

      solution_content = File.read(solution_file)
      expect(solution_content).to include('def add(a, b)')
      expect(solution_content).to include('a + b')
    end
  end

  describe 'Ollama model' do
    let(:solver) { described_class.new(@temp_dir, model: 'ollama_codellama') }

    before do
      stub_request(:post, "http://localhost:11434/api/chat").
        with(
          body: {
            model: "codellama",
            messages: [{
              role: 'user',
              content: "#{solver_prompt}\n\n#{parsed_task_data}\n"
            }],
            stream: false,
            options: {
              temperature: 0.1,
              num_predict: 4096
            }
          }.to_json,
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'Host' => 'localhost:11434',
            'User-Agent' => 'Ruby'
          }
        ).
        to_return(status: 200, body: { message: { content: "Here's a solution:\n\n```ruby\ndef add(a, b)\n  return a + b\nend\n```" } }.to_json)
    end

    it 'processes task with Ollama model successfully' do
      solver.process

      solution_file = File.join(@temp_dir, 't1-ollama_codellama.rb')
      expect(File.exist?(solution_file)).to be true

      solution_content = File.read(solution_file)
      expect(solution_content).to include('def add(a, b)')
      expect(solution_content).to include('return a + b')
    end
  end

  describe 'Error handling' do
    let(:solver) { described_class.new(@temp_dir, model: 'anthropic_claude_3_5_sonnet') }

    context 'when API returns an error' do
      before do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions").
          with(
            body: {
              model: "anthropic/claude-3.5-sonnet",
              messages: [{
                role: 'user',
                content: "#{solver_prompt}\n\n#{parsed_task_data}\n"
              }],
              temperature: 0.1,
              max_tokens: 1000,
              stream: false
            }.to_json,
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer test_key',
              'Content-Type' => 'application/json',
              'Host' => 'openrouter.ai',
              'Http-Referer' => 'https://github.com/yourusername/human-eval-solver',
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Solver/1.0.0',
              'X-Title' => 'Human Eval Solver'
            }
          ).
          to_return(status: 500, body: 'Internal Server Error')
      end

      it 'handles API errors gracefully' do
        expect { solver.process }.to raise_error(RuntimeError, /Ошибка API при вызове модели anthropic\/claude-3\.5-sonnet/)
      end
    end

    context 'when API returns empty response' do
      before do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions").
          with(
            body: {
              model: "anthropic/claude-3.5-sonnet",
              messages: [{
                role: 'user',
                content: "#{solver_prompt}\n\n#{parsed_task_data}\n"
              }],
              temperature: 0.1,
              max_tokens: 1000,
              stream: false
            }.to_json,
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer test_key',
              'Content-Type' => 'application/json',
              'Host' => 'openrouter.ai',
              'Http-Referer' => 'https://github.com/yourusername/human-eval-solver',
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Solver/1.0.0',
              'X-Title' => 'Human Eval Solver'
            }
          ).
          to_return(status: 200, body: { choices: [{ message: { content: '' } }] }.to_json)
      end

      it 'handles empty responses gracefully' do
        expect { solver.process }.to raise_error(RuntimeError, 'Пустой ответ от API')
      end
    end
  end
end
