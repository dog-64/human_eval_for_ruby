[PYTHON]
def concatenate(strings):
    return "".join(strings)
[/PYTHON]
[TESTS]
# Test case 1:
assert concatenate([]) == ""
# Test case 2:
assert concatenate(['a', 'b', 'c']) == "abc"
# Test case 3:
assert concatenate(['Hello', ' ', 'World!']) == "Hello World!"
# Test case 4:
assert concatenate(['1', '2', '3', '4', '5']) == "12345"
# Test case 5:
assert concatenate(['Test', 'Example']) == "TestExample"
[/TESTS]
