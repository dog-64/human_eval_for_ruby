[PYTHON]
def sort_array(array):
    return sorted(array, key=lambda x: x[0] + x[-1], reverse=True)
[/PYTHON]
[TESTS]
# Test case 1:
assert sort_array([]) == []
# Test case 2:
assert sort_array([5]) == [5]
# Test case 3:
assert sort_array([2, 4, 3, 0, 1, 5]) == [0, 1, 2, 3, 4, 5]
# Test case 4:
assert sort_array([2, 4, 3, 0, 1, 5, 6]) == [6, 5, 4, 3, 2, 1, 0]
# Test case 5:
assert sort_array([7, 3, 4, 1, 6, 9, 8, 2]) == [9, 8, 7, 6, 4, 3, 2, 1]
[/TESTS]
