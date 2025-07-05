
 3. `11 % 3 != 0`. The block returns `false`. `none?` continues. The range is exhausted. `none?` returns `true`. Correct.

def is_prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n.even