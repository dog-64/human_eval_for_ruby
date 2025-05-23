assert order_by_points([1, 11, -1, -11, -12]) == [1, -1, 11, -11, -12]
assert order_by_points([]) == []
assert order_by_points([100, 1, 10]) == [100, 1, 10]
assert order_by_points([-100, -1, -10]) == [-100, -1, -10]
assert order_by_points([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
assert order_by_points([9, 99, 999]) == [9, 99, 999]
assert order_by_points([-9, -99, -999]) == [-9, -99, -999]
assert order_by_points([0, 10, -10]) == [0, 10, -10]
assert order_by_points([123, 456, 789]) == [123, 456, 789]
assert order_by_points([-123, -456, -789]) == [-123, -456, -789]
assert order_by_points([1, 10, 100, 1000]) == [1, 10, 100, 1000]
assert order_by_points([-1, -10, -100, -1000]) == [-1, -10, -100, -1000]
assert order_by_points([987, 654, 321]) == [321, 654, 987]
assert order_by_points([-987, -654, -321]) == [-321, -654, -987]
assert order_by_points([1, -1, 2, -2]) == [1, -1, 2, -2]
assert order_by_points([111, 222, 333, 444]) == [111, 222, 333, 444]
assert order_by_points([-111, -222, -333, -444]) == [-111, -222, -333, -444]
