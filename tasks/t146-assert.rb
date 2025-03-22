assert special_filter([15, -73, 14, -15]) == 1
assert special_filter([33, -2, -3, 45, 21, 109]) == 2
assert special_filter([-11, 12, 23, 101, 99]) == 2
assert special_filter([]) == 0
assert special_filter([11, 13, 15, 17, 19]) == 5
assert special_filter([-11, -13, -15, -17, -19]) == 0
assert special_filter([10, 20, 30, 40, 50]) == 0
assert special_filter([12, 24, 36, 48, 60]) == 0
assert special_filter([111, 333, 555, 777, 999]) == 5
assert special_filter([-111, -333, -555, -777, -999]) == 0
assert special_filter([101, 103, 105, 107, 109]) == 5
assert special_filter([1, 3, 5, 7, 9]) == 0
assert special_filter([11, 101, 1001]) == 3
assert special_filter([-101, -1001, -10001]) == 0
assert special_filter([21, 43, 65, 87, 109]) == 1
assert special_filter([121, 343, 565, 787, 909]) == 5
