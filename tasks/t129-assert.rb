```ruby
assert min_path([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 3) == [1, 2, 1]
assert min_path([[5, 9, 3], [4, 1, 6], [7, 8, 2]], 1) == [1]
assert min_path([[1, 2], [3, 4]], 2) == [1, 2]
assert min_path([[1, 2], [3, 4]], 4) == [1, 2, 3, 4]
assert min_path([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]], 5) == [1, 2, 1, 2, 1]
assert min_path([[16, 15, 14, 13], [12, 11, 10, 9], [8, 7, 6, 5], [4, 3, 2, 1]], 5) == [1, 2, 3, 4, 1]
assert_raises(ArgumentError) { min_path([[1, 2], [3]], 3) } #Не квадратная матрица
assert_raises(ArgumentError) { min_path([[1, 2], [3, 4]], 0) } #k <=0
assert_raises(ArgumentError) { min_path([[1, 2], [3, 4]], -1) } #k <0
assert_raises(ArgumentError) { min_path([], 3) } #пустой массив
assert_raises(ArgumentError) { min_path([[1,2],[3,4]], 5)} #k больше чем размер сетки

```
