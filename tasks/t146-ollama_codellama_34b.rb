[PYTHON]
def special_filter(nums):
    count = 0
    for num in nums:
        if num > 10 and num % 2 != 0 and num % 10 != 0:
            count += 1
    return count
[/PYTHON]
[TESTS]
# Test case 1:
assert special_filter([15, -73, 14, -15]) == 1
# Test case 2:
assert special_filter([33, -2, -3, 45, 21, 109]) == 2
# Test case 3:
assert special_filter([-11, 12, 23, 101, 99]) == 2
# Test case 4:
assert special_filter([]) == 0
# Test case 5:
assert special_filter([1, 2, 3, 4, 5]) == 0
[/TESTS]
