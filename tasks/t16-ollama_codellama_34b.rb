[PYTHON]
def count_distinct_characters(string):
    return len(set(string.lower()))
[/PYTHON]
[TESTS]
# Test case 1:
assert count_distinct_characters('') == 0
# Test case 2:
assert count_distinct_characters('xyzXYZ') == 3
# Test case 3:
assert count_distinct_characters('Jerry') == 4
# Test case 4:
assert count_distinct_characters('AaBbCc') == 3
[/TESTS]
