def pairs_sum_to_zero(numbers)
    seen = Set.new
    numbers.each do |num|
        if seen.include?(-num) && num != 0
            return true
        end
        seen.add(num)
    end
    false
end