[PYTHON]
def rounded_avg(n, m):
    if n > m:
        return -1
    return bin(int((n + m) / 2))[2:]
[/PYTHON]
[TESTS]
# Test case 1:
assert rounded_avg(1, 5) == "0b11"
# Test case 2:
assert rounded_avg(7, 5) == -1
# Test case 3:
assert rounded_avg(10, 20) == "0b1111"
# Test case 4:
assert rounded_avg(20, 33) == "0b11010"
[/TESTS]
