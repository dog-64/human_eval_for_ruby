def change_base(x, base)
  raise ArgumentError, "x must be non-negative" if x < 0
  raise ArgumentError, "base must be between 2 and 9" unless (2..9).include?(base)
  return "0" if x == 0
  result = ""
  while x > 0
    result = (x % base).to_s + result
    x /= base
  end
  result
end
