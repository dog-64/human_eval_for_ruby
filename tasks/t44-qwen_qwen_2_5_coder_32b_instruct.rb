def change_base(x, base)
  raise ArgumentError, "Base must be between 2 and 9" unless base.between?(2, 9)
  return "0" if x == 0

  result = ""
  while x > 0
    result.prepend((x % base).to_s)
    x /= base
  end
  result
end