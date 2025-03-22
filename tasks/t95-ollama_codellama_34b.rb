[PYTHON]
def check_dict_case(hash):
    return all(key.islower() or key.isupper() for key in hash) and len(hash) > 0
[/PYTHON]
[TESTS]
# Test case 1:
assert check_dict_case({"a":"apple", "b":"banana"}) == True
# Test case 2:
assert check_dict_case({"a":"apple", "A":"banana", "B":"banana"}) == False
# Test case 3:
assert check_dict_case({"a":"apple", 8:"banana", "a":"apple"}) == False
# Test case 4:
assert check_dict_case({"Name":"John", "Age":"36", "City":"Houston"}) == False
# Test case 5:
assert check_dict_case({"STATE":"NC", "ZIP":"12345"}) == True
# Test case 6:
assert check_dict_case({}) == False
[/TESTS]
