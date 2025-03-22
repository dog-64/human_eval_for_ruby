require 'set'

def pairs_sum_to_zero(numbers)
  s = numbers.to_set
  s.each do |num|
    next if num.zero?
    return true if s.include?(-num)
  end
  false
end