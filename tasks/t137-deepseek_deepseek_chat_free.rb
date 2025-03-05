def compare_one(a, b)
  a_num = a.is_a?(String) ? a.tr(',', '.').to_f : a
  b_num = b.is_a?(String) ? b.tr(',', '.').to_f : b
  return nil if a_num == b_num
  a_num > b_num ? a : b
end
```ruby
def compare_one(a, b)
  a_num = a.is_a?(String) ? a.tr(',', '.').to_f : a
  b_num = b.is_a?(String) ? b.tr(',', '.').to_f : b
  return nil if a_num == b_num
  a_num > b_num ? a : b
end
```