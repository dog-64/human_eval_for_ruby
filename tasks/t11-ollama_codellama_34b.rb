[PYTHON]
def string_xor(a, b):
    result = ""
    for i in range(min(len(a), len(b))):
        if a[i] == '0' and b[i] == '0':
            result += '0'
        elif a[i] == '1' and b[i] == '1':
            result += '0'
        else:
            result += '1'
    return result
[/PYTHON]
[TESTS]
# Test case 1:
assert string_xor('010', '110') == '100'
# Test case 2:
assert string_xor('1011', '0101') == '1110'
# Test case 3:
assert string_xor('1', '0') == '1'
# Test case 4:
assert string_xor('', '101') == ''
# Test case 5:
assert string_xor('11111', '01010') == '10101'
[/TESTS]
