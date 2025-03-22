[PYTHON]
def intersperse(numbers, delimeter):
    return [delimeter if i % 2 == 0 else numbers[i//2] for i in range(len(numbers)*2-1)]
[/PYTHON]
[TESTS]
# Test case 1:
assert intersperse([], 4) == []
# Test case 2:
assert intersperse([1, 2, 3], 4) == [1, 4, 2, 4, 3]
# Test case 3:
assert intersperse([10, 20, 30, 40], 0) == [10, 0, 20, 0, 30, 0, 40]
[/TESTS]
