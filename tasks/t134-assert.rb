assert check_last_char_letter?("apple pie") == false
assert check_last_char_letter?("apple pi e") == true
assert check_last_char_letter?("apple pi e ") == false
assert check_last_char_letter?("") == false
assert check_last_char_letter?("a") == true
assert check_last_char_letter?(" a") == true
assert check_last_char_letter?("abc") == false
assert check_last_char_letter?(" abc") == false
assert check_last_char_letter?("a ") == false
assert check_last_char_letter?("  ") == false
assert check_last_char_letter?("a b c") == true
assert check_last_char_letter?("a b c d e f g h i j k l m n o") == true
assert check_last_char_letter?("Z") == true
assert check_last_char_letter?("1") == false
assert check_last_char_letter?("1 ") == false
assert check_last_char_letter?(" a1") == false
assert check_last_char_letter?("a1 ") == false
