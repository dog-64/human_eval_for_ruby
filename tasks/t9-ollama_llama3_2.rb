def rolling_max(numbers)
  return [] if numbers.empty?
  max = [numbers.first]
  numbers.each_cons(2) do |a, b|
    max << [max.last, b].max
  end
  max
end