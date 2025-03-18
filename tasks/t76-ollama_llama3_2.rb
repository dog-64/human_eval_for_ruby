def is_simple_power?(x, n)
  return false if x < 1 || n == 0
  (i = 0) until i * Math.log(x).to_f / Math.log(n) < x
  return true if n ** i == x
  false
end