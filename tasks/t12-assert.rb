assert longest([]) == nil
assert longest(['a', 'b', 'c']) == 'a'
assert longest(['a', 'bb', 'ccc']) == 'ccc'
assert longest(['abcd', 'efg', 'hijklmn']) == 'hijklmn'
assert longest(['xyz', 'xyz']) == 'xyz'
assert longest(['', 'a']) == 'a'
assert longest(['a', '']) == 'a'
assert longest(['']) == ''
assert longest([""]) == ""
assert longest(["abc", "def", "ghi"]) == "abc"

