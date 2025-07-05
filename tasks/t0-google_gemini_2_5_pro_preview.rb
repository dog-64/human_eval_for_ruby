
0, 3.0], 0.5)`
  - `numbers.length` is 3, not less than 2.
  - Combinations:
    - `[1```ruby
def has_close_elements(numbers, threshold)
  return false if numbers.length < 2

  numbers.combination(2).any? do