[PYTHON]
def get_row(lst, x):
    result = []
    for i in range(len(lst)):
        for j in range(len(lst[i])):
            if lst[i][j] == x:
                result.append([i, j])
    return sorted(result)
[/PYTHON]
[TESTS]
# Test case 1:
assert get_row([[1, 2, 3], [4, 5, 6]], 1) == [[0, 0]]
# Test case 2:
assert get_row([[1, 2, 3], [4, 5, 6]], 2) == [[0, 1]]
# Test case 3:
assert get_row([[1, 2, 3], [4, 5, 6]], 3) == [[0, 2], [1, 1]]
[/TESTS]
