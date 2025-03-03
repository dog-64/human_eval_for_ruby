assert common([1, 4, 3, 34, 653, 2, 5], [5, 7, 1, 5, 9, 653, 121]) == [1, 5, 653]
assert common([5, 3, 2, 8], [3, 2]) == [2, 3]
assert common([], []) == []
assert common([1, 2, 3], []) == []
assert common([], [1, 2, 3]) == []
assert common([1, 2, 3], [4, 5, 6]) == []
assert common([1, 1, 2, 2, 3, 3], [2, 2, 3, 3, 4, 4]) == [2, 3]
assert common([:a, :b, :c], [:c, :d, :e]) == [:c]
assert common(["a", "b", "c"], ["c", "d", "e"]) == ["c"]
assert_valid_order common([1, 4, 3, 34, 653, 2, 5], [5, 7, 1, 5, 9, 653, 121])
assert_valid_order common([5, 3, 2, 8], [3, 2])

