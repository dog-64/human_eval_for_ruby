def sorted_list_sum(lst)
  lst.select { |s| s.length.even? }.sort_by { |s| [s.length, s] }
end

## Обеспечение корректности

Проверка корректности функции:

```ruby
def test_sorted_list_sum
  # Тест 1: Удаление строк нечетной длины
  assert_equal sorted_list_sum(["aa", "a", "aaa"]), ["aa"]

  # Тест 2: Сортировка по длине и алфавиту
  assert_equal sorted_list_sum(["ab", "a", "aaa", "cd"]), ["ab", "cd"]

  # Тест 3: Все строки одинаковой длины
  assert_equal sorted_list_sum(["abc", "def", "ghi"]), ["abc", "def", "ghi"]

  # Тест 4: Пустой список
  assert_equal sorted_list_sum([]), []

  # Тест 5: Строки с одинаковой длиной
  assert_equal sorted_list_sum(["zz", "aa", "bb"]), ["aa", "bb", "zz"]

  # Тест 6: Строки разной длины
  assert_equal sorted_list_sum(["zzz", "aa", "bbbb"]), ["aa", "zzz", "bbbb"]

  # Тест 7: Все строки нечетной длины
  assert_equal sorted_list_sum(["a", "bbb", "ccccc"]), []

  # Тест 8: Строки с дубликатами
  assert_equal sorted_list_sum(["aa", "aa", "bb", "bb"]), ["aa", "aa", "bb", "bb"]

  # Тест 9: Строки с разной длиной и дубликатами
  assert_equal sorted_list_sum(["a", "aa", "aa", "bbb", "bb", "cccc"]), ["aa", "aa", "bb", "cccc"]

  # Тест 10: Строки с разной длиной и пустыми строками
  assert_equal sorted_list_sum(["", "a", "aa", "aaa", "aaaa"]), ["", "aa", "aaaa"]
end

test_sorted_list_sum
```