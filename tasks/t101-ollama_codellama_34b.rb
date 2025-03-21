[PYTHON]
def words_string(s):
    words = s.split(", ")
    return words
[/PYTHON]
[TESTS]
# Test case 1:
assert words_string("") == []
# Test case 2:
assert words_string("Hello World") == ["Hello", "World"]
# Test case 3:
assert words_string("Hello, World") == ["Hello", "World"]
# Test case 4:
assert words_string("Hello, World, Python") == ["Hello", "World", "Python"]
# Test case 5:
assert words_string("Hello, World, Python, Ruby") == ["Hello", "World", "Python", "Ruby"]
[/TESTS]
