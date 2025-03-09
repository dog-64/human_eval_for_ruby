assert will_it_fly?([-1, 0, 1], -1) == false
assert will_it_fly?([-1, 0, 1], 0) == false
assert will_it_fly?([1, -1, 1], 0) == false
assert will_it_fly?([1, -1, 1], 1) == true
assert will_it_fly?([1, 2, 1], 5) == true
assert will_it_fly?([1, 2, 3, 2, 1], -1) == false
assert will_it_fly?([1, 2, 3, 2, 1], 0) == false
assert will_it_fly?([1, 2, 3, 2, 1], 1) == false
assert will_it_fly?([1, 2, 3, 2, 1], 10) == true
assert will_it_fly?([1, 2, 3, 2, 1], 2) == false
assert will_it_fly?([1, 2, 3, 2, 1], 3) == false
assert will_it_fly?([1, 2, 3, 2, 1], 4) == false
assert will_it_fly?([1, 2, 3, 2, 1], 5) == false
assert will_it_fly?([1, 2, 3, 2, 1], 6) == false
assert will_it_fly?([1, 2, 3, 2, 1], 7) == false
assert will_it_fly?([1, 2, 3, 2, 1], 8) == false
assert will_it_fly?([1, 2, 3, 2, 1], 9) == true
assert will_it_fly?([1, 2, 3, 4, 5], 15) == false
assert will_it_fly?([1, 2], 5) == false
assert will_it_fly?([3, 2, 3], 1) == false
assert will_it_fly?([3, 2, 3], 9) == true
assert will_it_fly?([3], 5) == true
assert will_it_fly?([5, 4, 3, 2, 5], 20) == false
assert will_it_fly?([], 5) == true
