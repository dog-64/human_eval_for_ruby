assert largest_prime_factor(13195) == 29
assert largest_prime_factor(2048) == 2
assert largest_prime_factor(100) == 5
assert largest_prime_factor(102) == 17
assert largest_prime_factor(999) == 37
assert largest_prime_factor(1000) == 5
assert_raises(ArgumentError) { largest_prime_factor(1) }
assert_raises(ArgumentError) { largest_prime_factor(2) }
assert_raises(ArgumentError) { largest_prime_factor(-10) }
assert_raises(ArgumentError) { largest_prime_factor(0) }
assert_raises(ArgumentError) { largest_prime_factor(3.14) }
assert largest_prime_factor(6) == 3
assert largest_prime_factor(12) == 3
assert largest_prime_factor(10000000) == 5
assert largest_prime_factor(100000000) == 5

