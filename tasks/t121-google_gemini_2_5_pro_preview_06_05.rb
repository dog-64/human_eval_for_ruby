
 2: `select` with index and then `sum`
Ruby's `select` doesn't directly work with indices. But `each_with_index.
` can be chained with `select`.
```ruby
def sum_odd_even_pos