```ruby
def poly(xs, x)
  xs.reverse.each_with_index.inject(0) { |sum, (coeff, i)| sum + coeff * (x**i) }
end

def find_zero(xs)
  raise ArgumentError, "xs must have an even number of elements" unless xs.size.even?
  raise ArgumentError, "leading coefficient cannot be zero" if xs.last == 0

  left = -100.0
  right = 100.0

  while (right - left).abs > 1e-6
    mid = (left + right) / 2.0
    if poly(xs, mid) * poly(xs, right) < 0
      left = mid
    else
      right = mid
    end
  end
  (left + right) / 2.0
end
```
