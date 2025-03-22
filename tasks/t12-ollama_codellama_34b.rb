[PYTHON]
def longest(strings):
    if not strings:
        return None
    return max(strings, key=len)
[/PYTHON]
[TESTS]
# Test case 1:
assert longest([]) == None
# Test case 2:
assert longest(['a', 'b', 'c']) == 'a'
# Test case 3:
assert longest(['a', 'bb', 'ccc']) == 'ccc'
# Test case 4:
assert longest(['abcd', 'efg', 'hijklmn']) == 'hijklmn'
# Test case 5:
assert longest(['xyz', 'xyz']) == 'xyz'
[/TESTS]
