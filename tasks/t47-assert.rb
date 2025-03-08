assert median([3, 1, 2, 4, 5]) == 3
assert median([-10, 4, 6, 1000, 10, 20]) == 8
assert median([1, 2]) == 1.5
assert_raises(ArgumentError) { median([]) }
assert median([1, 2, 3, 4, 5, 6]) == 3.5
assert median([1, 1, 1, 1]) == 1
assert_raises(ArgumentError) { median([1, 2, 'a']) }
assert_raises(ArgumentError) { median([1, 2, nil]) }
assert median([100, 200, 300, 400]) == 250.0
assert median([-5, 0, 5, 10]) == 2.5
assert median([1, 2, 3, 4, 5, 6, 7, 8]) == 4.5
assert median([1]) == 1.0
assert median([-1, 0, 1]) == 0
assert median([1.1, 2.2, 3.3]) == 2.2
assert_raises(ArgumentError) { median([1, 2, {}]) }
