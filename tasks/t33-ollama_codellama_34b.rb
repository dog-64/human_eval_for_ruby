[PYTHON]
def sort_third(l):
    return [l[i] for i in range(len(l)) if i % 3 != 0] + sorted([l[i] for i in range(len(l)) if i % 3 == 0])
[/PYTHON]
[TESTS]
# Test case 1:
assert sort_third([1, 2, 3]) == [1, 2, 3]
# Test case 2:
assert sort_third([5, 6, 3, 4, 8, 9, 2]) == [2, 6, 3, 4, 8, 9, 5]
# Test case 3:
assert sort_third([]) == []
[/TESTS]
