assert move_one_ball([3, 4, 5, 1, 2]) == true
assert move_one_ball([1, 2, 3, 4, 5]) == true
assert move_one_ball([5, 1, 2, 3, 4]) == true
assert move_one_ball([3, 5, 4, 1, 2]) == false
assert move_one_ball([1, 5, 2, 4, 3]) == false
assert move_one_ball([]) == true
assert move_one_ball([1]) == true
assert move_one_ball([1,2,3]) == true
assert move_one_ball([3,2,1]) == false
assert move_one_ball([10,20,30,40,50]) == true
assert move_one_ball([50,10,20,30,40]) == true
assert move_one_ball([-1,0,1]) == true
assert move_one_ball([1,0,-1]) == true
assert move_one_ball([-1,1,0]) == true
assert move_one_ball([0,-1,1]) == true

