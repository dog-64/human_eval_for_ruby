assert is_sorted?([5]) == true
assert is_sorted?([1, 2, 3, 4, 5]) == true
assert is_sorted?([1, 3, 2, 4, 5]) == false
assert is_sorted?([1, 2, 3, 4, 5, 6]) == true
assert is_sorted?([1, 2, 3, 4, 5, 6, 7]) == true
assert is_sorted?([1, 3, 2, 4, 5, 6, 7]) == false
assert is_sorted?([1, 2, 2, 3, 3, 4]) == true
assert is_sorted?([1, 2, 2, 2, 3, 4]) == false
assert is_sorted?([]) == true
assert is_sorted?([0]) == true
assert is_sorted?([1,1]) == false
assert is_sorted?([1,2,2,3,4,4]) == false
assert is_sorted?([0,1,2,3,4,5]) == true
assert is_sorted?([5,4,3,2,1]) == false
assert_raises(ArgumentError) {is_sorted?(nil)}
assert_raises(ArgumentError) {is_sorted?("string")}
assert_raises(ArgumentError) {is_sorted?({})}

