[PYTHON]
def split_words(txt):
    words = []
    for word in txt.split():
        words.append(word)
    return len(words)
[/PYTHON]
[TESTS]
# Test case 1:
assert split_words("Hello world!") == 2
# Test case 2:
assert split_words("Hello,world!") == 2
# Test case 3:
assert split_words("abcdef") == 3
# Test case 4:
assert split_words("A") == 0
# Test case 5:
assert split_words("") == 0
[/TESTS]
