assert count_nums([]) == 0
assert count_nums([-1, 11, -11]) == 1
assert count_nums([1, 1, 2]) == 3
assert count_nums([-10, 0, 10]) == 1
assert count_nums([-20,-30, -40]) == 0
assert count_nums([123, -456, 789]) == 3
assert count_nums([-999, 0, 999]) == 1
assert count_nums([1, -1, 0]) == 1
assert count_nums([-100, 100, -1000]) == 1
assert count_nums([Integer.MAX_VALUE, Integer.MIN_VALUE]) == 1
assert count_nums([0]) == 0
assert count_nums([-1]) == 0
assert count_nums([1]) == 1
assert count_nums([1000000]) == 1
assert count_nums([-1000000]) == 0

