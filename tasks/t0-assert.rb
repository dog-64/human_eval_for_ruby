assert has_close_elements([1.0, 2.0, 3.0], 0.5) == false
assert has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0, 2.0], 0.3) == true
assert has_close_elements([], 1.0) == false
assert has_close_elements([1.0], 1.0) == false
assert has_close_elements([1.0, 1.1, 1.2], 0.2) == true
assert has_close_elements([1.0, 2.0, 3.0], 1.0) == true
assert has_close_elements([1.0, 2.0, 3.0], 0.0) == false
assert has_close_elements([1.0, 1.0, 1.0], 0.1) == true
assert has_close_elements([1.0, 2.0, 3.0, 4.0], 0.1) == false
assert has_close_elements([1.0, 1.000000000001], 0.000000000001) == false
assert has_close_elements([-1.0, 0.0, 1.0], 1.0) == true
assert has_close_elements([-1.0, 0.0, 1.0], 0.5) == false

assert(has_close_elements([-1.0, 0.0, 1.0], 0.0) == false)
