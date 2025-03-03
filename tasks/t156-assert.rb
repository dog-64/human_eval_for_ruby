assert int_to_mini_roman(19) == "xix"
assert int_to_mini_roman(152) == "clii"
assert int_to_mini_roman(426) == "cdxxvi"
assert int_to_mini_roman(1) == "i"
assert int_to_mini_roman(1000) == "m"
assert int_to_mini_roman(999) == "cmxcix"
assert int_to_mini_roman(4) == "iv"
assert int_to_mini_roman(9) == "ix"
assert int_to_mini_roman(40) == "xl"
assert int_to_mini_roman(90) == "xc"
assert int_to_mini_roman(400) == "cd"
assert int_to_mini_roman(900) == "cm"
assert_raises(ArgumentError) { int_to_mini_roman(0) }
assert_raises(ArgumentError) { int_to_mini_roman(1001) }
assert_raises(ArgumentError) { int_to_mini_roman(-1) }
assert_raises(ArgumentError) { int_to_mini_roman(3.14) }
assert_raises(ArgumentError) { int_to_mini_roman("abc") }

