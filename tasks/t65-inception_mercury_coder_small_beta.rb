def circular_shift(x, shift)
  digits = x.to_s.chars
  length = digits.length
  shift = shift % length if shift >= length
  shifted_digits = digits[-shift..-1] + digits[0...-shift]
  shifted_digits.join
end