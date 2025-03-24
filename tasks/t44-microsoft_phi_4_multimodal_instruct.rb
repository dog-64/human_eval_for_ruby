def change_base(x, base)
  return 'Error: Base out of range' unless (2..9).cover?(base)
  return 'Error: Negative input' unless x >= 0

  result = ''
  while x > 0
    result = (x % base).to_s + result
    x /= base
  end
  result.empty? ? '0' : result
end
