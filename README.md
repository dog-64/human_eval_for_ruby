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
- `--preserve-old` - Сохранять старые файлы с временной меткой
- `--task NUMBER` - Сгенерировать только одно задание с указанным номером

### Уровни логирования

Скрипт поддерживает три уровня логирования:

- `--log-level none` - без вывода логов
- `--log-level normal` - стандартный уровень (по умолчанию)
- `--log-level debug` - подробный вывод для отладки

Примеры использования:
```bash
# Без логов
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --log-level none

# Подробный вывод для отладки
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --log-level debug

# Стандартный уровень (можно не указывать)
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --log-level normal
```

### Примеры использования конвертора

```bash
# Базовая конвертация
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks

# Генерация задания номер 0 с подробным логированием
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --task 0 --log-level debug

# Генерация задания с сохранением старых файлов и без логов
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks --task 42 --preserve-old --log-level none
```

### Структура выходных данных

Для задания 0 будут созданы файлы:
- `tasks/t0.md` - описание задачи
- `tasks/t0_asserts.rb` - файл с тестами
- `tasks/t0.jsonl` - исходная строка в формате JSONL
- `tasks/t0.json` - отформатированный JSON

### Справка по использованию

## Решение задач с помощью AI моделей

После конвертации задач с помощью `human_eval_converter`, вы можете использовать `human_eval_solver` для получения решений от различных AI моделей.

### Поддерживаемые модели
- google/gemini-flash-1.5
- google/gemini-2.0-flash-001
- openai/gpt-4o-mini
- openai/gpt-4o
- anthropic/claude-3.5-sonnet

### Использование solver

```bash
# Решить все задачи всеми моделями
./bin/human_eval_solver solve tasks

# Решить только задачу 0
./bin/human_eval_solver solve tasks --task 0

# Решить задачу 0 конкретной моделью
./bin/human_eval_solver solve tasks --task 0 --model "google/gemini-flash-1.5"

# Решить задачу 0 с подробным логированием
./bin/human_eval_solver solve tasks --task 0 --log-level debug
```

### Опции solver

- `--model MODEL` - Использовать конкретную модель (по умолчанию используются все модели)
- `--task NUMBER` - Решить только задачу с указанным номером (по умолчанию решаются все задачи)
- `--log-level LEVEL` - Уровень логирования (none/normal/debug)

### Примеры работы с одной задачей

```bash
# Получить решение задачи 0
./bin/human_eval_solver solve tasks --task 0

# Получить решение задачи 42
./bin/human_eval_solver solve tasks --task 42

# Решить задачу 0 с отладочной информацией
./bin/human_eval_solver solve tasks --task 0 --log-level debug

# Решить задачу 0 конкретной моделью
./bin/human_eval_solver solve tasks --task 0 --model "google/gemini-flash-1.5"
```

### Выходные файлы

Для каждой задачи и каждой модели создается отдельный файл с решением:
- `tasks/t0-google_gemini-flash-1_5.rb` - решение задачи 0 от модели gemini-flash-1.5
- `tasks/t0-google_gemini-2_0-flash-001.rb` - решение задачи 0 от модели gemini-2.0-flash-001
- `tasks/t0-openai_gpt-4o-mini.rb` - решение задачи 0 от модели gpt-4o-mini
- `tasks/t0-anthropic_claude-3-opus.rb` - решение задачи 0 от модели claude-3-opus
- `tasks/t0-google_gemini_flash_1_5.rb` - решение задачи 0 от модели gemini-flash-1.5
- `tasks/t0-google_gemini_2_0_flash_001.rb` - решение задачи 0 от модели gemini-2.0-flash-001
- `tasks/t0-openai_gpt_4o_mini.rb` - решение задачи 0 от модели gpt-4o-mini
- `tasks/t0-anthropic_claude_3_5_sonnet.rb` - решение задачи 0 от модели claude-3.5-sonnet
и т.д.

### Порядок работы

1. Сначала конвертируйте задачи из формата human-eval:
```bash
./bin/human_eval_converter convert _src/HumanEval.jsonl tasks
```
2. Запустите решeние задачь при помощи llm
```bash
 ./bin/human_eval_solver solve tasks --model "google/gemini-2.0-flash-lite-001" 
```
