[PYTHON]
def add_even_at_odd(lst):
    result = 0
    for i, num in enumerate(lst):
        if i % 2 and num % 2 == 0:
            result += num
    return result
[/PYTHON]
[TESTS]
# Test case 1:
assert add_even_at_odd([4, 2, 6, 7]) == 2
# Test case 2:
assert add_even_at_odd([1, 3, 5, 7]) == 0
# Test case 3:
assert add_even_at_odd([2, 4, 6, 8]) == 12
# Test case 4:
assert add_even_at_odd([1, 2, 3, 4, 5, 6]) == 12
[/TESTS]
