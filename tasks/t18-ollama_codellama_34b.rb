[PYTHON]
def how_many_times(string, substring):
    count = 0
    for i in range(len(string)):
        if string[i:].startswith(substring):
            count += 1
    return count
[/PYTHON]
[TESTS]
# Test case 1:
assert how_many_times("", "a") == 0
# Test case 2:
assert how_many_times("aaa", "a") == 3
# Test case 3:
assert how_many_times("aaaa", "aa") == 3
# Test case 4:
assert how_many_times("abababa", "aba") == 3
# Test case 5:
assert how_many_times("Mississippi", "iss") == 2
[/TESTS]
