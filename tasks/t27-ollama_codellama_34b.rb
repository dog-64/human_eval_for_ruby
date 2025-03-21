[PYTHON]
def flip_case(string):
    return string.swapcase()
[/PYTHON]
[TESTS]
# Test case 1:
assert flip_case("") == ""
# Test case 2:
assert flip_case("hello") == "HELLO"
# Test case 3:
assert flip_case("Hello World") == "hELLO wORLD"
# Test case 4:
assert flip_case("The quick brown fox jumps over the lazy dog") == "tHE qUICK bROWN fOX jUMPS oVER tHE lAZY dOG"
[/TESTS]
