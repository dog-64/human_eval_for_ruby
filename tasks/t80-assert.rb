# проверено - на самом деле никто не проходит
assert is_happy?("") == false
assert is_happy?("a") == false
assert is_happy?("aa") == false
# не проходят
assert is_happy?("aabb") == false
assert is_happy?("abc") == true
assert is_happy?("abcabc") == true
assert is_happy?("abcabcabc") == true
assert is_happy?("abcdefg") == true
assert is_happy?("adb") == true
# не проходят
assert is_happy?("xyy") == false
assert is_happy?("xyz") == true
