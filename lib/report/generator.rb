require 'json'
require 'fileutils'
require 'erb'
require_relative '../model/to_path'
require_relative '../models'

module Report
  # Класс Generator создает отчеты о результатах тестирования в различных форматах
  # Генерирует HTML и Markdown отчеты, сохраняет результаты в JSON,
  # обновляет README и создает сводные и детальные представления результатов
  class Generator
    TEMPLATES_DIR = File.expand_path('templates', __dir__)

    def initialize(results, reports_dir: 'reports')
      @results = results
      @reports_dir = reports_dir
      FileUtils.mkdir_p(@reports_dir)
      @models_manager = Models.new
    end

    def generate_all
      save_json
      create_html_reports
      create_markdown
      update_readme
    end

    private

    def save_json
      File.write(File.join(@reports_dir, 'test_results.json'), JSON.pretty_generate({
                                                                                      timestamp: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
                                                                                      models: @results[:model_stats],
                                                                                      tasks: @results[:task_results]
                                                                                    }))
    end

    def create_html_reports
      css = load_css
      create_total_html(css)
      create_full_html(css)
    end

    def create_markdown
      content = "## Рейтинг\n\n"
      @results[:model_stats].each do |model_stat|
        model, passed, total, percentage = model_stat
        content += "- #{format_model_name(model)}: #{passed}/#{total} (#{percentage}%)\n"
      end
      File.write(File.join(@reports_dir, 'total.md'), content)
    end

    def update_readme
      readme_path = File.join(@reports_dir, 'README.md')
      return unless File.exist?(readme_path)

      total_md_path = File.join(@reports_dir, 'total.md')
      return unless File.exist?(total_md_path)

      # Читаем содержимое обоих файлов
      readme_content = File.read(readme_path)
      total_content = File.read(total_md_path)

      # Удаляем заголовок из total.md, чтобы оставить только содержимое секции
      total_content_without_header = total_content.sub(/^## Рейтинг\s*\n+/, '')

      # Используем другой вариант замены, который показал себя стабильно в тестах
      pattern = /(# .+?\n\n## Рейтинг\n).+?(\n\n## |\z)/m

      new_readme_content = readme_content.gsub(pattern) do |_match|
        result = "#{::Regexp.last_match(1)}#{total_content_without_header}#{::Regexp.last_match(2)}"
        result
      end

      # Запасной вариант - если регулярные выражения не сработали
      if new_readme_content == readme_content
        # Попробуем простую замену содержимого
        rating_section_begin = readme_content.index("## Рейтинг\n")
        next_section_begin = readme_content.index("\n\n##", rating_section_begin) if rating_section_begin

        if rating_section_begin && next_section_begin
          new_readme_content = readme_content[0...rating_section_begin] +
                               "## Рейтинг\n\n#{total_content_without_header}" +
                               readme_content[next_section_begin..]
        else
          # Если и этот способ не сработал, попробуем прямую замену
          section_pattern = /## Рейтинг.*?((?=\n##|\z))/m
          new_readme_content = readme_content.sub(section_pattern, "## Рейтинг\n\n#{total_content_without_header}")
        end
      end

      # Сохраняем обновленный README.md только если он изменился
      return unless new_readme_content != readme_content

      File.write(readme_path, new_readme_content)
    end

    def add_soft_hyphens(text)
      text.gsub('_', '_&shy;')
    end

    # Форматирует имя модели в человекочитаемый формат
    def format_model_name(model_name)
      readable_name = Model::ToPath.from_path(model_name.to_s, @models_manager)
      add_soft_hyphens(readable_name)
    end

    def find_solution_files(task = nil)
      pattern = task ? "#{task}_solution.rb" : '*_solution.rb'
      Dir.glob(File.join(@reports_dir, 'solutions', '**', pattern))
    end

    def load_css
      css_path = File.join(TEMPLATES_DIR, 'css', 'report.css')
      File.read(css_path)
    end

    def create_total_html(css)
      template_path = File.join(TEMPLATES_DIR, 'total.html.erb')
      template = ERB.new(File.read(template_path))

      timestamp = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      # Преобразуем имена моделей в читаемый формат
      model_stats = @results[:model_stats].map do |model_stat|
        model_stat = model_stat.dup
        model_stat[0] = format_model_name(model_stat[0])
        model_stat
      end

      html = template.result(binding)

      File.write(File.join(@reports_dir, 'human_eval_for_ruby_report_total.html'), html)
    end

    def create_full_html(css)
      template_path = File.join(TEMPLATES_DIR, 'full.html.erb')
      template = ERB.new(File.read(template_path))

      timestamp = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      # Преобразуем имена моделей в читаемый формат для отображения
      model_stats = @results[:model_stats].map do |model_stat|
        model_stat = model_stat.dup
        model_stat[0] = format_model_name(model_stat[0])
        model_stat
      end

      # Преобразуем ключи моделей в читаемый формат и обновляем результаты задач
      readable_task_results = {}
      @results[:task_results].each do |task, results|
        readable_task_results[task] = {}
        results.each do |model, success|
          readable_task_results[task][format_model_name(model)] = success
        end
      end

      task_results = readable_task_results
      # Получаем массив имен моделей в читаемом формате
      models = task_results.values.first&.keys || []

      html = template.result(binding)

      File.write(File.join(@reports_dir, 'human_eval_for_ruby_report_full.html'), html)
    end
  end
end
