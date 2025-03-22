[PYTHON]
def intersection(interval1, interval2):
    start = max(interval1[0], interval2[0])
    end = min(interval1[1], interval2[1])
    if start <= end:
        length = end - start + 1
        return "YES" if is_prime(length) else "NO"
    else:
        return "NO"

def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True
[/PYTHON]
[TESTS]
# Test case 1:
assert intersection((1, 2), (2, 3)) == "NO"
# Test case 2:
assert intersection((-1, 1), (0, 4)) == "NO"
# Test case 3:
assert intersection((-3, -1), (-5, 5)) == "YES"
# Test case 4:
assert intersection((5,10),(8,12)) == "NO"
[/TESTS]
