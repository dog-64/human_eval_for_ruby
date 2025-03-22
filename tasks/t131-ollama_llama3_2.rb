def digits(n)
  n.to_s.chars.map(&:to_i).select { |i| i.odd? }.inject(:*) || 0
end