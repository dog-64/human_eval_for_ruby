[PYTHON]
def largest_divisor(n):
    if n <= 1:
        return None
    
    for i in range(int(n / 2), 0, -1):
        if n % i == 0:
            return i
    
    return None
[/PYTHON]
[TESTS]
# Test case 1:
assert largest_divisor(15) == 5
# Test case 2:
assert largest_divisor(12) == 6
# Test case 3:
assert largest_divisor(7) == 1
# Test case 4:
assert largest_divisor(1) == None
# Test case 5:
assert largest_divisor(0) == None
[/TESTS]
