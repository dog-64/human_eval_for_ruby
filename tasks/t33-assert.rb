assert sort_third([1, 2, 3]) == [1, 2, 3]
assert sort_third([5, 6, 3, 4, 8, 9, 2]) == [2, 6, 3, 4, 8, 9, 5]
assert sort_third([]) == []
assert sort_third([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
assert sort_third([10, 9, 8, 7, 6, 5, 4, 3, 2, 1]) == [1, 9, 8, 7, 6, 5, 4, 3, 2, 10]
assert sort_third([3, 6, 9, 12]) == [3, 6, 9, 12]
assert sort_third([1.1, 2.2, 3.3, 4.4, 5.5, 6.6]) == [1.1, 2.2, 3.3, 4.4, 5.5, 6.6]
assert sort_third([1, 2, 3, 4, 5, 6]) == [1, 2, 3, 4, 5, 6]

