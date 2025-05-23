assert total_match([], []) == []
assert total_match(['hi', 'admin'], ['hI', 'Hi']) == ['hI', 'Hi']
assert total_match(['hi', 'admin'], ['hi', 'hi', 'admin', 'project']) == ['hi', 'admin']
assert total_match(['hi', 'admin'], ['hI', 'hi', 'hi']) == ['hI', 'hi', 'hi']
assert total_match(['4'], ['1', '2', '3', '4', '5']) == ['4']
assert total_match(['a' * 1000], ['a' * 999]) == ['a' * 999]
assert total_match(['a' * 1000], ['a' * 1001]) == ['a' * 1000]
assert total_match([''], ['']) == ['']
assert total_match(['longstring'], ['']) == ['']
assert total_match([''], ['longstring']) == ['']
assert total_match([""], ["a"]) == [""]
assert total_match(["a"], [""]) == [""]
assert total_match(["a", "b"], ["c"]) == ["c"]

