assert is_nested?('[[]]') == true
assert is_nested?('[]]]]]]][[[[[]') == false
assert is_nested?('[][]') == false
assert is_nested?('[]') == false
assert is_nested?('[[][]]') == true
assert is_nested?('[[]][[') == true
assert is_nested?('[[[]]]') == true
assert is_nested?('[][[[]]]') == true
assert is_nested?('[[[[]]]]') == true
assert is_nested?('[[') == false
assert is_nested?(']]') == false
assert is_nested?('') == false
assert is_nested?('][') == false
assert is_nested?('[][][]') == false
assert is_nested?('[[[]') == false
assert is_nested?('[]][]') == false

