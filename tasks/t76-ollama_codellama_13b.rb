def is_simple_power?(x, n)
  return false if x < 0 || n < 0
  int = Math.log(x, n).to_i
  n**int == x
end
is_simple_power?(1, 4) # => true (4**0 = 1)
is_simple_power?(2, 2) # => true (2**1 = 2)
is_simple_power?(8, 2) # => true (2**3 = 8)
is_simple_power?(3, 2) # => false
is_simple_power?(3, 1) # => false
is_simple_power?(5, 3) # => false
is_simple_power?(0, 0) # => false (0**0 is not defined)
is_simple_power?(-8, 2) # => false (function only works with non-negative integers)