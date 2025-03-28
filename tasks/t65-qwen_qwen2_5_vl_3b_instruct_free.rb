def circular_shift(x, shift)
  digits = x.to_s.chars
  shift %= digits.length
  digits.rotate(shift).join
end