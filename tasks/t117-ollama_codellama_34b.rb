[PYTHON]
def select_words(s, n):
    words = s.split()
    return [word for word in words if len(word) == n and word.isalpha()]
[/PYTHON]
[TESTS]
# Test case 1:
assert select_words("Mary had a little lamb", 4) == ["little"]
# Test case 2:
assert select_words("Mary had a little lamb", 3) == ["Mary", "lamb"]
# Test case 3:
assert select_words("simple white space", 2) == []
# Test case 4:
assert select_words("Hello world", 4) == ["world"]
# Test case 5:
assert select_words("Uncle sam", 3) == ["Uncle"]
[/TESTS]
