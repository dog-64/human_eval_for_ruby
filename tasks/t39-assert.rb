assert prime_fib(1) == 2
assert prime_fib(2) == 3
assert prime_fib(3) == 5
assert prime_fib(4) == 13
assert prime_fib(5) == 89
assert_raises(ArgumentError) { prime_fib(-1) }
assert_raises(ArgumentError) { prime_fib(0) }
assert prime_fib(6) == 233
assert prime_fib(7) == 1597
assert prime_fib(8) == 28657

