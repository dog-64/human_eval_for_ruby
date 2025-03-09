assert maximum([-3, -4, 5], 3) == [-4, -3, 5]
assert maximum([4, -4, 4], 2) == [4, 4]
assert maximum([-3, 2, 1, 2, -1, -2, 1], 1) == [2]
assert maximum([1, 2, 3, 4, 5], 0) == []
assert maximum([1, 2, 3, 4, 5], 5) == [1, 2, 3, 4, 5]
assert maximum([5, 4, 3, 2, 1], 3) == [2, 3, 4, 5]
assert maximum([-1000, 1000, 0], 2) == [0, 1000]
assert maximum([1], 1) == [1]
assert maximum([1,1,1,1,1],3) == [1,1,1]
assert_raises(ArgumentError) { maximum([1,2,3],-1) }
assert_raises(ArgumentError) { maximum([1,2,3],4) }
assert_raises(TypeError) { maximum("string", 1)}
assert_raises(TypeError) { maximum([1,2,3], "k")}
assert maximum([1,2,3],0) == []
assert maximum([], 0) == []
