assert remove_duplicates([1, 2, 3, 2, 4]) == [1, 3, 4]
assert remove_duplicates([1, 1, 1, 1]) == []
assert remove_duplicates([]) == []
assert remove_duplicates([5, 4, 3, 2, 1, 1, 2, 3, 4, 5]) == []
assert remove_duplicates([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]
assert remove_duplicates([1,2,2,3,3,3,4,4,4,4]) == [1]
assert remove_duplicates([1, 2, 3, 4, 5, 1, 2, 3, 4, 5]) == []
assert remove_duplicates([5,5,5,4,4,4,3,3,3,2,2,2,1,1,1]) == []
assert remove_duplicates([1]) == [1]
assert remove_duplicates([1, 1, 2, 2, 3, 3]) == []

