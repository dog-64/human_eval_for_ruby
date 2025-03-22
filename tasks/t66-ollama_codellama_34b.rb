
def digit_sum(s)
  s.upcase.chars.select { |c| c =~ /[A-Z]/ }.map(&:ord).reduce(0, :+)
end