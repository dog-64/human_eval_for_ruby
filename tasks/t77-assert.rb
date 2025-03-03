assert iscube(1) == true
assert iscube(8) == true
assert iscube(27) == true
assert iscube(64) == true
assert iscube(125) == true
assert iscube(0) == true
assert iscube(-1) == true
assert iscube(-8) == true
assert iscube(2) == false
assert iscube(3) == false
assert iscube(10) == false
assert iscube(-2) == false
assert iscube(180) == false
assert iscube(-180) == false
assert iscube(1000) == true
assert iscube(-1000) == true

