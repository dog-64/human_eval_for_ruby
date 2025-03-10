def change_base(x, base)
  return "0" if x == 0
  digits = []
  while x > 0
    digits << (x % base)
    x /= base
  end
  digits.reverse.join
end