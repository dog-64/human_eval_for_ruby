assert_raises(ArgumentError) { find_zero([]) }
assert_raises(ArgumentError) { find_zero([1]) }
assert_raises(ArgumentError) { find_zero([0, 0]) }
assert_in_delta(find_zero([1, 2]), -0.5, 0.01)
assert_in_delta(find_zero([-6, 11, -6, 1]), 1.0, 0.01)
assert_in_delta(find_zero([1, -3, 2]), 1.0, 0.01)
assert_in_delta(find_zero([2, -5, 2]), 1.0, 0.01)
assert_in_delta(find_zero([1, 0, -1]), 1.0, 0.01)
assert_in_delta(find_zero([-1, 0, 1]), -1.0, 0.01)
assert_in_delta(find_zero([2, -3, 1]), 1.0, 0.01)
assert_raises(ArgumentError) { find_zero([0, 1, 2, 3])}
assert_in_delta(find_zero([1, -10, 35, -50, 24]), 4.0, 0.01)
assert_in_delta(find_zero([1, -5, 8, -4]), 1.0, 0.01)

