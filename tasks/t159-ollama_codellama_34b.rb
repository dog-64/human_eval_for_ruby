[PYTHON]
def eat(number, need, remaining):
    total_eaten = number + min(need - number, remaining)
    carrots_left = remaining - (total_eaten - number)
    return [total_eaten, carrots_left]
[/PYTHON]
[TESTS]
# Test case 1:
assert eat(5, 6, 10) == [6, 9]
# Test case 2:
assert eat(4, 8, 9) == [8, 5]
# Test case 3:
assert eat(1, 10, 10) == [10, 1]
# Test case 4:
assert eat(2, 11, 5) == [7, 0]
[/TESTS]
