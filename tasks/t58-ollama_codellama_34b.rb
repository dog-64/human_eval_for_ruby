[PYTHON]
def common(l1, l2):
    return sorted(set(l1).intersection(l2))
[/PYTHON]
[TESTS]
# Test case 1:
assert common([1, 4, 3, 34, 653, 2, 5], [5, 7, 1, 5, 9, 653, 121]) == [1, 5, 653]
# Test case 2:
assert common([5, 3, 2, 8], [3, 2]) == [2, 3]
# Test case 3:
assert common([], []) == []
# Test case 4:
assert common([1, 2, 3], [4, 5, 6]) == []
# Test case 5:
assert common([1, 2, 2, 3], [2, 3, 4]) == [2, 3]
[/TESTS]
