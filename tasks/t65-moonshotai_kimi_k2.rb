def circular_shift(x, shift)
  digits = x.to_s.chars
  return x.to_s if digits.empty?
  
  if shift > digits.length
    digits.reverse.join
  else
    shift = shift % digits.length
    digits.rotate(-shift).join
  end
end