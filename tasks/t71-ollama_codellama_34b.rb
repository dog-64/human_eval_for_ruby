[PYTHON]
def triangle_area(a, b, c):
    if a <= 0 or b <= 0 or c <= 0:
        return -1
    semi_perimeter = (a + b + c) / 2
    area = (semi_perimeter * (semi_perimeter - a) * (semi_perimeter - b) * (semi_perimeter - c)) ** 0.5
    return round(area, 2)
[/PYTHON]
[TESTS]
# Test case 1:
assert triangle_area(3, 4, 5) == 6.0
# Test case 2:
assert triangle_area(1, 2, 10) == -1
# Test case 3:
assert triangle_area(5, 12, 13) == 30.0
# Test case 4:
assert triangle_area(0, 4, 5) == -1
# Test case 5:
assert triangle_area(3, 4, -5) == -1
# Test case 6:
assert triangle_area(3, 4, 5, 6) == -1
[/TESTS]
