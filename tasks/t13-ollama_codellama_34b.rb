[PYTHON]
def greatest_common_divisor(a, b):
    if a == 0:
        return abs(b)
    if b == 0:
        return abs(a)
    return greatest_common_divisor(b, a % b)
[/PYTHON]
[TESTS]
# Test case 1:
assert greatest_common_divisor(3, 5) == 1
# Test case 2:
assert greatest_common_divisor(25, 15) == 5
# Test case 3:
assert greatest_common_divisor(12, 18) == 6
# Test case 4:
assert greatest_common_divisor(0, 5) == 5
# Test case 5:
assert greatest_common_divisor(5, 0) == 5
# Test case 6:
assert greatest_common_divisor(0, 0) == 0
# Test case 7:
assert greatest_common_divisor(10, 10) == 10
# Test case 8:
assert greatest_common_divisor(100, 100) == 100
# Test case 9:
assert greatest_common_divisor(1000, 1000) == 1000
[/TESTS]
