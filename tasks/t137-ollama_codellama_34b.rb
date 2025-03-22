[PYTHON]
def compare_one(a, b):
    if a == b:
        return None
    try:
        a = float(a)
        b = float(b)
    except ValueError:
        return max(a, b)
    return max(a, b)
[/PYTHON]
[TESTS]
# Test case 1:
assert compare_one(1, 2.5) == 2.5
# Test case 2:
assert compare_one(1, "2,3") == "2,3"
# Test case 3:
assert compare_one("5,1", "6") == "6"
# Test case 4:
assert compare_one("1", 1) == None
# Test case 5:
assert compare_one(3.14, "3.14") == None
# Test case 6:
assert compare_one("-10", -5) == -5
[/TESTS]
