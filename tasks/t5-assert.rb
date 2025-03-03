assert intersperse([], 4) == []
assert intersperse([1, 2, 3], 4) == [1, 4, 2, 4, 3]
assert intersperse([10, 20, 30, 40], 0) == [10, 0, 20, 0, 30, 0, 40]
assert intersperse([1], 4) == [1]
assert intersperse([-1, 0, 1], 4) == [-1, 4, 0, 4, 1]
assert intersperse([1, 2, 3, 4, 5], 0) == [1, 0, 2, 0, 3, 0, 4, 0, 5]

