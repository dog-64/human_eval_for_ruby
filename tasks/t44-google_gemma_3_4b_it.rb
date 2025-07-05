def change_base(x, base)
  raise ArgumentError, "Base must be between 2 and 9" if base < 2 || base > 9

  if x == 0
    return "0"
  end

  digits = []
  while x > 0
    remainder = x % base
    digits.unshift(remainder.to_s)
    x = x / base
  end

  digits.join
end
