[PYTHON]
def count_upper(s):
    count = 0
    for i, char in enumerate(s):
        if i % 2 == 0 and char.isupper():
            count += 1
    return count
[/PYTHON]
[TESTS]
# Test case 1:
assert count_upper('') == 0
# Test case 2:
assert count_upper('abcdefg') == 0
# Test case 3:
assert count_upper('dBBE') == 0
# Test case 4:
assert count_upper('aBCdEf') == 1
# Test case 5:
assert count_upper("AEIOU") == 2
# Test case 6:
assert count_upper("") == 0
[/TESTS]
