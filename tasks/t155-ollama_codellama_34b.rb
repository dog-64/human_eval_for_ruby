[PYTHON]
def even_odd_count(num):
    count_even = 0
    count_odd = 0
    if num < 0:
        num = -num
    while num > 0:
        if num % 2 == 0:
            count_even += 1
        else:
            count_odd += 1
        num //= 10
    return (count_even, count_odd)
[/PYTHON]
[TESTS]
# Test case 1:
assert even_odd_count(0) == (1, 0)
# Test case 2:
assert even_odd_count(123) == (1, 2)
# Test case 3:
assert even_odd_count(-12) == (1, 1)
# Test case 4:
assert even_odd_count(1111) == (0, 4)
# Test case 5:
assert even_odd_count(-2468) == (4, 0)
[/TESTS]
