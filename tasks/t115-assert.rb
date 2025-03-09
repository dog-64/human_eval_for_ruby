assert max_fill([[0,0,1,0], [0,1,0,0], [1,1,1,1]], 1) == 6
assert max_fill([[0,0,1,1], [0,0,0,0], [1,1,1,1], [0,1,1,1]], 2) == 5
assert max_fill([[0,0,0], [0,0,0]], 5) == 0
assert max_fill([[1,1,1,1],[1,1,1,1],[1,1,1,1]],1) == 12
assert max_fill([[1,1,1,1],[1,1,1,1],[1,1,1,1]],2) == 6
assert max_fill([[1,1,1,1],[1,1,1,1],[1,1,1,1]],3) == 4
assert max_fill([[1,1,1,1],[1,1,1,1],[1,1,1,1]],4) == 3
assert max_fill([[1,1,1,1],[1,1,1,1],[1,1,1,1]],10) == 1
assert max_fill([[]],1) == 0
assert max_fill([[1]],1) == 1
assert max_fill([[1,0,1,0],[0,1,0,1]], 1) == 4
assert max_fill([[1,0,1,0],[0,1,0,1]], 2) == 2
assert max_fill([[1,0,1,0],[0,1,0,1]], 3) == 2
assert max_fill([[1,0,1,0],[0,1,0,1]], 4) == 1
assert_raises(ArgumentError) {max_fill([[1,2,3]],1)}
assert_raises(ArgumentError) {max_fill([[1,1],[1,2]],1)}
assert_raises(ArgumentError) {max_fill([[1,1],[1,1]],0)}
assert_raises(ArgumentError) {max_fill([[1,1],[1,1]],-1)}
