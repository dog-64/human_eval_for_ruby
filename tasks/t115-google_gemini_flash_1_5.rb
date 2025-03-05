```ruby
def max_fill(grid, capacity)
  total_water = 0
  grid.each do |row|
    total_water += row.sum
  end
  (total_water + capacity - 1) / capacity
end
```
