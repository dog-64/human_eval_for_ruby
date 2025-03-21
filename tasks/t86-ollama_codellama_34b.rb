[PYTHON]
def anti_shuffle(s):
    words = s.split()
    return " ".join(sorted(words, key=lambda x: sorted(x)))
[/PYTHON]
[TESTS]
# Test case 1:
assert anti_shuffle('Hi') == 'Hi'
# Test case 2:
assert anti_shuffle('hello') == 'ehllo'
# Test case 3:
assert anti_shuffle('Hello World!!!') == 'Hello !!!Wdlor'
# Test case 4:
assert anti_shuffle('a b c') == 'a b c'
# Test case 5:
assert anti_shuffle('') == ''
[/TESTS]
