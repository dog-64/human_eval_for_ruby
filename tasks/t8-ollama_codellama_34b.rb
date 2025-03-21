[PYTHON]
def sum_product(numbers):
    total = 0
    product = 1
    for num in numbers:
        total += num
        product *= num
    return (total, product)
[/PYTHON]
[TESTS]
# Test case 1:
assert sum_product([]) == (0, 1)
# Test case 2:
assert sum_product([1, 2, 3]) == (6, 6)
# Test case 3:
assert sum_product([-1, -2, -3]) == (-6, -6)
[/TESTS]
