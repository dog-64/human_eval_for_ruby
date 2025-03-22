[PYTHON]
def remove_duplicates(numbers):
    return list(set(numbers))
[/PYTHON]
[TESTS]
# Test case 1:
assert remove_duplicates([]) == []
# Test case 2:
assert remove_duplicates([1]) == [1]
# Test case 3:
assert remove_duplicates([1, 2, 3, 2, 1]) == [1, 2, 3]
# Test case 4:
assert remove_duplicates([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# Test case 5:
assert remove_duplicates([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
[/TESTS]
