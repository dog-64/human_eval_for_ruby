assert compare([1, 2, 3, 4, 5, 1], [1, 2, 3, 4, 2, -2]) == [0, 0, 0, 0, 3, 3]
assert compare([0, 5, 0, 0, 0, 4], [4, 1, 1, 0, 0, -2]) == [4, 4, 1, 0, 0, 6]
assert compare([10, -5, 0, 100], [10, -5, 0, 100]) == [0, 0, 0, 0]
assert compare([-1, 0, 1], [-1, 0, 1]) == [0, 0, 0]
assert compare([1, 2, 3], [1, 2, 3]) == [0, 0, 0]
assert_raises(ArgumentError) { compare([1,2], [1,2,3]) }
assert_raises(ArgumentError) { compare([1,2,3], [1,2]) }
assert_raises(ArgumentError) { compare([], []) }
assert_raises(TypeError) { compare([1, 2, "a"], [1, 2, 3]) }
assert_raises(TypeError) { compare([1, 2, 3], [1, 2, "a"]) }

