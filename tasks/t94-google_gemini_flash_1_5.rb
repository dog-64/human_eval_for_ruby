```ruby
def sum_largest_prime_digits(numbers)
  largest_prime = 0
  numbers.each do |num|
    if num > 1 && is_prime?(num)
      largest_prime = num if num > largest_prime
    end
  end
  return 0 if largest_prime == 0
  sum_digits(largest_prime)
end

def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def sum_digits(num)
  num.to_s.chars.map(&:to_i).sum
end
```
