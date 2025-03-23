def change_base(x, base)
  raise ArgumentError, "Base must be between 2 and 9" unless (2..9).include?(base)
  raise ArgumentError, "x must be a non-negative integer" unless x >= 0 && x.is_a?(Integer)

  return "0" if x == 0

  digits = []
  while x > 0
    digits << (x % base).to_s
    x /= base
  end

  digits.reverse.join
end