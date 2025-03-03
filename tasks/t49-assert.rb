assert modp(3, 5) == 3
assert modp(1101, 101) == 2
assert modp(0, 101) == 1
assert modp(3, 11) == 8
assert modp(100, 101) == 1
assert modp(1, 10) == 2
assert modp(10, 100) == 24
assert modp(0, 1) == 1
assert modp(1000, 1000000) == 1024
assert modp(10, 1000) == 1024
assert modp(5, 3) == 32
assert_raises(ArgumentError) { modp(-1, 5) }
assert_raises(ArgumentError) { modp(3, -1) }
assert_raises(ArgumentError) { modp(3, 0) }

