assert rounded_avg(1, 5) == "0b11"
assert rounded_avg(7, 5) == -1
assert rounded_avg(10, 20) == "0b1111"
assert rounded_avg(20, 33) == "0b11010"
assert rounded_avg(1, 1) == "0b1"
assert rounded_avg(1, 2) == "0b1"
assert rounded_avg(100, 100) == "0b1100100"
assert rounded_avg(1, 100) == "0b1100100"
assert rounded_avg(99, 100) == "0b1100001"
assert rounded_avg(1000, 2000) == "0b11111010001"
assert rounded_avg(1, 3) == "0b10"
assert rounded_avg(2, 2) == "0b10"
assert rounded_avg(5,10) == "0b101"


