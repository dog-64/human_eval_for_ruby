def circular_shift(x, shift)
  s = x.to_s
  len = s.length
  
  if shift >= len
    return s.reverse
  end
  
  shifted_s = s[-shift..-1] + s[0..-(shift + 1)]
  shifted_s
end