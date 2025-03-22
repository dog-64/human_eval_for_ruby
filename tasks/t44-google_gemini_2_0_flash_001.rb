def change_base(x, base)
  if x < 0 || base < 2 || base > 9
    raise ArgumentError.new("x must be non-negative and base must be between 2 and 9")
  end

  if x == 0
    return "0"
  end

  result = ""
  while x > 0
    result = (x % base).to_s + result
    x /= base
  end
  result
end