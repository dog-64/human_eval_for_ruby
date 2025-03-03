assert x_or_y(7, 34, 12) == 34
assert x_or_y(15, 8, 5) == 5
assert x_or_y(2, "простое", "составное") == "простое"
assert x_or_y(4, true, false) == false
assert x_or_y(0, 10, 20) == 20
assert x_or_y(1, "a", "b") == "b"
assert x_or_y(23, 1, 0) == 1
assert x_or_y(100, "x", "y") == "y"
assert x_or_y(3, 1, 0) == 1
assert x_or_y(97, true, false) == true
assert x_or_y(4, [], [1,2,3]) == [1,2,3]
assert x_or_y(5, {}, {a:1}) == {a:1}
assert x_or_y(6, "non-empty string", "") == ""
assert x_or_y(2, [1], []) == [1]

