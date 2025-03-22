assert do_algebra(['*', '+', '-'], [2, 3, 4, 5]) == 5
assert do_algebra(['/', '**'], [10, 2, 3]) == 125
assert do_algebra(['+'], [1, 2]) == 3
assert do_algebra(['+', '-', '*'], [1, 2, 3, 4]) == 0
assert do_algebra(['**', '/'], [2, 3, 4]) == 2
assert do_algebra(['+', '-', '*', '/'], [10, 5, 2, 2, 2]) == 13
assert do_algebra(['**'], [2, 3]) == 8
