area_result = triangle_area(5, 3)
assert area_result == 7.5
area_result = triangle_area(10, 5)
assert area_result == 25.0
area_result = triangle_area(2.5, 4.2)
assert area_result == 5.25
area_result = triangle_area(1, 1)
assert area_result == 0.5
area_result = triangle_area(100, 100)
assert area_result == 5000.0
assert_raises(StandardError) { triangle_area(-5, 3) }
assert_raises(StandardError) { triangle_area(5, -3) }
assert_raises(StandardError) { triangle_area(-5, -3) }
assert_raises(StandardError) { triangle_area(0, 3) }
assert_raises(StandardError) { triangle_area(5, 0) }
assert_raises(StandardError) { triangle_area(0, 0) }
