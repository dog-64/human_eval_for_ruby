
 the list.

Using `select`:
```ruby
def largest_smallest_integers(lst)
  negatives = lst.select { |n| n < 0 }
  
`lst.partition { |n| n < 0 }` will return `