assert sum_binary_digits(1000) == "1"
assert sum_binary_digits(150) == "110"
assert sum_binary_digits(147) == "1100"
assert sum_binary_digits(0) == "0"
assert sum_binary_digits(1) == "1"
assert sum_binary_digits(10000) == "10000"
assert sum_binary_digits(9999) == "36"
assert sum_binary_digits(5) == "101"
assert sum_binary_digits(10) == "1010"
assert_raises(ArgumentError) { sum_binary_digits(-1) }
assert_raises(ArgumentError) { sum_binary_digits(10001) }
assert_raises(TypeError) { sum_binary_digits("1000") }
assert_raises(TypeError) { sum_binary_digits([1000]) }
assert_raises(TypeError) { sum_binary_digits({1000 => 1000})}

