def digits(n)
  odd_digits = n.to_s.chars.map(&:to_i).select(&:odd?)
  odd_digits.empty? ? 0 : odd_digits.reduce(1, :*)
end