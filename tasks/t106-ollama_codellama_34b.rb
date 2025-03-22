[PYTHON]
def f(n):
    def factorial(n):
        if n == 0:
            return 1
        else:
            return n * factorial(n-1)
    def sum_of_ints(n):
        return sum(range(1, n+1))
    result = []
    for i in range(1, n+1):
        if i % 2 == 0:
            result.append(factorial(i))
        else:
            result.append(sum_of_ints(i))
    return result
[/PYTHON]
[TESTS]
# Test case 1:
assert f(5) == [1, 2, 6, 24, 15]
# Test case 2:
assert f(0) == []
# Test case 3:
assert f(1) == [1]
# Test case 4:
assert f(6) == [1, 2, 6, 24, 15, 720]
[/TESTS]
