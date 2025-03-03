assert add_elements([111, 21, 3, 4000, 5, 6, 7, 8, 9], 4) == 24
assert add_elements([1, 10, 100, 1000], 2) == 11
assert add_elements([-10, 2, -100, 12, 50], 3) == -108
assert add_elements([1, 2, 3, 4, 5], 5) == 15
assert add_elements([10, 20, 30, 40, 50], 3) == 60
assert add_elements([-1, -2, -3, -4, -5], 5) == -15
assert add_elements([99, 100, 101], 2) == 199
assert add_elements([123, 456, 789], 1) == 0
assert add_elements([-99, -100, -101], 3) == -300
assert add_elements([1000, 2000, 3000], 3) == 0
assert add_elements([1, 2, 3], 1) == 1
assert add_elements([1], 1) == 1
assert add_elements([-100, 10, -50], 2) == -90
assert add_elements([9, 99, 999], 2) == 108

