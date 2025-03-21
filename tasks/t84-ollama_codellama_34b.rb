[PYTHON]
def sum_binary_digits(n):
    return bin(sum(int(i) for i in str(n)))[2:]
[/PYTHON]
[TESTS]
# Test case 1:
assert sum_binary_digits(1000) == "1"
# Test case 2:
assert sum_binary_digits(150) == "110"
# Test case 3:
assert sum_binary_digits(147) == "1100"
[/TESTS]
