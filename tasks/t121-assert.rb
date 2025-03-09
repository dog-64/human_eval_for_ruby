assert sum_odd_even_pos([-1, -3, -5, -7]) == -6
assert sum_odd_even_pos([-1, 2, -3, 4]) == -4
assert sum_odd_even_pos([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 25
assert sum_odd_even_pos([1, 3, 5, 7, 9]) == 15
assert sum_odd_even_pos([1]) == 1
assert sum_odd_even_pos([2, 4, 6, 8, 10]) == 0
assert sum_odd_even_pos([2, 4, 6, 8]) == 0
assert sum_odd_even_pos([3, 3, 3, 3, 3]) == 9
assert sum_odd_even_pos([30, 13, 24, 321]) == 0
assert sum_odd_even_pos([5, 8, 7, 1]) == 12
puts sum_odd_even_pos([1])
