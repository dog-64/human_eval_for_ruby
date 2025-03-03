assert unique([5, 3, 5, 2, 3, 3, 9, 0, 123]) == [0, 2, 3, 5, 9, 123]
assert unique([]) == []
assert unique(["a", "b", "a", "c", "b"]) == ["a", "b", "c"]
assert unique([1, 1, 1, 1]) == [1]
assert unique([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
assert unique([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]
assert unique([1, 100, 2, 1000, 3, 10000]) == [1, 2, 3, 100, 1000, 10000]
assert unique(["apple", "banana", "apple", "cherry"]) == ["apple", "banana", "cherry"]
assert unique([true, false, true]) == [false, true]
assert unique([1, 2, 3, nil, 4, nil, 5]) == [1, 2, 3, 4, 5, nil]
assert_valid_order unique([5, 3, 5, 2, 3, 3, 9, 0, 123])
assert_valid_order unique([])
assert_valid_order unique(["a", "b", "a", "c", "b"])

