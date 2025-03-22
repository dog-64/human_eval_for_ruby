[PYTHON]
def mean_absolute_deviation(numbers):
    if not numbers:
        return 0.0
    mean = sum(numbers) / len(numbers)
    return sum(abs(x - mean) for x in numbers) / len(numbers)
[/PYTHON]
[TESTS]
# Test case 1:
assert mean_absolute_deviation([]) == 0.0
# Test case 2:
assert mean_absolute_deviation([1.0, 2.0, 3.0, 4.0]) == 1.0
# Test case 3:
assert mean_absolute_deviation([1.0, 1.0, 1.0, 1.0]) == 0.0
# Test case 4:
assert mean_absolute_deviation([10.5, 20.2, 30.7, 40.1]) == 10.6875
[/TESTS]
