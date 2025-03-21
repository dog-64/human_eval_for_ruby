[PYTHON]
def factorize(n):
    factors = []
    i = 2
    while i * i <= n:
        if n % i:
            i += 1
        else:
            n //= i
            factors.append(i)
    if n > 1:
        factors.append(n)
    return factors
[/PYTHON]
[TESTS]
# Test case 1:
assert factorize(8) == [2, 2, 2]
# Test case 2:
assert factorize(25) == [5, 5]
# Test case 3:
assert factorize(70) == [2, 5, 7]
# Test case 4:
assert factorize(1) == []
# Test case 5:
assert factorize(-10) == [-1, 2, 5]
[/TESTS]
