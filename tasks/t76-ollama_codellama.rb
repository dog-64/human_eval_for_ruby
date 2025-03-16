def is_simple_power?(x, n)
  return false if x < 0 || n < 0
  int = Math.log(x, n).to_i
  n**int == x
end
