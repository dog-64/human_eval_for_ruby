[PYTHON]
def search(lst):
    # Создаем словарь для хранения частоты каждого числа
    freq = {}
    for num in lst:
        if num not in freq:
            freq[num] = 0
        freq[num] += 1

    # Находим наибольшее число, которое встречается в списке более или равно часто
    max_num = -1
    for num, count in freq.items():
        if count >= num and num > max_num:
            max_num = num

    return max_num
[/PYTHON]
[TESTS]
# Test case 1:
assert search([4, 1, 2, 2, 3, 1]) == 2
# Test case 2:
assert search([1, 2, 2, 3, 3, 3, 4, 4, 4]) == 3
# Test case 3:
assert search([5, 5, 4, 4, 4]) == -1
# Test case 4:
assert search([1, 2, 3, 4, 5]) == -1
# Test case 5:
assert search([1, 1, 1, 1, 1]) == -1
[/TESTS]
