[PYTHON]
def hex_key(hex_string):
    count = 0
    for char in hex_string:
        if char in "0123456789":
            count += 1
        elif char in "ABCDEF":
            count += 2
        else:
            count += 3
    return count
[/PYTHON]
[TESTS]
# Test case 1:
assert hex_key("") == 0
# Test case 2:
assert hex_key("AB") == 1
# Test case 3:
assert hex_key("1077E") == 2
# Test case 4:
assert hex_key("ABED1A33") == 4
# Test case 5:
assert hex_key("123456789ABCDEF0") == 6
# Test case 6:
assert hex_key("2020") == 2
# Test case 7:
assert hex_key("ABED1A33") == 4

[/TESTS]
