[PYTHON]
def find_max(words):
    if not words:
        return ""
    unique_chars = set()
    max_len = 0
    max_word = ""
    for word in words:
        curr_len = len(word)
        if curr_len > max_len:
            max_len = curr_len
            max_word = word
        elif curr_len == max_len and word < max_word:
            max_word = word
    return max_word
[/PYTHON]
[TESTS]
# Test case 1:
assert find_max([]) == ""
# Test case 2:
assert find_max(["name", "of", "string"]) == "string"
# Test case 3:
assert find_max(["name", "enam", "game"]) == "enam"
# Test case 4:
assert find_max(["aaaaaaa", "bb", "cc"]) == "aaaaaaa"
# Test case 5:
assert find_max(["hello", "world"]) == "hello"
[/TESTS]
