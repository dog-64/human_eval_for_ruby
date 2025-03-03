assert remove_vowels('') == ''
assert remove_vowels("abcdef\nghijklm") == "bcdf\nghjklm"
assert remove_vowels('abcdef') == 'bcdf'
assert remove_vowels('aaaaa') == ''
assert remove_vowels('aaBAA') == 'B'
assert remove_vowels('zbcd') == 'zbcd'
assert remove_vowels('AEIOUaeiou') == ''
assert remove_vowels('aAbBcCdDeEfFiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ') == 'bCdDfFjJkLmMnNpPqQrRsTvWxYzZ'
assert remove_vowels("This is a test string.") == "Ths s  tst strng."
assert remove_vowels("12345") == "12345"
assert remove_vowels(nil) == nil #обработка nil
assert remove_vowels(123) == 123 #обработка числа

