assert below_zero?([1, 2, 3]) == false
assert below_zero?([1, 2, -4, 5]) == true
assert below_zero?([-1, 2, -3]) == true
assert below_zero?([-5, 1, 2, 3, 4, -10]) == true
assert below_zero?([5, 4, 3, 2, 1]) == false
assert below_zero?([]) == false
assert below_zero?([0]) == false
assert below_zero?([-1]) == true
assert below_zero?([100, -101, 1]) == true
assert below_zero?([1000, -500, 600, -1100]) == false

