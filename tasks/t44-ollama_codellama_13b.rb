def change_base(x, base)
  raise ArgumentError, "Invalid base" if base < 2 || base > 9
  raise ArgumentError, "Negative number" if x < 0
  
  result = ""
  while x > 0
    result = (x % base).to_s + result
    x /= base
  end
  
  return result
end