[PYTHON]
def maximum(arr, k):
    return sorted(arr, reverse=True)[:k]
[/PYTHON]
[TESTS]
# Test case 1:
assert maximum([-3, -4, 5], 3) == [-4, -3, 5]
# Test case 2:
assert maximum([4, -4, 4], 2) == [4, 4]
# Test case 3:
assert maximum([-3, 2, 1, 2, -1, -2, 1], 1) == [2]
# Test case 4:
assert maximum([-3, -4, -5], 3) == [-3, -4, -5]
# Test case 5:
assert maximum([4, -4, 4], 3) == [4, 4, -4]
[/TESTS]
