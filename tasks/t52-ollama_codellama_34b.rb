[PYTHON]
def below_threshold(numbers, threshold):
    return all(number < threshold for number in numbers)
[/PYTHON]
[TESTS]
# Test case 1:
assert below_threshold([1, 2, 4, 10], 100) == True
# Test case 2:
assert below_threshold([1, 20, 4, 10], 5) == False
# Test case 3:
assert below_threshold([], 10) == True
# Test case 4:
assert below_threshold([1, 2, 4, 10], 10) == False
# Test case 5:
assert below_threshold([1, 2, 4, 10], -10) == False
[/TESTS]
