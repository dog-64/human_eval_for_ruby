assert next_smallest([1, 2, 3, 4, 5]) == 2
assert next_smallest([5, 1, 4, 3, 2]) == 2
assert next_smallest([]) == nil
assert next_smallest([1, 1]) == nil
assert next_smallest([3, 1, 1, 2, 5]) == 2
assert next_smallest([5, 5, 5]) == nil
assert next_smallest([1]) == nil
assert next_smallest([1,2]) == 2
assert next_smallest([-5, -1, 0, 5]) == -1
assert next_smallest([100, 200, 300, 400, 500]) == 200
assert next_smallest([5, 4, 3, 2, 1]) == 2
assert next_smallest([1, 5, 2, 4, 3]) == 2
assert next_smallest([-10, -5, 0, 5, 10]) == -5
assert next_smallest([0, 0, 0]) == nil
assert next_smallest([1, 1, 2, 2, 3]) == 2

