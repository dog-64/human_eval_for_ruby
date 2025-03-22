[PYTHON]
def change_base(x, base):
    if x < 0 or base < 2 or base > 9:
        raise ValueError("Invalid input")
    digs = "0123456789"
    res = ""
    while x > 0:
        res = digs[x % base] + res
        x //= base
    return res
[/PYTHON]
[TESTS]
# Test case 1:
assert change_base(8, 3) == "22"
# Test case 2:
assert change_base(8, 2) == "1000"
# Test case 3:
assert change_base(7, 2) == "111"
# Test case 4:
assert change_base(10, 10) == "10"
# Test case 5:
assert change_base(99, 16) == "63"
[/TESTS]
