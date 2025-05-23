assert get_closest_vowel("yogurt") == "u"
assert get_closest_vowel("FULL") == "U"
assert get_closest_vowel("quick") == ""
assert get_closest_vowel("ab") == ""
assert get_closest_vowel("rhythm") == ""
assert get_closest_vowel("aeiou") == ""
assert get_closest_vowel("bcdfghjklmnpqrstvwxyz") == ""
assert get_closest_vowel("a") == ""
assert get_closest_vowel("") == ""
assert get_closest_vowel("AEIOU") == ""
assert get_closest_vowel("bcdEfghij") == "i"
assert get_closest_vowel("bcdfghjklmnOpqrstvwxyz") == "O"
assert get_closest_vowel("bcdfghjklmnpqrstvwxYz") == ""
assert get_closest_vowel("programming") == "i"
assert get_closest_vowel("testcase") == "a"
assert get_closest_vowel("Example") == "a"
