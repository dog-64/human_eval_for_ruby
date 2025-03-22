[PYTHON]
def is_prime?(n):
    if n <= 1:
        return False
    for i in range(2, n):
        if n % i == 0:
            return False
    return True
[/PYTHON]
[TESTS]
# Test case 1:
assert is_prime?(1) == False
# Test case 2:
assert is_prime?(2) == True
# Test case 3:
assert is_prime?(3) == True
# Test case 4:
assert is_prime?(4) == False
# Test case 5:
assert is_prime?(5) == True
# Test case 6:
assert is_prime?(6) == False
# Test case 7:
assert is_prime?(7) == True
# Test case 8:
assert is_prime?(8) == False
# Test case 9:
assert is_prime?(9) == False
# Test case 10:
assert is_prime?(10) == False
[/TESTS]
