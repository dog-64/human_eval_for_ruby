[PYTHON]
def solve(s):
    return "".join(c.lower() if c.isalpha() else c.upper() for c in s[::-1])
[/PYTHON]
[TESTS]
# Test case 1:
assert solve("1234") == "4321"
# Test case 2:
assert solve("ab") == "AB"
# Test case 3:
assert solve("#a@C") == "#A@c"
# Test case 4:
assert solve("ABC123def") == "cba123DEF"
# Test case 5:
assert solve("") == ""

[/TESTS]
