[PYTHON]
def histogram(text):
    result = {}
    for char in text:
        if char.islower():
            if char not in result:
                result[char] = 1
            else:
                result[char] += 1
    return result
[/PYTHON]
[TESTS]
# Test case 1:
assert histogram('') == {}
# Test case 2:
assert histogram('a b c') == {'a': 1, 'b': 1, 'c': 1}
# Test case 3:
assert histogram('a b b a') == {'a': 2, 'b': 2}
# Test case 4:
assert histogram('a b c a b') == {'a': 2, 'b': 2}
# Test case 5:
assert histogram('b b b b a') == {'b': 4}
[/TESTS]
