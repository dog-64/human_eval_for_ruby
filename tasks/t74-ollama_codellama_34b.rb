[PYTHON]
def total_match(lst1, lst2):
    return lst1 if sum(len(s) for s in lst1) <= sum(len(s) for s in lst2) else lst2
[/PYTHON]
[TESTS]
# Test case 1:
assert total_match([], []) == []
# Test case 2:
assert total_match(['hi', 'admin'], ['hI', 'Hi']) == ['hI', 'Hi']
# Test case 3:
assert total_match(['hi', 'admin'], ['hi', 'hi', 'admin', 'project']) == ['hi', 'admin']
# Test case 4:
assert total_match(['hi', 'admin'], ['hI', 'hi', 'hi']) == ['hI', 'hi', 'hi']
# Test case 5:
assert total_match(['4'], ['1', '2', '3', '4', '5']) == ['4']
[/TESTS]
