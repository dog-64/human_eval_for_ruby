def digit_sum(s)
  s.upcase.each_char.select { |c| c =~ /[A-Z]/ }.map(&:ord).sum
end