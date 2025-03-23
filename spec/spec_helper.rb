# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/' # исключаем тесты из отчета
  add_filter '/vendor/'
  enable_coverage :branch # включаем анализ покрытия веток
  minimum_coverage ENV.fetch('MIN_COVERAGE', 30).to_i

  # Добавляем группы файлов
  add_group 'Library', 'lib'
  add_group 'CLI', 'lib/test_runner_cli.rb'
  add_group 'Runner', 'lib/test_runner.rb'
  add_group 'Reports', 'lib/human_eval/reports'
end

require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'pry'
require 'pry-byebug'
require 'fileutils'

require_relative '../lib/test_runner'
require_relative '../lib/human_eval/solver'
require_relative '../lib/assert'
require_relative '../lib/human_eval_converter'
require_relative '../lib/human_eval/reports'
require_relative '../lib/human_eval/reports/generator'
require_relative '../lib/human_eval/reports/cli'

WebMock.enable!
WebMock.disable_net_connect!

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random
  Kernel.srand config.seed

  config.before(:each) do
    WebMock.reset!
  end
end
