[PYTHON]
def unique(my_list):
    return sorted(set(my_list), key=my_list.index)
[/PYTHON]
[TESTS]
# Test case 1:
assert unique([3, 5, 2, 3, 5, 9, 0]) == [0, 2, 3, 5, 9]
# Test case 2:
assert unique([]) == []
# Test case 3:
assert unique(["a", "b", "c", "a", "b", "c"]) == ["a", "b", "c"]
[/TESTS]
