def digit_sum(s)
  s.scan(/[A-Z]/).map(&:ord).sum
end