def digits(n)
  odd_digits = n.to_s.chars.map(&:to_i).select(&:odd?)
  return 0 if odd_digits.empty?
  odd_digits.inject(1, :*)
end