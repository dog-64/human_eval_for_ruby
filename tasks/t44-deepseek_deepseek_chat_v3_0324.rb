def change_base(x, base)
  raise ArgumentError, "x must be non-negative" if x < 0
  raise ArgumentError, "base must be between 2 and 9" unless (2..9).cover?(base)

  return "0" if x == 0

  digits = []
  while x > 0
    digits << (x % base).to_s
    x /= base
  end
  digits.reverse.join
end