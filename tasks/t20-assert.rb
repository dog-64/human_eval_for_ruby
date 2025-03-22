assert find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.2]) == [2.0, 2.2]
assert find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.0]) == [2.0, 2.0]
assert find_closest_elements([2.0, 2.0]) == [2.0, 2.0]
assert find_closest_elements([1.0, 1.00001]) == [1.0, 1.00001]
assert find_closest_elements([5.0, 4.0, 3.0, 2.0, 1.0]) == [1.0, 2.0]
assert find_closest_elements([-1.0, 0.0, 1.0]) == [-1.0, 0.0]
assert find_closest_elements([100.0, 100.001, 100.003]) == [100.0, 100.001]
assert_raises(ArgumentError) { find_closest_elements([1.0]) }
assert_raises(ArgumentError) { find_closest_elements([]) }
