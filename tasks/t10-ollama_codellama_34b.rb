[PYTHON]
def make_palindrome(string):
    return string + string[::-1]
[/PYTHON]
[TESTS]
# Test case 1:
assert make_palindrome("") == ""
# Test case 2:
assert make_palindrome("cat") == "catac"
# Test case 3:
assert make_palindrome("cata") == "catac"
# Test case 4:
assert make_palindrome("a") == "a"
# Test case 5:
assert make_palindrome("aba") == "aba"
[/TESTS]
