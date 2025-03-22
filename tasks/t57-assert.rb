assert monotonic?([1, 2, 4, 20]) == true
assert monotonic?([1, 20, 4, 10]) == false
assert monotonic?([4, 1, 0, -10]) == true
assert monotonic?([5, 5, 5]) == true
assert monotonic?([]) == true
assert monotonic?([1]) == true
assert monotonic?([1.1, 2.2, 3.3]) == true
assert monotonic?([3.3, 2.2, 1.1]) == true
assert monotonic?([1, 2, 1]) == false
assert monotonic?([2, 1, 2]) == false
assert monotonic?([-1, 0, 1, 2]) == true
assert monotonic?([2, 1, 0, -1]) == true
assert monotonic?([1, 1, 1, 1]) == true
assert monotonic?([1.0, 1.0, 1.0]) == true
assert monotonic?([1, 2, 3, 2.9]) == false
assert monotonic?([3, 2.9, 2, 1]) == true

