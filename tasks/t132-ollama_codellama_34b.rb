[PYTHON]
def is_nested(string):
    stack = []
    for char in string:
        if char == '[':
            stack.append(char)
        elif char == ']':
            if len(stack) == 0:
                return False
            stack.pop()
    return len(stack) == 0
[/PYTHON]
[TESTS]
# Test case 1:
assert is_nested('[[]]') == True
# Test case 2:
assert is_nested('[]]]]]]][[[[[]') == False
# Test case 3:
assert is_nested('[][]') == False
# Test case 4:
assert is_nested('[]') == False
# Test case 5:
assert is_nested('[[][]]') == True
# Test case 6:
assert is_nested('[[]][[') == True
# Test case 7:
assert is_nested('') == False
# Test case 8:
assert is_nested('[[[]]]') == True
# Test case 9:
assert is_nested('[[[]]') == False
# Test case 10:
assert is_nested('[[[[]]]]') == True
[/TESTS]
