assert count_upper('aBCdEf') == 1
assert count_upper('abcdefg') == 0
assert count_upper('dBBE') == 0
assert count_upper("AEIOU") == 2
assert count_upper("") == 0
assert count_upper("AaEiOu") == 2
assert count_upper("A") == 1
assert count_upper("a") == 0
assert count_upper("AEIOUaeiou") == 2
assert count_upper("12345") == 0
assert count_upper("A1E3I5O7U9") == 2

