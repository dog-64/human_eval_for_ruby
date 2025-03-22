[PYTHON]
def double_the_difference(numbers):
    result = 0
    for number in numbers:
        if number > 0 and number % 2 != 0:
            result += number * number
    return result
[/PYTHON]
[TESTS]
# Test case 1:
assert double_the_difference([1, 3, 2, 0]) == 10
# Test case 2:
assert double_the_difference([-1, -2, 0]) == 0
# Test case 3:
assert double_the_difference([9, -2]) == 81
# Test case 4:
assert double_the_difference([0]) == 0
# Test case 5:
assert double_the_difference([]) == 0
[/TESTS]
