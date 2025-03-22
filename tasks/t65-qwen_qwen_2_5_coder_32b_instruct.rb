def circular_shift(x, shift)
  digits = x.to_s.chars
  length = digits.length
  shift = shift % length
  if shift == 0
    digits.reverse.join
  else
    digits[-shift..-1] + digits[0...-shift].join
  end
end