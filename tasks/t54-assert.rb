assert same_chars?('eabcdzzzz', 'dddzzzzzzzddeddabc') == true
assert same_chars?('abcd', 'dddddddabc') == true
assert same_chars?('dddddddabc', 'abcd') == true
assert same_chars?('eabcd', 'dddddddabc') == false
assert same_chars?('abcd', 'dddddddabce') == false
assert same_chars?('eabcdzzzz', 'dddzzzzzzzddddabc') == false
assert same_chars?('abc', 'abc') == true
assert same_chars?('', '') == true
assert same_chars?('a', 'a') == true
assert same_chars?('a', 'aa') == true
assert same_chars?('aa', 'a') == true
assert same_chars?('abc', 'cba') == true
assert same_chars?('abc', 'abcd') == false
assert same_chars?('abcd', 'abc') == false
assert same_chars?('abc', 'ABC') == true
assert same_chars?('AbC', 'abc') == true
assert same_chars?('aBcD', 'dCbA') == true
assert same_chars?(' ', ' ') == true
assert same_chars?('a ', ' a') == true
assert same_chars?('a ', '  a') == true

