# Human Watch Ruby

Инструмент для решения задач из набора HumanEval с помощью различных языковых моделей через OpenRouter.ai и локальную Ollama.

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

## Возможности

- Решение задач тестовых задачь Ргьфт Цфеср с помощью различных языковых моделей
- Поддержка моделей через OpenRouter.ai и локальную Ollama
- Автоматическое тестирование решений
- Сравнительный анализ эффективности моделей
- Поддержка сохранения промежуточных результатов
- Подробная статистика по каждой модели

## Установка

```bash
git clone https://github.com/dog-64/human_watch_ruby
cd human_watch_ruby
bundle install
```

### Зависимости

Проект использует следующие гемы:
- `thor` - для создания интерфейса командной строки
- `terminal-table` - для форматирования таблиц в консоли
- `dotenv` - для загрузки переменных окружения из файла .env
- `pry` и `pry-byebug` - для отладки

Все зависимости указаны в `Gemfile` и устанавливаются автоматически при выполнении `bundle install`.

## Настройка

1. Создайте файл `.env` в корневой директории проекта
2. Добавьте ваш API ключ OpenRouter (для моделей OpenRouter.ai):

```bash
OPENROUTER_API_KEY=your_api_key_here
```

3. Для использования локальных моделей Ollama:
   - Установите [Ollama](https://ollama.ai/)
   - Загрузите нужные модели с помощью команды `ollama pull <model_name>`
   - При необходимости укажите URL Ollama API в файле `.env`:

```bash
OLLAMA_BASE_URL=http://localhost:11434
```

## Использование

### Получение решений от моделей

```bash
# Решение всех задач конкретной моделью
./bin/human_eval_solver solve tasks --model "MODEL_NAME"

# Решение конкретной задачи
./bin/human_eval_solver solve tasks --task t1 --model "MODEL_NAME"

# Сохранение промежуточных результатов
./bin/human_eval_solver solve tasks --model "MODEL_NAME" --keep-existing

# Включение подробного логирования
./bin/human_eval_solver solve tasks --model "MODEL_NAME" --log-level debug

# Вывод всех доступных команд и опций
./bin/human_eval_solver
```

Доступные модели:

#### OpenRouter.ai модели:

- deepseek_deepseek_chat (deepseek/deepseek-chat)
- deepseek_deepseek_chat_free (deepseek/deepseek-chat:free)
- google_gemini_2_0_flash_001 (google/gemini-2.0-flash-001)
- google_gemini_2_0_flash_lite_001 (google/gemini-2.0-flash-lite-001)
- google_gemini_flash_1_5 (google/gemini-flash-1.5)
- meta_llama_llama_3_1_70b_instruct (meta-llama/llama-3.1-70b-instruct)
- qwen_qwen_2_5_coder_32b (qwen/qwen-2.5-coder-32b)
- qwen_qwen_2_5_coder_32b_instruct (qwen/qwen-2.5-coder-32b-instruct:free)
- mistralai_codestral_2501 (mistralai/codestral-2501)
- openai_gpt_4o_mini (openai/gpt-4o-mini)
- openai_o3_mini_high (openai/o3-mini-high)
- anthropic_claude_3_5_sonnet (anthropic/claude-3.5-sonnet)

#### Локальные Ollama модели:

- ollama_llama3 (llama3)
- ollama_llama3_2 (llama3.2)
- ollama_codellama (codellama)
- ollama_mistral (mistral)
- ollama_phi3 (phi3)
- ollama_gemma (gemma)

Вы можете добавить другие модели Ollama, загрузив их с помощью команды `ollama pull <model_name>` и используя идентификатор `ollama_<model_name>`.

### Добавление новых моделей Ollama

Чтобы добавить новую модель Ollama в проект:

1. Загрузите модель с помощью команды:
   ```bash
   ollama pull <model_name>
   ```
   Например: `ollama pull llama3.2` или `ollama pull phi3`

2. Добавьте модель в список `MODELS` в файле `lib/human_eval_solver.rb`:
   ```ruby
   'ollama_<model_id>' => { name: '<model_name>', provider: 'ollama' },
   ```
   Например: `'ollama_llama3_2' => { name: 'llama3.2', provider: 'ollama' },`

3. Обновите список моделей в README.md, добавив новую модель в раздел "Локальные Ollama модели"

4. Теперь вы можете использовать модель для решения задач:
   ```bash
   ./bin/human_eval_solver solve tasks --model "ollama_<model_id>" --log-level debug
   ```

5. Для тестирования модели вы можете запустить её напрямую:
   ```bash
   ollama run <model_name>
   ```
   Это запустит интерактивный режим, где вы можете проверить работу модели.

6. Для отладки и анализа ответов модели используйте команду с подробным логированием:
   ```bash
   ./bin/human_eval_solver solve tasks --task t2 --model "ollama_codellama" --log-level debug
   ```
   Эта команда покажет:
   - Полный текст запроса к модели
   - Полный ответ от модели
   - Извлеченный код из ответа
   - Сохраненное решение
   
   Это помогает понять, почему решения модели могут быть некорректными:
   - Модель может возвращать код в неправильном формате
   - Модель может добавлять лишние комментарии или пояснения
   - Могут быть проблемы с извлечением кода из ответа

### Запуск тестов

```bash
# Запуск всех тестов
./bin/run_tests all

# Запуск тестов для конкретной задачи
./bin/run_tests task t1

# Запуск тестов для конкретной задачи и модели
./bin/run_tests model t1 ollama_llama3_2

# Запуск с подробным логированием
./bin/run_tests task t1 --log-level debug

# Запуск с выводом только сводного отчета
./bin/run_tests all --report-total

# Вывод справки по доступным командам
./bin/run_tests
# или
./bin/run_tests help
```

> **Примечание:** Скрипты `./bin/run_tests` и `./bin/human_eval_solver` автоматически используют rbenv и bundle exec, поэтому нет необходимости запускать их через `bundle exec`.

Уровни логирования:
- `none` - без логов
- `normal` - стандартный уровень (по умолчанию)
- `debug` - подробное логирование

### Генерация отчетов

```bash
# Генерация полных отчетов по всем моделям и задачам
./bin/generate_report
```

Скрипт создает два отчета в каталоге `reports/`:
- `human_watch_ruby_report_total.md` - общая статистика успешности моделей
- `human_watch_ruby_report_full.md` - подробный отчет с результатами по каждой задаче

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
- `reports/` - сгенерированные отчеты
    - `human_watch_ruby_report_total.md` - общая статистика
    - `human_watch_ruby_report_full.md` - подробный отчет

## Лицензия

MIT
