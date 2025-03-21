[PYTHON]
def is_palindrome?(text):
    return text.lower().replace(" ", "") == text.lower().replace(" ", "")[::-1]
[/PYTHON]
[TESTS]
# Test case 1:
assert is_palindrome?("") == true
# Test case 2:
assert is_palindrome?("aba") == true
# Test case 3:
assert is_palindrome?("A man, a plan, a canal: Panama") == true
# Test case 4:
assert is_palindrome?("aaaaa") == true
# Test case 5:
assert is_palindrome?("zbcd") == false
# Test case 6:
assert is_palindrome?("race a car") == false
[/TESTS]
