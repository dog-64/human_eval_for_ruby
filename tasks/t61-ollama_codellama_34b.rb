[PYTHON]
def correct_bracketing(brackets):
    # Initialize a stack to keep track of the opening brackets
    stack = []
    # Iterate through the brackets in the string
    for bracket in brackets:
        # If we encounter an opening bracket, add it to the stack
        if bracket == "(":
            stack.append(bracket)
        # If we encounter a closing bracket, pop an opening bracket from the stack
        # If the stack is empty, we have an unmatched closing bracket, so return False
        elif bracket == ")":
            if not stack:
                return False
            stack.pop()
    # If the stack is not empty at the end, we have unmatched opening brackets, so return False
    return not stack
[/PYTHON]
[TESTS]
# Test case 1:
assert correct_bracketing("") == True
# Test case 2:
assert correct_bracketing("()") == True
# Test case 3:
assert correct_bracketing("(()())") == True
# Test case 4:
assert correct_bracketing(")(()") == False
# Test case 5:
assert correct_bracketing("(") == False
# Test case 6:
assert correct_bracketing(")") == False
# Test case 7:
assert correct_bracketing("(())(()))") == False
# Test case 8:
assert correct_bracketing("((())") == False
# Test case 9:
assert correct_bracketing("((())") == False
# Test case 10:
assert correct_bracketing("(())(()))") == False
[/TESTS]
