assert sort_array([]) == []
assert sort_array([5]) == [5]
assert sort_array([2, 4, 3, 0, 1, 5]) == [0, 1, 2, 3, 4, 5]
assert sort_array([2, 4, 3, 0, 1, 5, 6]) == [6, 5, 4, 3, 2, 1, 0]
assert sort_array([1, 3, 5, 7, 9]) == [1, 3, 5, 7, 9]
assert sort_array([10, 8, 6, 4, 2]) == [10, 8, 6, 4, 2]
assert sort_array([0]) == [0]
assert sort_array([1]) == [1]
assert sort_array([1, 0]) == [0, 1]
assert sort_array([0, 1]) == [1, 0]
assert sort_array([100, 200, 300]) == [300, 200, 100]
assert sort_array([100, 201, 300]) == [100, 201, 300]
assert_valid_order sort_array([2, 4, 3, 0, 1, 5])
assert_valid_order sort_array([2, 4, 3, 0, 1, 5, 6]).reverse
