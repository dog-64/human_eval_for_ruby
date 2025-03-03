assert truncate_number(3.5) == 0.5
assert truncate_number(10.0) == 0.0
assert truncate_number(0.75) == 0.75
assert truncate_number(0.0) == 0.0
assert truncate_number(12345.6789) == 0.6789
assert truncate_number(1.0) == 0.0
assert truncate_number(0.999999) == 0.999999
assert truncate_number(1000000.0) == 0.0

