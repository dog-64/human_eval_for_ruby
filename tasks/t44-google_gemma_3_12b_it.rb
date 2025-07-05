def change_base(x, base)
  if x < 0 || base < 2 || base > 9
    raise ArgumentError, "Invalid input: x must be non-negative and base must be between 2 and 9"
  end

  if x == 0
    return "0"
  end

  digits = []
  while x > 0
    digits << (x % base).to_s
    x /= base
  end

  digits.reverse.join
end
