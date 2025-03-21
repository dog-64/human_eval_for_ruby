[PYTHON]
def vowels_count(word):
    vowels = ["a", "e", "i", "o", "u"]
    count = 0
    for char in word:
        if char in vowels:
            count += 1
    return count
[/PYTHON]
[TESTS]
# Test case 1:
assert vowels_count("") == 0
# Test case 2:
assert vowels_count("abcde") == 2
# Test case 3:
assert vowels_count("ACEDY") == 3
# Test case 4:
assert vowels_count("rhythm") == 0
# Test case 5:
assert vowels_count("try") == 1
[/TESTS]
