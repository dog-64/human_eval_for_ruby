[PYTHON]
def sum_largest_prime_digits(numbers):
    if not numbers:
        return 0
    largest_prime = 0
    for num in numbers:
        if is_prime(num) and num > largest_prime:
            largest_prime = num
    return sum(map(int, str(largest_prime)))

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
assert sum_largest_prime_digits([]) == 0
# Test case 2:
assert sum_largest_prime_digits([1]) == 1
# Test case 3:
assert sum_largest_prime_digits([1, 2, 3, 4, 5]) == 5
# Test case 4:
assert sum_largest_prime_digits([1, 2, 3, 4, 5, 7]) == 7
# Test case 5:
assert sum_largest_prime_digits([1, 2, 3, 4, 5, 7, 11]) == 11
[/TESTS]
