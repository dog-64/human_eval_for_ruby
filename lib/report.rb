require_relative 'report/generator'
require_relative 'report/runner'
require_relative 'report/cli'

# Модуль для генерации отчетов о результатах тестирования
# Предоставляет классы для загрузки данных, генерации отчетов
# в различных форматах и взаимодействия через CLI
module Report
  # Хелпер-метод для запуска CLI с переданными аргументами
  # @param args [Array<String>] массив аргументов командной строки
  # @yield блок, который будет выполнен после запуска CLI, если он предоставлен
  # @return [void]
  # @example Запуск генерации отчетов из кода
  #   Report.cli(['generate', '--output-dir=reports'])
  # @example Запуск с блоком
  #   Report.cli(['generate']) do |result|
  #     puts "Генерация отчетов #{result ? 'успешна' : 'не удалась'}"
  #   end
  def self.cli(args = [])
    result = CLI.start(args)
    yield(result) if block_given?
    result
  end
end
