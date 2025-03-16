def digit_sum(s)
  s.chars.select { |c| c =~ /[A-Z]/ }.sum(&:ord)
end