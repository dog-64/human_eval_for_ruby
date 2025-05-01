def change_base(x, base)
  raise ArgumentError, "Base must be between 2 and 9" unless base.between?(2, 9)
  raise ArgumentError, "Number must be non-negative" if x < 0

  return "0" if x == 0

  result = ""
  while x > 0
    remainder = x % base
    result = remainder.to_s + result
    x /= base
  end
  result
end