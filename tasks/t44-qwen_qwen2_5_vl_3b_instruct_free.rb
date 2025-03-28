def change_base(x, base)
  return "Error: Base must be between 2 and 9." unless base.between?(2, 9)
  return "0" if x == 0
  result = ""
  while x > 0
    result = (x % base).to_s + result
    x /= base
  end
  result
end