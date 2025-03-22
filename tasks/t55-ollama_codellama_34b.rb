[PYTHON]
def fib(n):
    if n <= 1:
        return n
    else:
        return fib(n-1) + fib(n-2)
[/PYTHON]
[TESTS]
# Test case 1:
assert fib(1) == 1
# Test case 2:
assert fib(8) == 21
# Test case 3:
assert fib(10) == 55
# Test case 4:
assert fib(20) == 6765
# Test case 5:
assert fib(30) == 832040
[/TESTS]
