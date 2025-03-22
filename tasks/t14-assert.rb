assert all_prefixes('abc') == ['a', 'ab', 'abc']
assert all_prefixes('xyz') == ['x', 'xy', 'xyz']
assert all_prefixes('') == []
assert all_prefixes('a') == ['a']
assert all_prefixes('12345') == ['1', '12', '123', '1234', '12345']
assert all_prefixes(' ') == [' ']

