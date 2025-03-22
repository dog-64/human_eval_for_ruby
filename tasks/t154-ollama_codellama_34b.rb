[PYTHON]
def cycpattern_check(a, b):
    return a in b + b
[/PYTHON]
[TESTS]
# Test case 1:
assert cycpattern_check("abcd", "abd") == False
# Test case 2:
assert cycpattern_check("hello", "ell") == True
# Test case 3:
assert cycpattern_check("whassup", "psus") == False
# Test case 4:
assert cycpattern_check("abab", "baa") == True
# Test case 5:
assert cycpattern_check("efef", "eeff") == False
# Test case 6:
assert cycpattern_check("himenss", "simen") == True
# Test case 7:
assert cycpattern_check("", "") == True
# Test case 8:
assert cycpattern_check("a", "") == True
# Test case 9:
assert cycpattern_check("", "a") == False
[/TESTS]
