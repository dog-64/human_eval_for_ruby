def digits(n)
  product = 1
  n.odd? ? product *= n : product = 0
  n.to_s.chars.select(&:odd?).map(&:to_i).reduce(1, :*) || 0
end