[PYTHON]
def unique_digits(numbers):
    unique_numbers = []
    for number in numbers:
        digits = [int(digit) for digit in str(number)]
        if all(digit % 2 != 0 for digit in digits):
            unique_numbers.append(number)
    return sorted(unique_numbers)
[/PYTHON]
[TESTS]
# Test case 1:
assert unique_digits([]) == []
# Test case 2:
assert unique_digits([1]) == [1]
# Test case 3:
assert unique_digits([1, 2, 3, 4, 5, 6, 7, 8, 9]) == [1, 3, 5, 7, 9]
# Test case 4:
assert unique_digits([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == [1, 3, 5, 7, 9]
# Test case 5:
assert unique_digits([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]) == [1, 3, 5, 7, 9, 11]
[/TESTS]
