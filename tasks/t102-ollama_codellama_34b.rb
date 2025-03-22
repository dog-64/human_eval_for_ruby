[PYTHON]
def choose_num(x, y):
    if x > y:
        return -1
    elif x % 2 == 1 and y % 2 == 1:
        return -1
    else:
        return max(range(x, y+1, 2)) if x % 2 == 0 or y % 2 == 0 else -1
[/PYTHON]
[TESTS]
# Test case 1:
assert choose_num(12, 15) == 14
# Test case 2:
assert choose_num(13, 15) == 14
# Test case 3:
assert choose_num(13, 12) == -1
# Test case 4:
assert choose_num(1, 3) == 2
# Test case 5:
assert choose_num(1, 1) == -1
# Test case 6:
assert choose_num(2, 2) == 2
# Test case 7:
assert choose_num(100, 101) == 100
# Test case 8:
assert choose_num(101, 100) == -1
[/TESTS]
