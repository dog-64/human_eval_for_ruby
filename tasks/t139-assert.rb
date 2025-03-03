assert special_factorial(1) == 1
assert special_factorial(2) == 2
assert special_factorial(3) == 12
assert special_factorial(4) == 288
assert special_factorial(5) == 34560
assert_raises(ArgumentError) { special_factorial(-1) }
assert_raises(ArgumentError) { special_factorial(0) }
assert_raises(TypeError) { special_factorial(3.14) }
assert_raises(TypeError) { special_factorial("4") }
assert_raises(TypeError) { special_factorial([4]) }
assert_raises(TypeError) { special_factorial({4 => 4})}

