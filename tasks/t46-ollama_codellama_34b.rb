[PYTHON]
def fib4(n):
    if n <= 3:
        return 0
    elif n == 4:
        return 2
    else:
        a, b, c, d = 0, 0, 2, 4
        for i in range(4, n+1):
            a, b, c, d = b, c, d, a + b + c + d
        return a
[/PYTHON]
[TESTS]
# Test case 1:
assert fib4(0) == 0
# Test case 2:
assert fib4(1) == 0
# Test case 3:
assert fib4(2) == 2
# Test case 4:
assert fib4(3) == 0
# Test case 5:
assert fib4(4) == 2
# Test case 6:
assert fib4(5) == 4
# Test case 7:
assert fib4(6) == 8
# Test case 8:
assert fib4(7) == 14
[/TESTS]
