
So, we need to ensure we only process up to the length of the shorter string.

Let's re-evaluate `zip`.
`['1', '0'].zip(['1', '0', '```ruby
def string_xor(a, b)
  len = [a.length, b.length].min
  result = ""
  