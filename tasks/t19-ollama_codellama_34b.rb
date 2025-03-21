[PYTHON]
def sort_numbers(numbers):
    number_words = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    return " ".join(sorted(numbers.split(), key=lambda x: number_words.index(x)))
[/PYTHON]
[TESTS]
# Test case 1:
assert sort_numbers("three one five") == "one three five"
# Test case 2:
assert sort_numbers("two zero nine eight") == "eight nine zero two"
# Test case 3:
assert sort_numbers("one") == "one"
# Test case 4:
assert sort_numbers("") == ""
# Test case 5:
assert sort_numbers("seven three one") == "one seven three"
[/TESTS]
