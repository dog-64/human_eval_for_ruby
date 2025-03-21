[PYTHON]
def max_element(list):
    if not list:
        return None
    return max(list)
[/PYTHON]
[TESTS]
# Test case 1:
assert max_element([]) == None
# Test case 2:
assert max_element([1]) == 1
# Test case 3:
assert max_element([1, 2, 3, 4, 5]) == 5
# Test case 4:
assert max_element([-1, -2, -3, -4, -5]) == -1
# Test case 5:
assert max_element([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 10
[/TESTS]
