[PYTHON]
def filter_by_prefix(strings, prefix):
    return [string for string in strings if string.startswith(prefix)]
[/PYTHON]
[TESTS]
# Test case 1:
assert filter_by_prefix([], 'a') == []
# Test case 2:
assert filter_by_prefix(['abc', 'bcd', 'cde', 'array'], 'a') == ['abc', 'array']
# Test case 3:
assert filter_by_prefix(['apple', 'apricot', 'banana'], 'app') == ['apple', 'apricot']
# Test case 4:
assert filter_by_prefix(['hello', 'world'], 'xyz') == []
# Test case 5:
assert filter_by_prefix(['hello', 'world'], '') == ['hello', 'world']
[/TESTS]
