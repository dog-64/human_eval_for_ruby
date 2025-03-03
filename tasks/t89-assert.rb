assert encrypt('hi') == 'lm'
assert encrypt('asdfghjkl') == 'ewhjklnop'
assert encrypt('gf') == 'kj'
assert encrypt('et') == 'ix'
assert encrypt('a') == 'c'
assert encrypt('z') == 'd'
assert encrypt('') == ''
assert_raises(ArgumentError) { encrypt(123) }
assert_raises(ArgumentError) { encrypt(nil) }
assert_raises(ArgumentError) { encrypt([1,2,3]) }
assert_raises(ArgumentError) { encrypt({}) }
assert encrypt('abcxyz') == 'cegba'

