
`. So returning an array is the correct approach.

Final code:
```ruby
def sum_product(numbers)
  [numbers.sum, numbersThe code is ready.def sum_product(numbers)
  [numbers.sum, numbers.inject(1, :*)]
end