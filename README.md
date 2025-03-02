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

### Примеры использования

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
```