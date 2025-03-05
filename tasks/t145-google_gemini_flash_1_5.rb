```ruby
def order_by_points(nums)
  nums.map.with_index.sort_by { |num, index| [num.abs.to_s.chars.map(&:to_i).sum, index] }.map(&:first)
end
```
