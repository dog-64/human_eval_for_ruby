[PYTHON]
def get_positive(numbers):
    return [x for x in numbers if x > 0]
[/PYTHON]
[TESTS]
# Test case 1:
assert get_positive([]) == []
# Test case 2:
assert get_positive([-1, 2, -4, 5, 6]) == [2, 5, 6]
# Test case 3:
assert get_positive([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10]) == [5, 3, 2, 3, 9, 123, 1]
# Test case 4:
assert get_positive([-1, -2, -3]) == []
# Test case 5:
assert get_positive([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
[/TESTS]
