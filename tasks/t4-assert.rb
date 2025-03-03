assert mean_absolute_deviation([1.0, 2.0, 3.0, 4.0]) == 1.0
assert mean_absolute_deviation([1.0, 1.0, 1.0, 1.0]) == 0.0
assert mean_absolute_deviation([]) == 0.0
assert mean_absolute_deviation([10.5, 20.2, 30.7, 40.1]) == 10.125
assert mean_absolute_deviation([5.0]) == 0.0
assert mean_absolute_deviation([-1.0, 0.0, 1.0]) == 0.6666666666666666
assert mean_absolute_deviation([1.0, 2.0, 3.0, 4.0, 5.0]) == 1.6
assert mean_absolute_deviation([1.1, 2.2, 3.3, 4.4]) == 1.1
assert mean_absolute_deviation([0.0]) == 0.0
assert mean_absolute_deviation([-2.5, -1.5, 0.5, 1.5, 2.5]) == 1.5

