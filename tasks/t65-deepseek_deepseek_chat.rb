def circular_shift(x, shift)
  digits = x.to_s.chars
  shift %= digits.length if digits.length > 0
  digits.rotate(-shift).join
end