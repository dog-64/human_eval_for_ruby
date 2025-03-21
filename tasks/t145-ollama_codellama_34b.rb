[PYTHON]
def order_by_points(nums):
    return sorted(nums, key=lambda x: (sum(int(i) for i in str(abs(x))), x))
[/PYTHON]
[TESTS]
# Test case 1:
assert order_by_points([]) == []
# Test case 2:
assert order_by_points([1]) == [1]
# Test case 3:
assert order_by_points([1, 11, -1, -11, -12]) == [-1, -11, 1, -12, 11]
# Test case 4:
assert order_by_points([100, 1, 10]) == [1, 10, 100]
# Test case 5:
assert order_by_points([-1, -12, -13, 1, 2, 3]) == [-1, -12, -13, 1, 2, 3]
[/TESTS]
