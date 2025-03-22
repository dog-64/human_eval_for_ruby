[PYTHON]
def simplify(x, n):
    return x * n == int(x) * int(n)
[/PYTHON]
[TESTS]
# Test case 1:
assert simplify("1/5", "5/1") == True
# Test case 2:
assert simplify("1/6", "2/1") == False
# Test case 3:
assert simplify("7/10", "10/2") == False
# Test case 4:
assert simplify("3/4", "8/6") == False
# Test case 5:
assert simplify("2/3", "6/4") == True
[/TESTS]
