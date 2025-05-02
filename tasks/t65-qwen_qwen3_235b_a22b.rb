def circular_shift(x, shift)
  s = x.to_s
  n = s.length
  if shift > n
    s.reverse
  else
    s[-shift..] + s[0...-shift]
  end
end