[PYTHON]
def all_prefixes(string):
    return [string[:i] for i in range(1, len(string) + 1)]
[/PYTHON]
[TESTS]
# Test case 1:
assert all_prefixes('') == []
# Test case 2:
assert all_prefixes('a') == ['a']
# Test case 3:
assert all_prefixes('ab') == ['a', 'ab']
# Test case 4:
assert all_prefixes('abc') == ['a', 'ab', 'abc']
# Test case 5:
assert all_prefixes('xyz') == ['x', 'xy', 'xyz']
[/TESTS]
