def change_base(x, base)
  raise ArgumentError, "Base must be between 2 and 9" unless (2..9).include?(base)
  raise ArgumentError, "x must be a non-negative integer" unless x.is_a?(Integer) && x >= 0

  result = ''
  while x > 0
    result = (x % base).to_s + result
    x /= base
  end
  result.empty? ? '0' : result
end