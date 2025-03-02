# Human Eval Converter

Инструмент для конвертации задач из формата human-eval в отдельные задачи.

## Установка

```bash
git clone <repository-url>
cd human-eval-converter
bundle install
```

## Использование

### Быстрый старт
```bash
# Базовая конвертация
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks

# Первый запуск с созданием правил
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --create-rules

# Добавление новых задач с сохранением существующих
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --keep-existing

# Комбинация опций (если нужно)
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --create-rules --keep-existing
```

### Опции

- `--create-rules` - Создать каталог rules с файлами промптов (только при первом запуске)
- `-k, --keep-existing` - Сохранять существующие файлы (не перезаписывать)

### Справка по использованию
```bash
./bin/human_eval_converter help convert
```

## Структура выходных данных

Для каждой задачи создается отдельная директория в каталоге `tasks`, содержащая:
- `README.md` - описание задачи
- `test_check.rb` - файл с тестами
- `t{task_id}.jsonl` - исходная строка в формате JSONL
- `t{task_id}.json` - отформатированный JSON

При использовании опции `--create-rules` создается директория `rules` со следующими файлами:
- `description_prompt.txt` - промпт для генерации описания
- `assertions_prompt.txt` - промпт для генерации проверок

## Разработка

```bash
# Запуск тестов
bundle exec rspec

# Запуск линтера
bundle exec rubocop
```