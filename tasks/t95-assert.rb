assert check_dict_case({"a":"apple", "b":"banana"}) == true
assert check_dict_case({"a":"apple", "A":"banana", "B":"banana"}) == false
assert check_dict_case({"a":"apple", 8:"banana", "a":"apple"}) == false
assert check_dict_case({"Name":"John", "Age":"36", "City":"Houston"}) == false
assert check_dict_case({"STATE":"NC", "ZIP":"12345" }) == true
assert check_dict_case({}) == false
assert check_dict_case({"A":1, "B":2}) == true
assert check_dict_case({"a":1, "b":2}) == true
assert check_dict_case({"A":1, "a":2}) == false
assert check_dict_case({1: "a", 2: "b"}) == false
assert check_dict_case({"": "a"}) == false
assert check_dict_case({"a": ""}) == true

