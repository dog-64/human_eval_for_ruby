[PYTHON]
def correct_bracketing(brackets):
    stack = []
    for char in brackets:
        if char == "<":
            stack.append(char)
        elif char == ">":
            if len(stack) == 0:
                return False
            stack.pop()
        else:
            return False
    return len(stack) == 0
[/PYTHON]
[TESTS]
# Test case 1:
assert correct_bracketing("") == True
# Test case 2:
assert correct_bracketing("<") == False
# Test case 3:
assert correct_bracketing("<>") == True
# Test case 4:
assert correct_bracketing("<<><>>") == True
# Test case 5:
assert correct_bracketing("><<>") == False
[/TESTS]
