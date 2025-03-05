def circular_shift(x, shift)
  digits = x.to_s.chars
  n = digits.length
  shift %= n if n != 0
  shifted = digits[-shift..-1] + digits[0...-shift]
  shifted.join
end
```ruby
def circular_shift(x, shift)
  digits = x.to_s.chars
  n = digits.length
  shift %= n if n != 0
  shifted = digits[-shift..-1] + digits[0...-shift]
  shifted.join
end
```