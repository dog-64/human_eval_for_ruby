def change_base(x, base)
  raise ArgumentError, "Base must be between 2 and 9" unless base.between?(2, 9)
  raise ArgumentError, "X must be a non-negative integer" unless x >= 0

  result = ""
  loop do
    remainder = x % base
    result = remainder.to_s + result
    x /= base
    break if x == 0
  end
  result
end