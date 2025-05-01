def circular_shift(x, shift)
  s = x.to_s
  len = s.length
  if shift >= len
    s.reverse
  else
    s[-shift..-1] + s[0...-shift]
  end
end