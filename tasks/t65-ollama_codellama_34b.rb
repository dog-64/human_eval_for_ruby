[PYTHON]
def circular_shift(x, shift):
    if x < 0 or shift < 0:
        raise ValueError("Invalid input")
    # Get the list of digits
    digits = list(str(x))
    # If the shift is greater than the number of digits, return the digits in reverse order
    if shift >= len(digits):
        return "".join(reversed(digits))
    # Otherwise, rotate the list by the specified amount
    else:
        digits = digits[shift:] + digits[:shift]
        return "".join(digits)
[/PYTHON]
[TESTS]
# Test case 1:
assert circular_shift(12, 1) == "21"
# Test case 2:
assert circular_shift(12, 2) == "12"
# Test case 3:
assert circular_shift(12345, 2) == "45123"
# Test case 4:
assert circular_shift(123, 4) == "321"
# Test case 5:
assert circular_shift(123, 0) == "123"
[/TESTS]
