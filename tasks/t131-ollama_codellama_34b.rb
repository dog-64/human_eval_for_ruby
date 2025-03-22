[PYTHON]
def digits(n):
    product = 1
    while n > 0:
        if n % 2 != 0:
            product *= n % 10
        n //= 10
    return product
[/PYTHON]
[TESTS]
# Test case 1:
assert digits(1) == 1
# Test case 2:
assert digits(4) == 0
# Test case 3:
assert digits(235) == 15
# Test case 4:
assert digits(13579) == 945
# Test case 5:
assert digits(2468) == 0
[/TESTS]
