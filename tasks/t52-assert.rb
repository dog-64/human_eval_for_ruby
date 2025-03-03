assert below_threshold([1, 2, 3], 10) == true
assert below_threshold([1, 20, 3], 5) == false
assert below_threshold([], 10) == true
assert below_threshold([10, 20, 30], 100) == true
assert below_threshold([10, 20, 30], 20) == false
assert below_threshold([-1, -2, -3], 0) == true
assert below_threshold([0, 0, 0], 1) == true
assert below_threshold([1, 2, 3], 0) == false
assert below_threshold([1, 2, 3], 3) == false
assert below_threshold([1, 2, 3], -1) == false

