
def change_base(x, base)
  raise ArgumentError, 'x must be non-negative' if x.negative?
  raise ArgumentError, 'Invalid base' unless (2..9).include?(base)
  return '0' if x == 0

  remainders = []
  while x > 0
    remainders << x % base
    x = x.divide(base)
  end

  remainders.reverse.map(&:to_s).join
end

 