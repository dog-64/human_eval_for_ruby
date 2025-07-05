
The problem statement implies that the helper functions might not be needed if the logic can be inlined or if Ruby has built-ins.
Ruby's `(1..n).sum` is good for sum.
For factorial```ruby
def f(n)
  return [] if n == 0

  result = []
  (1..n).each do |i|