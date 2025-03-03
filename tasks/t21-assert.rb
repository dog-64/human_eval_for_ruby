assert rescale_to_unit([1.0, 2.0, 3.0, 4.0, 5.0]) == [0.0, 0.25, 0.5, 0.75, 1.0]
assert rescale_to_unit([10.0, 20.0, 30.0]) == [0.0, 0.5, 1.0]
assert rescale_to_unit([-1.0, 0.0, 1.0]) == [0.0, 0.5, 1.0]
assert rescale_to_unit([1.0, 5.0]) == [0.0, 1.0]
assert rescale_to_unit([-5.0, -1.0]) == [0.0, 1.0]
assert_raises(ArgumentError) { rescale_to_unit([1.0]) }
assert_raises(ArgumentError) { rescale_to_unit([]) }
assert rescale_to_unit([0.0, 0.0]) == [0.0, 1.0]
assert rescale_to_unit([1.0, 1.0]) == [0.0, 1.0]
assert rescale_to_unit([-1.0, -1.0]) == [0.0, 1.0]

