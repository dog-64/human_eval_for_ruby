assert get_odd_collatz(1) == [1]
assert get_odd_collatz(5) == [1, 5]
assert get_odd_collatz(7) == [1, 7]
assert get_odd_collatz(10) == [1]
assert get_odd_collatz(27) == [1, 27]
assert get_odd_collatz(100) == [1]
assert_raises(ArgumentError) { get_odd_collatz(-1) }
assert_raises(ArgumentError) { get_odd_collatz(0) }
assert_raises(ArgumentError) { get_odd_collatz(3.14) }
assert_raises(ArgumentError) { get_odd_collatz("5") }
assert get_odd_collatz(20) == [1]
assert get_odd_collatz(1000) == [1]
assert get_odd_collatz(1000000) == [1]

