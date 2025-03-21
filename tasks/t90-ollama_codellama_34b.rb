[PYTHON]
def next_smallest(my_list):
    if len(my_list) < 2:
        return None
    sorted_list = sorted(my_list)
    previous_item = sorted_list[0]
    for item in sorted_list[1:]:
        if item != previous_item:
            return item
    return None
[/PYTHON]
[TESTS]
# Test case 1:
assert next_smallest([]) == None
# Test case 2:
assert next_smallest([1]) == None
# Test case 3:
assert next_smallest([1, 2, 3]) == 2
# Test case 4:
assert next_smallest([1, 1, 1]) == None
# Test case 5:
assert next_smallest([1, 2, 3, 4]) == 2
[/TESTS]
