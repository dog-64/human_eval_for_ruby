assert decimal_to_binary(15) == "db1111db"
assert decimal_to_binary(32) == "db100000db"
assert decimal_to_binary(0) == "db0db"
assert decimal_to_binary(1) == "db1db"
assert decimal_to_binary(2) == "db10db"
assert decimal_to_binary(10) == "db1010db"
assert decimal_to_binary(100) == "db1100100db"
assert decimal_to_binary(1023) == "db1111111111db"
assert_raises(ArgumentError) { decimal_to_binary(-1) }
assert_raises(ArgumentError) { decimal_to_binary(3.14) }
assert_raises(ArgumentError) { decimal_to_binary("15") }
assert_raises(ArgumentError) { decimal_to_binary([15]) }
assert_raises(ArgumentError) { decimal_to_binary({15 => 15})}

