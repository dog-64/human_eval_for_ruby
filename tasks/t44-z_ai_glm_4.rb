
def change_base(x, base)
  raise ArgumentError, "Base must be between 2 and 9" unless base.between?(2, 9)
  return "0" if x.zero?

  digits = []
  num = x

  while num > 0
    remainder = num % base
    digits << remainder.to_s
    num /= base
  end

  digits.reverse.join
end