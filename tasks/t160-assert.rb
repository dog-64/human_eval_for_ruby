assert do_algebra(['+', '*', '-'], [2, 3, 4, 5]) == 9
assert do_algebra(['//', '**'], [10, 2, 3]) == 1
assert do_algebra(['+'], [1, 2]) == 3
assert do_algebra(['+', '-','*'], [1,2,3,4]) == 9
assert do_algebra(['**', '//'], [2,3,4]) == 0
assert_raises(ArgumentError) { do_algebra([], [1,2]) }
assert_raises(ArgumentError) { do_algebra(['+'], []) }
assert_raises(ArgumentError) { do_algebra(['+', '*'], [1,2,3,4,5]) }
assert_raises(ArgumentError) { do_algebra(['+','-'], [1,2,3]) }
assert do_algebra(['+','-','*','//'], [10,5,2,2,1]) == 0
assert do_algebra(['**'], [2,3]) == 8
assert_raises(ArgumentError) {do_algebra(['a'],[1,2])}
assert_raises(ArgumentError) {do_algebra(['+'],[1,-2])}

