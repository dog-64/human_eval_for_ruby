assert can_arrange([1, 2, 4, 3, 5]) == 3
assert can_arrange([1, 2, 3]) == -1
assert can_arrange([5, 4, 3, 2, 1]) == 1
assert can_arrange([]) == -1
assert can_arrange([1]) == -1
assert can_arrange([2,1]) == 1
assert can_arrange([1,3,2,4,5]) == 2
assert can_arrange([5,4,3,2,1,0]) == 1
assert can_arrange([10,9,8,7,6,5,4,3,2,1]) == 1
assert can_arrange([-1,0,1,2,3]) == -1
assert can_arrange([3,2,1,-1]) == 1
assert can_arrange([100, 50, 75, 25, 150]) == 3
assert can_arrange([100, 101, 102, 103, 104]) == -1

