assert simplify("1/5", "5/1") == true
assert simplify("1/6", "2/1") == false
assert simplify("7/10", "10/2") == false
assert simplify("3/4", "8/6") == false
assert simplify("2/3", "6/4") == true
assert simplify("1/1", "1/1") == true
assert simplify("100/1", "1/100") == true
assert simplify("1/100", "100/1") == true
assert simplify("1/2", "2/1") == true
assert simplify("2/1", "1/2") == true
assert simplify("1/10", "20/1") == true
assert simplify("10/1", "1/20") == false
assert simplify("10/1", "1/20") == false
assert simplify("1000/1", "1/1000") == true
assert simplify("1/1000", "1000/1") == true
assert simplify("1000000/1", "1/1000000") == true
assert simplify("1/1000000", "1000000/1") == true

