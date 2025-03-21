[PYTHON]
def prime_fib(n):
    a, b = 0, 1
    while n > 0:
        a, b = b, a + b
        if b % 2 == 0:
            n -= 1
    return a
[/PYTHON]
[TESTS]
# Test case 1:
assert prime_fib(1) == 2
# Test case 2:
assert prime_fib(2) == 3
# Test case 3:
assert prime_fib(3) == 5
# Test case 4:
assert prime_fib(4) == 13
# Test case 5:
assert prime_fib(5) == 89
[/TESTS]
