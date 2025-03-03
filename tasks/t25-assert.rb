assert factorize(8) == [2, 2, 2]
assert factorize(25) == [5, 5]
assert factorize(70) == [2, 5, 7]
assert factorize(1) == []
assert factorize(-10) == [-1, 2, 5]
assert factorize(12) == [2,2,3]
assert factorize(99) == [3,3,11]
assert factorize(100) == [2,2,5,5]
assert factorize(-1) == [-1]
assert factorize(2) == [2]
assert factorize(3) == [3]
assert factorize(0) == [] #Special case for 0
assert_raises(ArgumentError) {factorize(3.14)} #Error handling for non-integer input
assert_raises(ArgumentError) {factorize("hello")} #Error handling for non-integer input
assert_raises(ArgumentError) {factorize([])} #Error handling for non-integer input
assert_raises(ArgumentError) {factorize({})} #Error handling for non-integer input
assert factorize(-13) == [-1, 13]
assert factorize(1001) == [7, 11, 13]
assert factorize(1000) == [2,2,2,5,5,5]

