assert unique_digits([15, 33, 1422, 1]) == [1, 15, 33]
assert unique_digits([152, 323, 1422, 10]) == []
assert unique_digits([1, 3, 5, 7, 9, 111, 333]) == [1, 3, 5, 7, 9, 111, 333]
assert unique_digits([]) == []
assert unique_digits([1, 3, 5, 7, 9, 111, 333, 11111]) == [1, 3, 5, 7, 9, 111, 333, 11111]
assert unique_digits([999999]) == [999999]
assert unique_digits([1000000]) == []
assert unique_digits([123, 456, 789]) == []
assert unique_digits([111111, 222222]) == [111111]
assert unique_digits([1, 11, 111, 1111]) == [1, 11, 111, 1111]
assert unique_digits([5, 15, 25, 35]) == [5, 15, 35]
assert_raises(ArgumentError) { unique_digits([-1])}
assert_raises(ArgumentError) { unique_digits([1.5])}
assert_raises(ArgumentError) { unique_digits("string")}
assert_raises(ArgumentError) { unique_digits(nil)}
assert_raises(ArgumentError) { unique_digits({})}

