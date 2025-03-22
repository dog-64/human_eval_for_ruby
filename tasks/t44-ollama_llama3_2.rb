def change_base(x, base)
  if x < 0
    raise ArgumentError, 'x must be a non-negative integer'
  end
  result = ''
  while x > 0
    result = (x % base).to_s + result
    x /= base
  end
  result.empty? ? '0' : result
end