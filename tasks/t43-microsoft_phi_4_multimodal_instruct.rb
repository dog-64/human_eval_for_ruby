def pairs_sum_to_zero(numbers)
  number_set = new_set(numbers)
  numbers.each do |num|
    return true if number_set.include?(-num)
  end
  false
end

def new_set(array)
  set = {}
  array.each { |el| set[el] = true if set.empty? }
  set
end