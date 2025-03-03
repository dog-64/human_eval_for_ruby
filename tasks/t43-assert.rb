assert pairs_sum_to_zero([1, 3, 5, 0]) == false
assert pairs_sum_to_zero([1, 3, -2, 1]) == false
assert pairs_sum_to_zero([1, 2, 3, 7]) == false
assert pairs_sum_to_zero([2, 4, -5, 3, 5, 7]) == true
assert pairs_sum_to_zero([1]) == false
assert pairs_sum_to_zero([]) == false
assert pairs_sum_to_zero([0, 0]) == false
assert pairs_sum_to_zero([5, -5]) == true
assert pairs_sum_to_zero([-10, 10, 20, -20]) == true
assert pairs_sum_to_zero([1, 2, -3, 4, -5, 6]) == false
assert pairs_sum_to_zero([Integer.MAX_VALUE, -Integer.MAX_VALUE]) == true
assert pairs_sum_to_zero([-1000, 1000]) == true

