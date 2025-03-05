def sort_third(l)
  indices = (0...l.length).select { |i| i % 3 == 0 }
  sorted_values = l.values_at(*indices).sort
  l.dup.tap do |result|
    indices.each_with_index { |original_index, sorted_index| result[original_index] = sorted_values[sorted_index] }
  end
end
```ruby
def sort_third(l)
  indices = (0...l.length).select { |i| i % 3 == 0 }
  sorted_values = l.values_at(*indices).sort
  l.dup.tap do |result|
    indices.each_with_index { |original_index, sorted_index| result[original_index] = sorted_values[sorted_index] }
  end
end
```