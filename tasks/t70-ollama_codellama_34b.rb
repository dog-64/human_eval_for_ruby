[PYTHON]
def strange_sort_list(lst):
    sorted_list = []
    while lst:
        min_value = min(lst)
        max_value = max(lst)
        sorted_list.extend([min_value, max_value])
        lst.remove(min_value)
        lst.remove(max_value)
    return sorted_list
[/PYTHON]
[TESTS]
# Test case 1:
assert strange_sort_list([]) == []
# Test case 2:
assert strange_sort_list([1, 2, 3, 4]) == [1, 4, 2, 3]
# Test case 3:
assert strange_sort_list([5, 5, 5, 5]) == [5, 5, 5, 5]
# Test case 4:
assert strange_sort_list([-1, 0, 1, 2, -2]) == [-2, 2, -1, 1, 0]
[/TESTS]
