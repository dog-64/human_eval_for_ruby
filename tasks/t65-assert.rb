assert circular_shift(12, 1) == "21"
assert circular_shift(12, 2) == "12"
assert circular_shift(12345, 2) == "45123"
assert circular_shift(123, 4) == "321"
assert circular_shift(1, 1) == "1"
assert circular_shift(1234567890, 3) == "7890123456"
assert circular_shift(0, 1) == "0"
assert circular_shift(10, 1) == "01"
assert circular_shift(12345, 0) == "12345"
assert circular_shift(12345, 5) == "54321"
assert circular_shift(12345, 6) == "54321"
assert_raises(ArgumentError) { circular_shift(-12, 1) }
assert_raises(ArgumentError) { circular_shift(12.5, 1) }
assert_raises(ArgumentError) { circular_shift(12, -1) }

