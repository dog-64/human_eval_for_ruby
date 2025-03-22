def circular_shift(x, shift)
  digits = x.to_s.chars
  n = digits.size
  shift = shift % n
  (digits[-shift..-1] + digits[0...-shift]).join
end