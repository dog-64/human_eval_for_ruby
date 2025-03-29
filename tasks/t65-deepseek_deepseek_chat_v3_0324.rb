def circular_shift(x, shift)
  digits = x.to_s.chars
  return digits.join if digits.empty? || shift.zero?

  shift %= digits.size if shift >= digits.size
  shifted = digits[-shift..-1] + digits[0...-shift]
  shifted.join
end