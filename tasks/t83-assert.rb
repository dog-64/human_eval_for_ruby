assert starts_one_ends(1) == 2
assert starts_one_ends(2) == 18
assert starts_one_ends(3) == 180
assert starts_one_ends(4) == 1800
assert starts_one_ends(5) == 18000
assert_raises(ArgumentError) { starts_one_ends(0) }
assert_raises(ArgumentError) { starts_one_ends(-1) }
assert_raises(ArgumentError) { starts_one_ends(3.14) }
assert_raises(ArgumentError) { starts_one_ends("abc") }
assert_raises(ArgumentError) { starts_one_ends([]) }
assert_raises(ArgumentError) { starts_one_ends({}) }

