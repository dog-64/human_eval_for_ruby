# Human Eval Solver

Инструмент для решения задач из набора HumanEval с помощью различных языковых моделей через OpenRouter.ai.

## Возможности

- Решение задач тестовых задачь Ргьфт Цфеср с помощью различных языковых моделей
- Автоматическое тестирование решений
- Сравнительный анализ эффективности моделей
- Поддержка сохранения промежуточных результатов
- Подробная статистика по каждой модели

## Текущий рейтинг

| Модель                            | Успешность |
|-----------------------------------|------------|
| google_gemini_2_0_flash_001       | 86%        |
| openai_o3_mini_high               | 84%        |
| deepseek_deepseek_chat_free       | 79%        |
| google_gemini_2_0_flash_lite_001  | 79%        |
| deepseek_deepseek_chat            | 77%        |
| openai_gpt_4o_mini                | 76%        |
| google_gemini_flash_1_5           | 75%        |
| mistralai_codestral_2501          | 75%        |
| qwen_qwen_2_5_coder_32b_instruct  | 74%        |
| meta_llama_llama_3_1_70b_instruct | 69%        |

## Установка

```bash
git clone https://github.com/dog-64/human_watch_ruby
cd human_watch_ruby
bundle install
```

## Рейтинг

- google_gemini_2_0_flash_001: 86%
- openai_o3_mini_high: 84%
- deepseek_deepseek_chat_free: 79%
- google_gemini_2_0_flash_lite_001: 79%
- deepseek_deepseek_chat: 77%
- openai_gpt_4o_mini: 76%
- google_gemini_flash_1_5: 75%
- mistralai_codestral_2501: 75%
- qwen_qwen_2_5_coder_32b_instruct: 74%
- meta_llama_llama_3_1_70b_instruct: 69%

[Этот рейтинг](reports/human_watch_ruby_report_total.md).
[Подробный отчет](reports/human_watch_ruby_report_full.md).

## Настройка

1. Создайте файл `.env` в корневой директории проекта
2. Добавьте ваш API ключ OpenRouter:

```bash
OPENROUTER_API_KEY=your_api_key_here
```

## Использование

### Получение решений от моделей

```bash
# Решение всех задач конкретной моделью
./bin/human_eval_solver solve tasks --model "MODEL_NAME"

# Сохранение промежуточных результатов
./bin/human_eval_solver solve tasks --model "MODEL_NAME" --keep-existing

# Включение подробного логирования
./bin/human_eval_solver solve tasks --model "MODEL_NAME" --log-level debug
```

Доступные модели:

- deepseek/deepseek-chat
- deepseek/deepseek-chat:free
- google/gemini-2.0-flash-001
- google/gemini-2.0-flash-lite-001
- google/gemini-flash-1.5
- meta-llama/llama-3.1-70b-instruct
- qwen/qwen-2.5-coder-32b
- qwen/qwen-2.5-coder-32b-instruct:free
- mistralai/codestral-2501
- openai/gpt-4o-mini
- openai/o3-mini-high
- anthropic/claude-3.5-sonnet

### Запуск тестов

```bash
# Запуск всех тестов
./bin/run_tests all

# Тесты для конкретной задачи
./bin/run_tests task t1

# Тесты для конкретной задачи и модели
./bin/run_tests model t1 qwen

# С подробным логированием
./bin/run_tests all --log-level debug
```

Уровни логирования:

- `none` - без логов
- `normal` - стандартный уровень (по умолчанию)
- `debug` - подробное логирование

## Структура проекта

- `tasks/` - задачи и решения
    - `t*.md` - описания задач
    - `t*-assert.rb` - тесты для задач
    - `t*-MODEL_NAME.rb` - решения от моделей
- `lib/` - исходный код
    - `human_eval_solver.rb` - основной класс для работы с моделями
    - `test_runner.rb` - система тестирования
    - `assert.rb` - модуль для тестовых утверждений
- `rules/` - правила и промпты для моделей
- `bin/` - исполняемые скрипты

## Текущий рейтинг моделей

[Таблица с результатами]

## Лицензия

MIT
