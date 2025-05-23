assert compare_one(1, 2.5) == 2.5
assert compare_one(1, "2,3") == "2,3"
assert compare_one("5,1", "6") == "6"
assert compare_one("1", 1) == nil
assert compare_one(3.14, "3.14") == nil
assert compare_one("-10", -5) == -5
assert compare_one(10, 10) == nil
assert compare_one(10.5, 10.5) == nil
assert compare_one("10.5", "10.5") == nil
assert compare_one("1", "2") == "2"
assert compare_one("2.5", "2.5") == "2,5"
assert compare_one(-5, -10) == -5
assert compare_one(-5.5, -5) == -5
assert compare_one("-5.5", "-5") == "-5"
assert compare_one(0, 0) == nil
assert compare_one(0, "0") == nil
assert compare_one("0", 0.0) == nil
assert compare_one("0.0", 0) == nil
assert compare_one(1000, 999) == 1000
assert compare_one("1000", "999") == "1000"
assert compare_one(1000.0, 999.9) == 1000.0
assert compare_one("-1000", "-999") == "-999"
assert compare_one(-1000.0, -999.9) == -999.9
