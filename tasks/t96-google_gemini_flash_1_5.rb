```ruby
def count_up_to(n)
  return [] if n <= 1
  primes = []
  num = 2
  while primes.length < n
    is_prime = true
    (2..Math.sqrt(num)).each do |i|
      if num % i == 0
        is_prime = false
        break
      end
    end
    primes << num if is_prime
    num += 1
  end
  primes.select {|p| p < n}
end
```
