assert change_base(8, 3) == "22"
assert change_base(8, 2) == "1000"
assert change_base(7, 2) == "111"
assert change_base(10, 2) == "1010"
assert change_base(0, 2) == "0"
assert change_base(1, 2) == "1"
assert change_base(9, 3) == "100"
assert change_base(99, 10) == "99"
assert_raises(ArgumentError) { change_base(10, 1) }
assert_raises(ArgumentError) { change_base(10, 10) }
assert change_base(15, 2) == "1111"
assert change_base(255, 16) == "FF" 
assert change_base(42, 5) == "132"

