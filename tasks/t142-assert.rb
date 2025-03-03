assert sum_squares([1, 2, 3]) == 6
assert sum_squares([]) == 0
assert sum_squares([-1, -5, 2, -1, -5]) == -126
assert sum_squares([1, 2, 3, 4, 5, 6]) == 1 + 4 + 27 + 64 + 5 + 216
assert sum_squares([0,0,0,0,0]) == 0
assert sum_squares([-1, -2, -3, -4, -5]) == -1 + 4 + (-27) + 64 + (-5)
assert sum_squares([10,20,30,40,50]) == 10 + 400 + 27000 + 64000 + 50
assert sum_squares([1,1,1,1,1,1,1,1,1,1]) == 1 + 1 + 1 + 64 + 1 + 1 + 1 + 1 + 1 + 1
assert sum_squares([-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]) == -1 + 1 + (-1) + 64 + (-1) + (-1) + (-1) + (-1) + (-1) + (-1)

