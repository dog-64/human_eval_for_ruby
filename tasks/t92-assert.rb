assert any_int?(5, 2, 7) == true
assert any_int?(3, 2, 2) == false
assert any_int?(3, -2, 1) == true
assert any_int?(3.6, -2.2, 2) == false
assert any_int?(0, 0, 0) == true
assert any_int?(-5, 5, 0) == true
assert any_int?(10, -5, 5) == true
assert any_int?(1, 2, 3) == false
assert any_int?(Integer.MAX_VALUE, 1, Integer.MAX_VALUE + 1) == false
assert any_int?(Integer.MIN_VALUE, 1, Integer.MIN_VALUE + 1) == false
assert any_int?(1, Integer.MAX_VALUE, Integer.MAX_VALUE -1) == true
assert any_int?(1, Integer.MIN_VALUE, Integer.MIN_VALUE + 1) == true
assert any_int?(1, 1, 2) == true
assert any_int?(2, 1, 1) == true
assert any_int?(1, 2, 1) == true
assert any_int?(0, 1, -1) == true
assert any_int?(0, -1, 1) == true
assert any_int?(1, 0, -1) == true
assert any_int?(-1, 0, 1) == true
assert any_int?(-1, 1, 0) == true
assert any_int?(1, -1, 0) == true

