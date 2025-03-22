[PYTHON]
def median(numbers):
    if not numbers:
        return None
    numbers.sort()
    if len(numbers) % 2 == 0:
        median = (numbers[len(numbers) // 2 - 1] + numbers[len(numbers) // 2]) / 2
    else:
        median = numbers[len(numbers) // 2]
    return median
[/PYTHON]
[TESTS]
# Test case 1:
assert median([]) == None
# Test case 2:
assert median([1]) == 1
# Test case 3:
assert median([1, 2, 3]) == 2
# Test case 4:
assert median([1, 2, 3, 4, 5]) == 3
# Test case 5:
assert median([1, 2, 3, 4, 5, 6]) == 3.5
[/TESTS]
