
require 'set'

def pairs_sum_to_zero(numbers)
  seen = Set.new
  numbers.each do |num|
    if num != 0
      if seen.include?(-num)
        return true
      end
      seen.add(num)
    end
  end
  false
end