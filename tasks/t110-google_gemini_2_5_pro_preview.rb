
 odd/even numbers.
- `num.odd?` or `num % 2 != 0` for odd.
- `num.even?` or `num % 2 == 0` for even.

Let'```ruby
def exchange(lst1, lst2)
  odd_numbers_in_lst1 = lst1.count(&:odd?)
  
  return "