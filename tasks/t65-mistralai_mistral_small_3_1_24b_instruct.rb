def circular_shift(x, shift)
  digits = x.to_s.chars
  n = digits.length
  shift %= n
  reversed_digits = digits.reverse
  result = reversed_digits[-shift..-1] + reversed_digits[0...-shift]
  result.join
end