[PYTHON]
def same_chars?(s0, s1)
    return s0.downcase.chars.sort == s1.downcase.chars.sort
end
[/PYTHON]
[TESTS]
# Test case 1:
assert_equal(true, same_chars?('eabcdzzzz', 'dddzzzzzzzddeddabc'))
# Test case 2:
assert_equal(true, same_chars?('abcd', 'dddddddabc'))
# Test case 3:
assert_equal(true, same_chars?('dddddddabc', 'abcd'))
# Test case 4:
assert_equal(false, same_chars?('eabcd', 'dddddddabc'))
# Test case 5:
assert_equal(false, same_chars?('abcd', 'dddddddabce'))
# Test case 6:
assert_equal(false, same_chars?('eabcdzzzz', 'dddzzzzzzzddddabc'))
# Test case 7:
assert_equal(true, same_chars?('', ''))
# Test case 8:
assert_equal(false, same_chars?('', 'a'))
# Test case 9:
assert_equal(false, same_chars?('a', ''))
# Test case 10:
assert_equal(true, same_chars?('a', 'a'))
[/TESTS]
