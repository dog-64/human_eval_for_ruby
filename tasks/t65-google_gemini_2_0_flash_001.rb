def circular_shift(x, shift)
  s = x.to_s
  n = s.length
  shift %= n if n > 0
  s = s.chars
  shifted = s.rotate(-shift)
  shifted.join
end