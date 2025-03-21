[PYTHON]
def compare(game, guess):
    return [abs(a-b) for a, b in zip(game, guess)]
[/PYTHON]
[TESTS]
# Test case 1:
assert compare([1, 2, 3, 4, 5, 1], [1, 2, 3, 4, 2, -2]) == [0, 0, 0, 0, 3, 3]
# Test case 2:
assert compare([0, 5, 0, 0, 0, 4], [4, 1, 1, 0, 0, -2]) == [4, 4, 1, 0, 0, 6]
# Test case 3:
assert compare([1, 2, 3], [1, 2, 3]) == [0, 0, 0]
# Test case 4:
assert compare([1, 2, 3], [-1, -2, -3]) == [2, 4, 6]
[/TESTS]
