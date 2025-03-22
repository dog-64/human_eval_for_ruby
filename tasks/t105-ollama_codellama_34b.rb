[PYTHON]
def by_length(arr):
    # Фильтруем массив, оставляя только числа от 1 до 9 включительно
    filtered_arr = [x for x in arr if 1 <= x <= 9]
    # Сортируем отфильтрованный массив в порядке убывания
    sorted_arr = sorted(filtered_arr, reverse=True)
    # Разворачиваем отсортированный массив
    reversed_arr = sorted_arr[::-1]
    # Заменяем каждое число в развернутом массиве на его словесное представление
    string_arr = [str(x) for x in reversed_arr]
    return string_arr
[/PYTHON]
[TESTS]
# Test case 1:
assert by_length([]) == []
# Test case 2:
assert by_length([1, 2, 3, 4, 5]) == ["Five", "Four", "Three", "Two", "One"]
# Test case 3:
assert by_length([1, 2, 3, 4, 5, 6, 7, 8, 9]) == ["Nine", "Eight", "Seven", "Six", "Five", "Four", "Three", "Two", "One"]
# Test case 4:
assert by_length([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == ["Nine", "Eight", "Seven", "Six", "Five", "Four", "Three", "Two", "One"]
[/TESTS]
