assert incr_list([1, 2, 3]) == [2, 3, 4]
assert incr_list([5, 3, 5, 2, 3, 3, 9, 0, 123]) == [6, 4, 6, 3, 4, 4, 10, 1, 124]
assert incr_list([]) == []
assert incr_list([-1, 0, 1]) == [0, 1, 2]
assert incr_list([-100, 100]) == [-99, 101]
assert incr_list([0]) == [1]

