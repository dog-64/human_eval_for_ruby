def digits(n)
  n.to_s.chars.map(&:to_i).select(&:odd?).reduce(1, :*) rescue 0
end