def triples_sum_to_zero?(numbers)
  numbers.each_with_object(Hash.new(0)) do |num, hash|
    hash[num] += 1
  end
  numbers.each_with_index do |num, i|
    next if i == numbers.length - 1
    other_nums = numbers[i + 1..-1]
    other_nums.each do |other_num|
      sum = num + other_num
      if hash[sum] > 0
        return true
      end
    end
  end
  false
end