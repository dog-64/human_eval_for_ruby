assert choose_num(12, 15) == 14
assert choose_num(13, 15) == 14
assert choose_num(13, 12) == -1
assert choose_num(1, 3) == 2
assert choose_num(1, 1) == -1
assert choose_num(2, 2) == 2
assert choose_num(100, 101) == 100
assert choose_num(100, 100) == 100
assert choose_num(1,100) == 100
assert choose_num(99,101) == 100
assert choose_num(5,5) == -1
assert choose_num(6,6) == 6
assert choose_num(1,2) == 2
assert choose_num(3,4) == 4
assert choose_num(1000,1002) == 1002
assert choose_num(1001,1002) == 1002
assert choose_num(1001,1001) == -1
