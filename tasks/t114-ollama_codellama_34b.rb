[PYTHON]
def min_sub_array_sum(nums):
    min_sum = float('inf')
    curr_sum = 0
    for num in nums:
        curr_sum += num
        if curr_sum < min_sum:
            min_sum = curr_sum
        if curr_sum < 0:
            curr_sum = 0
    return min_sum
[/PYTHON]
[TESTS]
# Test case 1:
assert min_sub_array_sum([2, 3, 4, 1, 2, 4]) == 1
# Test case 2:
assert min_sub_array_sum([-1, -2, -3]) == -6
# Test case 3:
assert min_sub_array_sum([1]) == 1
# Test case 4:
assert min_sub_array_sum([5, -1, 2, -3]) == -3
[/TESTS]
